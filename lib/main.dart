import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:sales_mgmt/bloc/stats_bloc_provider..dart';
import 'package:sales_mgmt/bloc/team_bloc_provider.dart';
import 'package:sales_mgmt/screens/dashboard.dart';

void main() async {
  Router router = new Router();
  router.define('/', handler:
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final page = StatsBlocProvider(
      child: TeamBlocProvider(
        child: Dashboard(),
      ),
    );
    return page;
  }));
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final Router router;

  const MyApp({Key key, this.router}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryTextTheme: TextTheme(title: TextStyle(color: Colors.white))),
      onGenerateRoute: router.generator,
    );
  }
}
