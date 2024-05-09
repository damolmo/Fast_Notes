import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../exports.dart';

class HomeScreenModel extends BaseViewModel implements Initialisable{

  bool isDarkModeEnabled = false;
  bool enabledNewDocMenu = false;
  bool isCreationWindow = false;
  bool isDocumentCreation = false;
  bool isKeyboardEnabled = false;
  bool isDocumentsView = true;
  bool isGridX3 = false;
  bool isShortAlphabetically = false;
  bool isSortByWeight = false;
  bool isCleanData = true;
  bool isFolderOpened = false;
  bool isCategorySelection = false;
  TextEditingController nameField = TextEditingController(text: "");

  // Main values
  List<Categories> categories = [];
  List<int> categoryFiles  = [];
  List<Notes> latestNotes = [];

  // OG Values Backup
  List<Categories> categoriesBackup = [];
  List<int> categoryFilesBackup = [];

  // Values to be used and edited across the app
  List<int> tempFiles = [];
  List<Categories> tempCategories = [];

  // values to be edited by the user
  List<Notes> notes = [];
  int choosedCategorySelection = 0;
  String choosedCategoryName = "";
  int choosedNote = 0;

  @override
  void initialise(){
    createTables();
    getLatestNotes();
  }

  Future<void> getCategoryByWeight() async {
    // This method sorts all sizes and his corresponding category name
    List<int> addedInt = [];
    int count = 0;
    tempCategories = [];
    tempFiles = [];
    categoryFilesBackup = [];

    // Recover data just in case it got modified somehow
    categoriesBackup = await Categories.retrieveCurrentCategories();
    notifyListeners();

    for (Categories cat in categoriesBackup){
      tempFiles.add((await Notes.retrieveNotesForCategory(cat.categoryName)).length);
      categoryFilesBackup.add((await Notes.retrieveNotesForCategory(cat.categoryName)).length);
      notifyListeners();
    }

    // Sort numbers depending of the toggle // ASC OR DESC
    if (isSortByWeight){
      tempFiles.sort((a,b) => a.compareTo(b));
      tempFiles = tempFiles.reversed.toList();
      notifyListeners();
    } else {
      tempFiles.sort((a,b) => a.compareTo(b));
      notifyListeners();
    }

    // Get categories for the sorted items
    for (int sortN in tempFiles){
      for (int ogN = 0; ogN < categoryFilesBackup.length; ogN++){
        // Increase the counter position
        if (sortN == categoryFilesBackup[ogN]){
          print("$sortN == $ogN : $count");
          // We've a coincidence
          // Might be a repeated number, so
          if (!addedInt.contains(ogN)){
            // This index is safe, let's add all stuff
            addedInt.add(ogN); // Save unique position
            tempCategories.add(categoriesBackup[ogN]);
          }
        }

      }
    }

    // Save data
    categoryFiles = tempFiles;
    categories = tempCategories;
    notifyListeners();

    print(tempFiles);
    print(categoryFilesBackup);
    print("${categoriesBackup[0].categoryName}, ${categoriesBackup[1].categoryName}, ${categoriesBackup[2].categoryName}");
    print("${tempCategories[0].categoryName}, ${tempCategories[1].categoryName}, ${tempCategories[2].categoryName}");


  }

  void createTables() async {
    // Create all tables on init to avoid
    Categories.createCategoriesTable();
    Notes.createNotesTable();
    NotesContent.createNotesTable();
  }

  void sortCategories() async {
    // A method that allow us to sort files
    categories = categoriesBackup;

    if (isShortAlphabetically){
      notes.sort((a,b) => a.noteName.compareTo(b.noteName));
      categories.sort((a, b) => a.categoryName.toString().toLowerCase().compareTo(b.categoryName.toString().toLowerCase()));
      notifyListeners();
      getFilesForCategory();
    } else {
      notes.sort((a,b) => a.noteName.compareTo(b.noteName));
      categories.sort((a, b) => a.categoryName.toString().toLowerCase().compareTo(b.categoryName.toString().toLowerCase()));
      notes = notes.reversed.toList();
      categories = categories.reversed.toList();
      notifyListeners();
      getFilesForCategory();
    }

    }

  void getExistingCategories() async {
    // A method that retrieves all existing categories on database
    try {
      categories = await Categories.retrieveCurrentCategories();
      categoriesBackup = await Categories.retrieveCurrentCategories();
      notifyListeners();
    } catch (e){
      // Nothing to do
    }
  }

  Future fetchData() async {
    getExistingCategories();
    getFilesForCategory();
  }

  getFilesForCategory() async {
    // A method that allow us to retrieve current files for a category
    List<Notes> temp  = [];
    List<int> tempFiles = [];

    for (Categories folder in categories){
      temp = await Notes.retrieveNotesForCategory(folder.categoryName);
      tempFiles.add(temp.length);
      }

    categoryFiles = tempFiles;
    categoryFilesBackup = tempFiles;
    notifyListeners();

    }

  void notifyUserAlert(String message, BuildContext context) async {
  // A method use to notify user about something
    SnackBar snack = SnackBar(content: Text(message, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: getDeviceWidth(context) * 0.05), textAlign: TextAlign.center), behavior: SnackBarBehavior.floating);
    ScaffoldMessenger.of(context).showSnackBar(snack);
  }



  void getNotesCurrentCategory() async {
    // A method that retrieves all notes for a current category
    try {
      notes = await Notes.retrieveNotesForCategory(choosedCategoryName);
      notifyListeners();
    } catch (e){
      // Nothing to do
    }
  }

  void addCategory() async {
    // A method that allow us to insert a new category
    Categories currentCat = Categories(categoryName: nameField.text, categoryDescription: "A brand new category");
    Categories.insertCategoryIntoTable(currentCat);
    categories.add(currentCat);
    categoryFiles.add(0);
    categoriesBackup.add(currentCat);
    categoryFilesBackup.add(0);

   nameField.text = "";
   notifyListeners();
  }

  void addNote() async {
    // A method that does what is supossed to do
    Notes currentNote = Notes(
        noteName: nameField.text,
        noteCreationDate: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        noteModificationDate: "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}:${DateTime.now().second}",
        noteAuthor: "Default",
        noteCover: "None",
        noteCategory: categories[choosedCategorySelection].categoryName);
    Notes.insertNotesIntoTable(currentNote);
    nameField.text = "";
    notifyListeners();
  }

  void getLatestNotes() async {
    try {
      latestNotes = await Notes.retrieveLatestNotes();
      latestNotes = latestNotes.reversed.toList();
      notifyListeners();
    } catch (e) {
      // Nothing to do; Notes empty
    }
    fetchData();
  }

}