import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/stats_bloc.dart';
export 'package:sales_mgmt/bloc/stats_bloc.dart';

class StatsBlocProvider extends InheritedWidget {
  final StatsBloc statsBloc;

  StatsBlocProvider({Key key, Widget child})
      : statsBloc = StatsBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static StatsBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(StatsBlocProvider)
            as StatsBlocProvider)
        .statsBloc;
  }
}
