import 'package:flutter/widgets.dart';
import 'package:news/database_helper/database_helper.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class FavNewsDao {
  static const favNewsTable = "fav_news_table";

  static const favNewsId = "id";
  static const favNewsKey = "fav_news_key";
  static const favNewsTitle = "fav_news_title";
  static const favNewsDesc = "fav_news_desc";
  static const favNewsContent = "fav_news_content";
  static const favNewsPublishedAt = "fav_news_published_at";
  static const favNewsImageUrl = "fav_news_image_url";

  late Database db;

  Future init() async {
    final docDirectory = await getApplicationDocumentsDirectory();
    final path = join(docDirectory.path, favNewsTable);

    db = await openDatabase(path, version: DatabaseHelper.databaseVersion, onCreate: onCreate);
  }

  static String createQuery =
      '''CREATE TABLE $favNewsTable ($favNewsId INTEGER PRIMARY KEY, $favNewsKey TEXT NOT NULL, $favNewsTitle TEXT NOT NULL, $favNewsDesc TEXT NOT NULL, $favNewsContent TEXT NOT NULL, $favNewsPublishedAt TEXT NOT NULL, $favNewsImageUrl TEXT NOT NULL)''';

  Future onCreate(Database db, int version) async {
    await db.execute(createQuery);
  }

  Future<int> insert(Map<String, dynamic> row) async {
    try {
      return await db.insert(favNewsTable, row);
    } on DatabaseException catch (e) {
      debugPrint("EXCEPTION: $e");
      return 0;
    }
  }

  String selectFavNews = 'SELECT * FROM $favNewsTable';

  Future<List<Map<String, dynamic>>> getFavNews() async {
    List<Map<String, dynamic>> result = await db.rawQuery(selectFavNews);
    return result;
  }

  Future<int> dataCount(String key) async {
    final results = await db.rawQuery('SELECT COUNT(*) FROM $favNewsTable WHERE $favNewsKey = $key');
    return Sqflite.firstIntValue(results) ?? 0;
  }

  String deleteFavNewsQuery = "DELETE FROM $favNewsTable WHERE $favNewsKey=?";

  Future<int> deleteFavNews(String newsKey) async {
    return await db.rawDelete(deleteFavNewsQuery, [newsKey]);
  }
}
