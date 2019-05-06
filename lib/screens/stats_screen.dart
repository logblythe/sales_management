import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/stats_bloc_provider..dart';
import 'package:sales_mgmt/constants.dart';

class StatsScreen extends StatelessWidget {
  // final String selValue;
  // final Function onSelectedStats;
  // const StatsScreen({Key key, this.selValue, this.onSelectedStats})
  //     : super(key: key);

  // Widget buildAppBar(bloc) {
  //   return Row(
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: <Widget>[
  //       DropdownButton<String>(
  //         value: selValue,
  //         items: months
  //             .map((item) =>
  //                 DropdownMenuItem<String>(value: item, child: Text(item)))
  //             .toList(),
  //         onChanged: (selectedM) {
  //           print("onchange from stats");
  //           onSelectedStats(selectedM);
  //           // statsBloc.selectStatMonth(selectedM);
  //         },
  //       ),
  //       Text("Time Frame"),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    print("lets render the row WHOLE");
    final statsBloc = StatsBlocProvider.of(context);
    return SingleChildScrollView(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<String>(
            stream: statsBloc.statsMonth,
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                print("no data snapshot of stats WHOLE is ${snapshot.data}");
              print("snapshot of stats WHOLE is ${snapshot.data}");

              return DropdownButton<String>(
                value: snapshot.data,
                items: months
                    .map((item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)))
                    .toList(),
                onChanged: (selectedM) {
                  print("onchange from stats");
                  statsBloc.selectStatMonth(selectedM);
                },
              );
            },
          ),
          Text("Time Frame"),
        ],
      ),
    );
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(child: _buildSales(), fit: FlexFit.loose),
          Flexible(child: _buildCalls(), fit: FlexFit.loose),
          Flexible(child: _buildConversion(), fit: FlexFit.loose),
          Flexible(child: _buildCommission(), fit: FlexFit.loose),
        ],
      ),
    );
  }

  Widget _buildSales() {
    return Row(
      children: <Widget>[
        Column(
          children: <Widget>[
            Text("Total Sales"),
            Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('-1'),
                  onPressed: null,
                ),
                RaisedButton(
                  child: Text('+1'),
                  onPressed: null,
                ),
              ],
            )
          ],
        ),
        CircleAvatar(
          radius: 10,
          child: Text('10'),
        )
      ],
    );
  }

  Widget _buildCalls() {
    return Container(
      color: Colors.red,
      height: 10,
    );
  }

  Widget _buildConversion() {
    return Container(
      color: Colors.green,
      height: 10,
    );
  }

  Widget _buildCommission() {
    return Container(
      color: Colors.blue,
      height: 10,
    );
  }
}
