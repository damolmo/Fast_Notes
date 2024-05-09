import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

class NotesContent {

  NotesContent ({
    required this.noteContentName,
    required this.noteContentType,
    required this.noteContentData,
    required this.contentIdentifier,
});

  final String noteContentName;
  final String noteContentType;
  final String noteContentData;
  final String contentIdentifier;

  static const notesContentTable = """
    CREATE TABLE IF NOT EXISTS notesContent(
      noteContentName TEXT,
      noteContentType TEXT,
      noteContentData TEXT,
      contentIdentifier TEXT PRIMARY KEY,
      FOREIGN KEY(noteContentName) REFERENCES notes(noteName)
    );
  """;

  Map<String,dynamic> toMap() => {
    "noteContentName" :  noteContentName,
    "noteContentType" : noteContentType,
    "noteContentData" : noteContentData,
    "contentIdentifier" : contentIdentifier,
  };

  factory NotesContent.fromMap(Map<String,dynamic> map) =>
    NotesContent(
        noteContentName: map["noteContentName"],
        noteContentType: map["noteContentType"],
        noteContentData: map["noteContentData"],
        contentIdentifier: map["contentIdentifier"]
    );

  static createNotesTable() async {
    // A static method that allow us to create the notes table
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.transaction((txn) => txn.execute(notesContentTable));
    } else {
      final Database db = await openDatabase("notes.db");
      db.transaction((txn) => txn.execute(notesContentTable));
    }

  }

  static insertContentIntoNote(NotesContent content) async {
    // A static method that allow us to insert content into a note
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.insert("notesContent", content.toMap());
    } else {
      final Database db = await openDatabase("notes.db");
      db.insert("notesContent", content.toMap());
    }

  }

  static updateNoteContent(NotesContent content) async {
    // A static method that allow us to insert content into a note
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.update("notesContent", content.toMap(), where: "contentIdentifier = ?", whereArgs: [content.contentIdentifier]);
    } else {
      final Database db = await openDatabase("notes.db");
      db.update("notesContent", content.toMap(), where: "contentIdentifier = ?", whereArgs: [content.contentIdentifier]);
    }
  }

  static deleteNoteContent(NotesContent content) async {
    // A static method that allow us to delete a content from a note
    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      db.delete("notesContent", where: "contentIdentifier = ? AND noteContentName = ?", whereArgs: [content.contentIdentifier, content.noteContentName]);
    } else {
      final Database db = await openDatabase("notes.db");
      db.delete("notesContent", where: "contentIdentifier = ? AND noteContentName = ?", whereArgs: [content.contentIdentifier, content.noteContentName]);
    }
  }

  static Future<List<NotesContent>> retrieveContentForNote(String noteName) async {
    // A static method that retrieves all data for an existing note name
    rawContentToInstance(List<Map<String,dynamic>> rawContents, List<NotesContent> contents){
      for (Map<String,dynamic> rawContent in rawContents){
        contents.add(NotesContent.fromMap(rawContent));
      }
      return contents;
    }

    List<NotesContent> contents = [];

    if (kIsWeb){
      final Database db = await databaseFactoryFfiWeb.openDatabase("notes.db");
      contents = rawContentToInstance(await db.query("notesContent", where: "noteContentName = ?", whereArgs: [noteName]), contents);
    } else {
      final Database db = await openDatabase("notes.db");
      contents = rawContentToInstance(await db.query("notesContent", where: "noteContentName = ?", whereArgs: [noteName]), contents);
    }

    return contents;


  }

}