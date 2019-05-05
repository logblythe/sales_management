import 'package:flutter/material.dart';
import 'package:sales_mgmt/bloc/app_bloc.dart';
export 'package:sales_mgmt/bloc/app_bloc.dart';

class AppBlocProvider extends InheritedWidget {
  final AppBloc appBloc;

  AppBlocProvider({Key key, Widget child})
      : appBloc = AppBloc(),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(_) => true;

  static AppBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(AppBlocProvider)
            as AppBlocProvider)
        .appBloc;
  }
}
