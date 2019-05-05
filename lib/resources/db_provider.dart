import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sales_mgmt/models/image_model.dart';
import 'package:sqflite/sqflite.dart';

class DbProvider {
  Database db;

  Future<Database> get database async {
    if (db != null) return db;
    db = await init();
    return db;
  }

  Future<Database> init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'sales_mgmt.db');
    db = await openDatabase(path, version: 1,
        onCreate: (database, version) async {
      await database.execute("""
  CREATE TABLE IF NOT EXISTS goalImages(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  imagePath TEXT NOT NULL,
  isAsset TINYINT,
  isImage TINYINT)
          """);
    }, onUpgrade: (database, int oldVersion, int newVersion) async {});
    return db;
  }

  Future<int> insertImage(ImageModel image) async {
    final db = await database;
    return db.insert("goalImages", image.toMapForDb());
  }

  Future<List<ImageModel>> fetchImages() async {
    final db = await database;
    List<ImageModel> images = [];
    List<Map<String, dynamic>> imageMaps = await db.query(
      "goalImages",
      columns: ['*'],
    );
    imageMaps.forEach((imageMap) {
      images.add(ImageModel.fromDb(imageMap));
    });
    return images;
  }
}

final dbProvider = DbProvider();
