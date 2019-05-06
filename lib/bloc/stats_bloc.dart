import 'package:rxdart/rxdart.dart';
import 'package:sales_mgmt/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsBloc {
  SharedPreferences prefs;
  BehaviorSubject<String> _statsMonth = BehaviorSubject<String>();
  Observable<String> get statsMonth => _statsMonth.stream;
  Sink<String> get _statsMonthSink => _statsMonth.sink;

  StatsBloc() {
    initSharedPref();
  }

  Future<SharedPreferences> initSharedPref() async {
    print("initsharedpref from stats bloc");
    prefs = await SharedPreferences.getInstance();
    _statsMonthSink.add(prefs.getString(statsFilter) ?? "Baisakh");
    print("initsharedpref from stats bloc added to sink");
    return prefs;
  }

  Future<SharedPreferences> getSharedPref() async {
    if (prefs != null) return prefs;
    prefs = await initSharedPref();
    return prefs;
  }

  void selectStatMonth(String month) async {
    final pref = await getSharedPref();
    pref.setString(statsFilter, month ?? "teams1");
    print("adding to stat month sink");
    _statsMonthSink.add(month);
  }

  void dispose() {
    _statsMonth.close();
  }
}
