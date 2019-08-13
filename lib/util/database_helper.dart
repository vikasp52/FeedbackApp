import 'dart:io';

import 'package:online_survey/model/feedback_data_model.dart';
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:async/async.dart';

class DataBaseHelper {
  //Singleton helper for database
  static final DataBaseHelper _instance = DataBaseHelper.internal();
  factory DataBaseHelper() => _instance;

  final String feedbackFormTable = "feedback_form_table";
  final String colId = "id";
  final String colName = "name";
  final String colGender = "gender";
  final String colGenderChoice = "gender_choice";
  final String colAge = "age";
  final String colEmail = "email";
  final String colPhone = "phone";
  final String colExperience = "experience";
  final String colDateOfVisit = "visit_date";
  final String colVisitAgain = "visit_again";
  final String colSurveyTitle = "survey_title";
  final String colWelcomeScreenTitle = "welcome_screen_title";
  final String colWelcomeScreenDesc = "welcome_screen_desc";
  final String colWelcomeScreenBtnTitle = "welcome_screen_btn_title";
  final String colThankYouScreenDesc = "thankyou_screen_desc";
  final String colThankYouScreenBtnTitle = "thankyou_screen_btn_title";

  final String feedbackDataTable = "feedback_data_table";
  final String colFDId = "fd_id";
  final String colFDName = "fd_name";
  final String colFDGender = "fd_gender";
  final String colFDAge = "fd_age";
  final String colFDEmail = "fd_email";
  final String colFDExperience = "fd_experience";
  final String colFDDateOfVisit = "fd_visit_date";
  final String colFDVisitAgain = "fd_visit_again";

  //Named constructor to create the database instance
  static Database _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initDb();
    }
    return _db;
  }

  DataBaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'feedback.db');
    var feedbackDb = await openDatabase(path, version: 2, onCreate: _createDb);
    return feedbackDb;
  }

  void _createDb(Database db, int newVersion) async {
    //Create Feedback Form Table
    await db.execute("""
    CREATE TABLE $feedbackFormTable(
    $colId INTEGER PRIMARY KEY AUTOINCREMENT, 
    $colName TEXT, 
    $colGender TEXT, 
    $colGenderChoice TEXT,
    $colAge INTEGER, 
    $colEmail TEXT,
    $colPhone TEXT,
    $colExperience TEXT, 
    $colDateOfVisit TEXT, 
    $colVisitAgain TEXT, 
    $colSurveyTitle TEXT, 
    $colWelcomeScreenTitle TEXT, 
    $colWelcomeScreenDesc TEXT,
    $colWelcomeScreenBtnTitle TEXT, 
    $colThankYouScreenDesc TEXT, 
    $colThankYouScreenBtnTitle TEXT)
    """);

    print("feedbackFormTable create");

    //Create Feedback Data Table
    await db.execute("""
    CREATE TABLE $feedbackDataTable(
    $colFDId INTEGER PRIMARY KEY AUTOINCREMENT, 
    $colFDName TEXT, 
    $colFDGender TEXT, 
    $colFDAge INTEGER, 
    $colFDEmail TEXT,
    $colFDExperience TEXT, 
    $colFDDateOfVisit TEXT, 
    $colFDVisitAgain TEXT)
    """);
    print("feedbackDataTable create");
  }

  //Get the feedback form from DB
  Future<FeedbackFormModel> getSurveyForm() async {
    Database db = await this.db;

    var result = await db.rawQuery('SELECT * FROM $feedbackFormTable');
    print("feedbackFormTable data: ${result}");
    if (result.length == 0) return null;
    return FeedbackFormModel.fromMapFeedbackForm(result.first);
  }

  //Save the feedback from in DB
  Future<int> insertFeedbackForm(FeedbackFormModel feedbackForm) async {
    return (await db).insert("$feedbackFormTable", feedbackForm.toMapFeedbackForm());
  }

  //Get the feedback data from DB
  Future<FeedbackDataModel> getFeedbackData() async {
    Database db = await this.db;
    var result = await db.rawQuery('SELECT * FROM $feedbackFormTable');
    print("feedbackFormTable data: ${result}");
    if (result.length == 0) return null;
    return FeedbackDataModel.fromMapFeedbackData(result.first);
  }

  //Save the feedback data in DB
  Future<int> insertFeedbackData(FeedbackDataModel feedbackData) async {
    return (await db).insert("$feedbackDataTable", feedbackData.toMapFeedbackData());
  }
}
