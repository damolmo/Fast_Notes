import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Categories { 
  
  Categories({
    required this.categoryName,
    required this.categoryDescription
});
  
  final String categoryName;
  final String categoryDescription;

  static const categoriesTable = """
    CREATE TABLE IF NOT EXISTS categories(
      categoryName TEXT PRIMARY KEY,
      categoryDescription TEXT
      );
  """;
  
  Map<String,dynamic> toMap() => {
    "categoryName" : categoryName,
    "categoryDescription" : categoryDescription
  };

  factory Categories.fromMap(Map<String, dynamic> map) =>
    Categories(
        categoryName: map["categoryName"],
        categoryDescription: map["categoryDescription"]);

  static createCategoriesTable() async {
    // A static method that allow us to create the categories table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    } else {
      final Database db = await openDatabase("notes.db");
      db.transaction((txn) => txn.execute(categoriesTable));
    }

  }
  
  static insertCategoryIntoTable(Categories category) async {
    // A static method that allow to insert a new category into the table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.insert("categories", category.toMap());
    } else {
      final Database db = await openDatabase("notes.db");
      db.insert("categories", category.toMap());
    }

  }
  
  static updateExistingCategory(Categories category, String name) async {
    // A static method that allow us to update an existing category
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.update("categories", category.toMap(), where: "categoryName = ?", whereArgs: [name]);
    } else {
      final Database db = await openDatabase("notes.db");
      db.update("categories", category.toMap(), where: "categoryName = ?", whereArgs: [name]);
    }

  }

  static Future<List<Categories>> retrieveCurrentCategories() async {
    // A static method that retrieves existing categories
    rawCategoriesToInstances(List<Map<String,dynamic>> rawCategories, List<Categories> categories){
      for (Map<String,dynamic> rawCategory in rawCategories){
        categories.add(Categories.fromMap(rawCategory));
      }
      return categories;
    }

    List<Categories> categories = [];
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      categories = rawCategoriesToInstances(await db.query("categories"), categories);
    } else {
      final Database db = await openDatabase("notes.db");
      categories = rawCategoriesToInstances(await db.query("categories"), categories);
    }


    return categories;
  }
  
}