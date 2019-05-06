import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/team_bloc.dart';
export 'package:sales_mgmt/bloc/team_bloc.dart';

class TeamBlocProvider extends InheritedWidget {
  final TeamBloc teamBloc;

  TeamBlocProvider({Key key, Widget child})
      : teamBloc = TeamBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static TeamBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TeamBlocProvider)
            as TeamBlocProvider)
        .teamBloc;
  }
}
