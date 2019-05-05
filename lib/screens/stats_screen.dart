import 'package:flutter/material.dart';

class StatsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
