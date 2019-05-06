import 'package:rxdart/rxdart.dart';
import 'package:sales_mgmt/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TeamBloc {
  SharedPreferences prefs;
  BehaviorSubject<String> _teamsMonth = BehaviorSubject<String>();
  BehaviorSubject<String> _demo = BehaviorSubject<String>();

  Observable<String> get teamsMonth => _teamsMonth.stream;
  Observable<String> get demo => _demo.stream;

  Sink<String> get _teamsMonthSink => _teamsMonth.sink;
  Sink<String> get _demoSink => _demo.sink;

  TeamBloc() {
    initSharedPref();
  }

  Future<SharedPreferences> initSharedPref() async {
    print("initsharedpref from team bloc");
    prefs = await SharedPreferences.getInstance();
    _teamsMonthSink.add(prefs.getString(teamFilter) ?? "Baisakh");
    _demoSink.add(prefs.getString(teamName) ?? "1");
    return prefs;
  }

  Future<SharedPreferences> getSharedPref() async {
    if (prefs != null) return prefs;
    prefs = await initSharedPref();
    return prefs;
  }

  void selectTeamMonth(String month) async {
    final pref = await getSharedPref();
    pref.setString(teamFilter, month ?? "teams1");
    print("adding to team month sink");
    _teamsMonthSink.add(month);
  }

  void selectInt(String month) async {
    final pref = await getSharedPref();
    pref.setString(teamName, month ?? "teams1");
    print("adding to team name sink");
    _demoSink.add(month);
  }

  void dispose() {
    _teamsMonth.close();
    _demo.close();
  }
}
