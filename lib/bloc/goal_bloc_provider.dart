import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/goal_bloc.dart';
export 'package:sales_mgmt/bloc/goal_bloc.dart';

class GoalBlocProvider extends InheritedWidget {
  final GoalBloc goalBloc;

  GoalBlocProvider({Key key, Widget child})
      : goalBloc = GoalBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static GoalBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(GoalBlocProvider)
            as GoalBlocProvider)
        .goalBloc;
  }
}
