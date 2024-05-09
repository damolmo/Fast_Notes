import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class Notes {

  Notes({
    required this.noteName,
    required this.noteCreationDate,
    required this.noteModificationDate,
    required this.noteAuthor,
    required this.noteCover,
    required this.noteCategory,
  });

  final String noteName;
  final String noteCreationDate;
  final String noteModificationDate;
  final String noteAuthor;
  final String noteCover;
  final String noteCategory;

  static const notesTable = """
    CREATE TABLE IF NOT EXISTS notes(
      ID TEXT PRIMARY KEY,
      noteName TEXT,
      noteCreationDate TEXT,
      noteModificationDate TEXT,
      noteAuthor TEXT,
      noteCover TEXT,
      noteCategory TEXT,
      FOREIGN KEY(noteCategory) REFERENCES categories(categoryName)
      );
  """;

  Map<String, dynamic> toMap() =>
      {
      "noteName": noteName,
      "noteCreationDate": noteCreationDate,
      "noteModificationDate": noteModificationDate,
      "noteAuthor": noteAuthor,
      "noteCover": noteCover,
      "noteCategory": noteCategory
      };
  factory Notes.fromMap(Map<String, dynamic> map) =>
      Notes(
          noteName: map["noteName"],
          noteCreationDate: map["noteCreationDate"],
          noteModificationDate: map["noteModificationDate"],
          noteAuthor: map["noteAuthor"],
          noteCover: map["noteAuthor"],
          noteCategory: map["noteCategory"]
      );

  static createNotesTable() async {
    // A static method that creates the notes table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.transaction((txn) => txn.execute(notesTable));
    } else {
      final Database db = await openDatabase("notes.db");
      db.transaction((txn) => txn.execute(notesTable));
    }

  }

  static insertNotesIntoTable(Notes note) async {
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.insert("notes", note.toMap());
    } else {
      final Database db = await openDatabase("notes.db");
      db.insert("notes", note.toMap());
    }
  }

  static updateExistingNote(Notes note) async {
    // A static method that allow us to modify an existing note
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.update("notes", note.toMap(), where: "noteCreationDate = ?", whereArgs: [note.noteCreationDate]);
    } else {
      final Database db = await openDatabase("notes.db");
      db.update("notes", note.toMap(), where: "noteCreationDate = ?", whereArgs: [note.noteCreationDate]);
    }

  }

  static rawNotesToInstances(List<Map<String, dynamic>> rawNotes, List<Notes> notes) {
    for (Map<String,dynamic> rawNote in rawNotes){
      notes.add(Notes.fromMap(rawNote));
    }
    return notes;
  }

  static Future<List<Notes>> retrieveNotesForCategory(String categoryName) async {
    // A static method that allow us to retrieve all notes for a given category
    List<Notes> notes = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      notes = rawNotesToInstances(await db.query("notes", where: "noteCategory = ?", whereArgs: [categoryName]), notes);
    } else {
      final Database db = await openDatabase("notes.db");
      notes = rawNotesToInstances(await db.query("notes", where: "noteCategory = ?", whereArgs: [categoryName]), notes);
    }

    return notes;
  }

  static Future<List<Notes>> retrieveLatestNotes() async {
    // A method that retrieves latest notes added to the database
    List<Notes> notes  = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      notes = rawNotesToInstances(await db.query("notes"), notes);
    } else {
      final Database db = await openDatabase("notes.db");
      notes = rawNotesToInstances(await db.query("notes"), notes);
    }

    return notes;
  }

}