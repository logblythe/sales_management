import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sales_mgmt/bloc/app_bloc_provider.dart';
import 'package:sales_mgmt/models/image_model.dart';
import 'package:sales_mgmt/widgets/carousel_with_indicator.dart';
import 'package:sales_mgmt/widgets/text_with_padding.dart';

class GoalScreen extends StatefulWidget {
  @override
  _GoalScreenState createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  bool dec = false;
  File imageFile;
  int achieved = 0;
  int total = 100;
  int salesRate = 100;
  int salesPerDay = 100;
  double newPercent = 0.0;

  String formattedDate = DateFormat.yMMMMd().format(DateTime.now());
  DateTime selectedDate = DateTime.now();
  String targetDate = DateFormat.yMMMMd().format(DateTime.now());

  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  @override
  void initState() {
    _controller1.addListener(() {
      print("_controller1 text is ${_controller1.text}");
      if (_controller1.text.isNotEmpty &&
          int.parse(removeSymbols(_controller1.text)) <= total) {
        setState(() {
          achieved = int.parse(removeSymbols(_controller1.text));
          newPercent = ((achieved / total)).toDouble();
        });
      }
    });
    _controller2.addListener(() {
      if (_controller2.text.isNotEmpty &&
          int.parse(removeSymbols(_controller2.text)) >= achieved) {
        setState(() {
          total = int.parse(removeSymbols(_controller2.text));
        });
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // appBloc = AppBlocProvider.of(context);
    // appBloc.fetchImages();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller1.dispose();
    _controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            fit: FlexFit.loose,
            child: Padding(
                padding: const EdgeInsets.all(16.0), child: _buildProgress()),
          ),
          Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: _buildCarousel(),
              )),
          Flexible(
            fit: FlexFit.loose,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                _buildSales(),
                _buildDatePick(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProgress() {
    return CircularPercentIndicator(
      animateFromLastPercent: true,
      radius: 120.0,
      lineWidth: 13.0,
      animation: true,
      percent: newPercent,
      center: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextField(
            decoration: InputDecoration.collapsed(hintText: "0"),
            textAlign: TextAlign.center,
            controller: _controller1,
            keyboardType: TextInputType.number,
            inputFormatters: [NumericTextFormatter()],
          ),
          SizedBox(
            height: 3.0,
            child: Center(
              child: Container(
                margin: EdgeInsetsDirectional.only(start: 1.0, end: 1.0),
                height: 5.0,
                color: Colors.red,
              ),
            ),
          ),
          TextField(
            // inputFormatters: [
            //   WhitelistingTextInputFormatter(RegExp(
            //       r"^[1-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?[0-9]?$|^1000000000$"))
            // ],
            decoration: InputDecoration.collapsed(hintText: "0"),
            textAlign: TextAlign.center,
            controller: _controller2,
            keyboardType: TextInputType.number,
            inputFormatters: [NumericTextFormatter()],
          ),
        ],
      ),
      footer: new Text(
        "Sales this week",
        style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
      ),
      circularStrokeCap: CircularStrokeCap.round,
      progressColor: Colors.purple,
    );
  }

  Widget _buildCarousel() {
    // return StreamBuilder<List<ImageModel>>(
    //   stream: appBloc.imageStream,
    //   builder: (context, snapshot) {
    //     if (!snapshot.hasData || snapshot.data == []) {
    //       return carouselCard(
    //         child: IconButton(
    //           icon: Icon(Icons.add_a_photo),
    //           onPressed: () => pickImageFromGallery(ImageSource.gallery),
    //         ),
    //       );
    //     }
    //     return CarouselWithIndicator(
    //       child: snapshot.data.map((i) {
    //         if (!i.isImage) {
    //           return carouselCard(
    //             child: IconButton(
    //               icon: Icon(Icons.add_a_photo),
    //               onPressed: () => pickImageFromGallery(ImageSource.gallery),
    //             ),
    //           );
    //         } else {
    //           return carouselCard(
    //             child: (i.isAsset)
    //                 ? Image.asset(i.imagePath, fit: BoxFit.fill)
    //                 : Image.file(File(i.imagePath), fit: BoxFit.fill),
    //           );
    //         }
    //       }).toList(),
    //     );
    //   },
    // );
  }

  Widget _buildSales() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TextWithPadding("If I make", bold: true),
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              _buildSalesPerDay(editable: true),
              TextWithPadding("I'll reach my goal on", bold: true),
              TextWithPadding(targetDate)
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePick() {
    return Expanded(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextWithPadding("If I want to reach my goal by", bold: true),
              InkWell(
                child: TextWithPadding(formattedDate),
                onTap: () => _selectDate(context),
              ),
              TextWithPadding("I need to make", bold: true),
              _buildSalesPerDay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget carouselCard({Widget child}) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(0.0)),
          child: child,
        );
      },
    );
  }

  Row _buildSalesPerDay({bool editable = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(16),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: 1.0,
            ),
          ),
          child: Center(
            child: editable
                ? TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration.collapsed(hintText: "$salesRate"),
                    onSubmitted: ((newSalesRate) {
                      updateSalesRate(int.parse(newSalesRate));
                    }),
                  )
                : Text('$salesPerDay'),
          ),
        ),
        Text("Sales/day"),
      ],
    );
  }

  pickImageFromGallery(ImageSource source) async {
    imageFile = await ImagePicker.pickImage(source: source);
    // appBloc.insertImage(imageFile.path);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
    if (picked != null) selectDate(picked);
  }

  void selectDate(DateTime picked) {
    setState(() {
      selectedDate = picked;
      formattedDate = DateFormat.yMMMMd().format(picked);
      int daysDif = picked.difference(DateTime.now()).inDays + 1;
      salesPerDay = (total / daysDif).round();
    });
  }

  void updateSalesRate(int newSalesRate) {
    int daysRequired = (total / newSalesRate).round();
    targetDate = DateFormat.yMMMMd()
        .format(DateTime.now().add(Duration(days: daysRequired)));
  }

  String removeSymbols(String text) =>
      text.replaceAll("\$", "").replaceAll(",", "");

  @override
  bool get wantKeepAlive => true;
}

class NumericTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    print("old value is ${oldValue.text}");
    print("new value is ${newValue.text}");

    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      print("new value is $newValue");
      int selectionIndexFromTheRight =
          newValue.text.length - newValue.selection.end;
      final f =
          new NumberFormat.simpleCurrency(locale: 'en_US', decimalDigits: 0);
      final newString = f.format(
          int.parse(newValue.text.replaceAll("\$", '').replaceAll(',', '')));
      return new TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
            offset: newString.length - selectionIndexFromTheRight),
      );
    } else {
      return newValue;
    }
  }
}
