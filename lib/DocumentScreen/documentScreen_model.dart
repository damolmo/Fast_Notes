import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/cupertino.dart';
import '../exports.dart';

class DocumentScreenModel extends HomeScreenModel implements Initialisable{

  TextEditingController nameField = TextEditingController(text: "");
  TextEditingController authorField = TextEditingController(text : "");
  bool isMorePropertiesExpandable = false;
  bool showExitDialog = false;
  bool isDarkModeEnabled = false;
  List<Widget> currentWidgets = [];
  List<NotesContent> notesContent = [];
  List<TextEditingController> texts = [];
  List<int> textsIndexes = [];
  late Notes note;
  int count = 0;
  late BuildContext context;
  bool readData = false;

  @override
  void initialise(){

  }

  void readDataFromFile() async {
    // A method that recovers data for selected file
    try {
      notesContent = await NotesContent.retrieveContentForNote(note.noteCreationDate);
      notifyListeners();
      print(notesContent.length);
    } catch (e){
      // Nothing to do
      print("ERROR");

    }

    if (notesContent.isNotEmpty){
      for (NotesContent content in notesContent){
        texts.add(TextEditingController(text: content.noteContentData));
        textsIndexes.add(count);
        currentWidgets.add(TextField(style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06,), textAlign :  TextAlign.left, controller: texts[count], maxLines: 50, keyboardType: TextInputType.multiline, decoration: InputDecoration(border: InputBorder.none, hintText: "Tap to edit", hintStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06,)),));
        count +=1;
        notifyListeners();
      }
    }

  }

  void saveModificatedNote() async {
    // A method that checks if a note was modified and updates his name
    if (nameField.text != note.noteName) {
      // The note was modified
      Notes newNote = Notes(noteName: nameField.text, noteCreationDate: note.noteCreationDate, noteModificationDate: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}", noteAuthor: note.noteAuthor, noteCover: note.noteCover, noteCategory: note.noteCategory);
      Notes.updateExistingNote(newNote);
      notifyListeners();
    }
  }

  void saveNoteContents(BuildContext context) async {
    // A method that updates the note contents
    print(notesContent.length);
    for (int i = 0; i < notesContent.length; i++){
      // Every widgets on the present list should be mixed with this data
      NotesContent current = NotesContent(noteContentName: note.noteCreationDate, noteContentType: notesContent[i].noteContentType, noteContentData: texts[i].text, contentIdentifier: "${note.noteName}+$i");

      try {
        NotesContent.insertContentIntoNote(current);
      } catch (e){
        // Nothing to do // Asynchronous gaps
      }

      try {
        NotesContent.updateNoteContent(current);
      } catch (e){
        // Nothing to do // Asynchronous gaps
      }

    }
    showExitDialog = true;
    Navigator.of(context).pop();
  }


  void addWidget(String type, BuildContext context) async {
    // A method that adds a widget based on user input

    switch(type) {
      case "text" : {
        notesContent.add(
            NotesContent(
                noteContentName: note.noteCreationDate,
                noteContentType: "text",
                noteContentData: "",
                contentIdentifier: note.noteCreationDate));
        texts.add(TextEditingController(text: ""));
        textsIndexes.add(count);
        currentWidgets.add(TextField(style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06,), textAlign :  TextAlign.left, controller: texts[count], maxLines: 30, keyboardType: TextInputType.multiline, decoration: InputDecoration(border: InputBorder.none, hintText: "Tap to edit", hintStyle: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.06,)),));
        count +=1;
        notifyListeners();
      }

      case "image" : {
        notesContent.add(
            NotesContent(
                noteContentName: nameField.text,
                noteContentType: "image",
                noteContentData: "",
                contentIdentifier: "${nameField.text}_${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}"));
        currentWidgets.add(Image(image: AssetImage("")));
        notifyListeners();
      }

      case "list" : {
        notesContent.add(
            NotesContent(
                noteContentName: nameField.text,
                noteContentType: "list",
                noteContentData: "",
                contentIdentifier: "${nameField.text}_${DateTime.now().hour}_${DateTime.now().minute}_${DateTime.now().second}"));
        currentWidgets.add(ListView());
        notifyListeners();
      }
    }
  }
}