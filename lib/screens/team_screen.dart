import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/team_bloc_provider.dart';
import 'package:sales_mgmt/constants.dart';

class TeamScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teamBloc = TeamBlocProvider.of(context);
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          StreamBuilder<String>(
            stream: teamBloc.demo,
            builder: (context, snapshot) {
              print("snapshot of teams ${snapshot.data}");
              if (snapshot.data == null) {
                return Container();
              }
              return DropdownButton<String>(
                value: snapshot.data,
                items: ["1", "2", "3", "4", "team1", "team2", "team3"]
                    .map((item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)))
                    .toList(),
                onChanged: (teamN) {
                  print("onchange from team name");

                  teamBloc.selectInt(teamN);
                },
              );
            },
          ),
          StreamBuilder<String>(
            stream: teamBloc.teamsMonth,
            builder: (context, snapshot) {
              print("snapshot of month ${snapshot.data}");
              return DropdownButton<String>(
                value: snapshot.data,
                items: months
                    .map((item) => DropdownMenuItem<String>(
                        value: item, child: Text(item)))
                    .toList(),
                onChanged: (selectedM) {
                  print("onchange from month team");

                  teamBloc.selectTeamMonth(selectedM);
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
