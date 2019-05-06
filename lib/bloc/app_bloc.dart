import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sales_mgmt/models/image_model.dart';
import 'package:sales_mgmt/repository/image_repo.dart';
import 'package:sales_mgmt/constants.dart';
export 'package:sales_mgmt/constants.dart';

class AppBloc {
  static final List<ImageModel> assetimages = [
    ImageModel('assets/image1.jpeg', true, true),
    ImageModel('assets/image2.jpeg', true, true),
    ImageModel('assets/image3.jpeg', true, true),
    ImageModel('assets/image4.jpeg', true, true),
    ImageModel('nothing', false, false),
  ];
  SharedPreferences prefs;

  AppBloc() {
    _images.add(assetimages);
    initSharedPref();
  }

  Future<SharedPreferences> initSharedPref() async {
    print("initsharedpref");
    prefs = await SharedPreferences.getInstance();
    initializeValues();
    // _teamsMonthSink.add(prefs.getString(teamFilter) ?? "Baisakh");
    // _statsMonthSink.add(prefs.getString(statsFilter) ?? "Baisakh");
    // _teamsSink.add(prefs.getString(teamName) ?? "team1");
    // print("teamsstream ko output 1 is ${prefs.getString(teamFilter)}");
    // print("teamsstream ko output 2 is ${prefs.getString(statsFilter)}");
    // print("teamsstream ko output 3 is ${prefs.getString(teamName)}");
    return prefs;
  }

  initializeValues() {
    _teamsMonthSink.add(prefs.getString(teamFilter) ?? "Baisakh");
    _statsMonthSink.add(prefs.getString(statsFilter) ?? "Baisakh");
    _demoSink.add(prefs.getString(teamName) ?? "1");
    print("teamsstream ko output 1 is ${prefs.getString(teamFilter)}");
    print("teamsstream ko output 2 is ${prefs.getString(statsFilter)}");
    print("teamsstream ko output 3 is ${prefs.getString(teamName)}");
  }

  Future<SharedPreferences> getSharedPref() async {
    if (prefs != null) return prefs;
    prefs = await initSharedPref();
    return prefs;
  } 

  ImageRepo _imageRepo = ImageRepo();

  ReplaySubject<List<ImageModel>> _images = ReplaySubject<List<ImageModel>>();
  BehaviorSubject<int> _index = BehaviorSubject<int>();
  PublishSubject<String> _teamsMonth = PublishSubject<String>();
  PublishSubject<String> _statsMonth = PublishSubject<String>();
  PublishSubject<String> _teams = PublishSubject<String>();
  PublishSubject<String> _demo = PublishSubject<String>();

  Observable<List<ImageModel>> get imageStream => _images.stream;

  Observable<int> get index => _index.stream;

  Observable<String> get teamsMonth => _teamsMonth.stream;

  Observable<String> get statsMonth => _statsMonth.stream;

  Observable<String> get teams => _teams.stream;
  Observable<String> get demo => _demo.stream;

  Function get _imageSink => _images.sink.add;

  Function get _indexSink => _index.sink.add;

  Sink<String> get _teamsMonthSink => _teamsMonth.sink;

  Sink<String> get _statsMonthSink => _statsMonth.sink;

  Sink<String> get _teamsSink => _teams.sink;
  Sink<String> get _demoSink => _demo.sink;

  void insertImage(String imagePath) async {
    ImageModel imageN = (ImageModel(imagePath, false, true));
    assetimages.insert(assetimages.length - 1, imageN);
    _imageSink(assetimages);
    int i = await _imageRepo.insertImage(imageN);
    print("image insert success $i");
  }

  void fetchImages() async {
    print("lets fetch images");
    List<ImageModel> images = await _imageRepo.fetchImages();
    assetimages.insertAll(assetimages.length - 1, images);
    _imageSink(assetimages);
    print("lets fetch images completed");
  }

  void selectTeamMonth(String month) async {
    await saveToPref(teamFilter, month);
    print("adding to team month sink");
    _teamsMonthSink.add(month);
  }

  void selectStatMonth(String month) async {
    await saveToPref(statsFilter, month);
    print("adding to stat month sink");
    _statsMonthSink.add(month);
  }

  void selectTeam(String month) async {
    await saveToPref(teamName, month);
    _teamsSink.add(month);
  }

  void selectInt(String month) async {
    print("adding to team name sink");
    await saveToPref(teamName, month);
    _demoSink.add(month);
  }

  saveToPref(String key, String value) async {
    final pref = await getSharedPref();
    pref.setString(key, value ?? "teams1");
  }

  void dispose() {
    _images.close();
    _index.close();
    _teamsMonth.close();
    _statsMonth.close();
    _teams.close();
    _demo.close();
  }
}
