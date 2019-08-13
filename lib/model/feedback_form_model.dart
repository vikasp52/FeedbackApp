import 'dart:convert';

import 'package:online_survey/model/survey_model.dart';

class FeedbackFormModel {
  int _id;
  String _name;
  String _gender;
  String _email;
  String _phone;
  String _age;
  String _experience;
  String _dateOfVisit;
  String _visitAgain;
  String _surveyTitle;
  String _welcomeTitle;
  String _welcomeDesc;
  String _welcomeBtnLabel;
  String _thankYouDesc;
  String _thankYouBtnLabel;
  List<String> _choiceList;

  FeedbackFormModel(
      this._name,
      this._gender,
      this._age,
      this._email,
      this._phone,
      this._experience,
      this._dateOfVisit,
      this._visitAgain,
      this._surveyTitle,
      this._welcomeTitle,
      this._welcomeDesc,
      this._welcomeBtnLabel,
      this._thankYouDesc,
      this._thankYouBtnLabel,
      this._choiceList,
      [this._id]);

  FeedbackFormModel.map(dynamic obj) {
    this._id = obj["id"];
    this._name = obj["name"];
    this._gender = obj["gender"];
    this._email = obj["email"];
    this._phone = obj["phone"];
    this._age = obj["age"];
    this._experience = obj["experience"];
    this._dateOfVisit = obj["visit_date"];
    this._visitAgain = obj["visit_again"];
    this._surveyTitle = obj["survey_title"];
    this._welcomeTitle = obj["welcome_screen_title"];
    this._welcomeDesc = obj["welcome_screen_desc"];
    this._welcomeBtnLabel = obj["welcome_screen_btn_title"];
    this._thankYouDesc = obj["thankyou_screen_desc"];
    this._thankYouBtnLabel = obj["thankyou_screen_btn_title"];
    this._choiceList = obj["gender_choice"];
  }

  int get id => _id;
  String get name => _name;
  String get gender => _gender;
  String get age => _age;
  String get phone => _phone;
  String get email => _email;
  String get experience => _experience;
  String get visit_date => _dateOfVisit;
  String get visit_again => _visitAgain;
  String get survey_title => _surveyTitle;
  String get welcome_screen_title => _welcomeTitle;
  String get welcome_screen_desc => _welcomeDesc;
  String get welcome_screen_btn_title => _welcomeBtnLabel;
  String get thankyou_screen_desc => _thankYouDesc;
  String get thankyou_screen_btn_title => _thankYouBtnLabel;
  List<String> get gender_choice => List.unmodifiable(_choiceList);

  Map<String, dynamic> toMapFeedbackForm() {
    var mapFeedbackForm = new Map<String, dynamic>();
    if (_id != null) {
      mapFeedbackForm["id "] = _id;
    }
    mapFeedbackForm["name"] = _name;
    mapFeedbackForm["gender"] = _gender;
    mapFeedbackForm["age"] = _age;
    mapFeedbackForm["phone"] = _phone;
    mapFeedbackForm["email"] = _email;
    mapFeedbackForm["experience"] = _experience;
    mapFeedbackForm["visit_date"] = _dateOfVisit;
    mapFeedbackForm["visit_again"] = _visitAgain;
    mapFeedbackForm["survey_title "] = _surveyTitle;
    mapFeedbackForm["welcome_screen_title "] = _welcomeTitle;
    mapFeedbackForm["welcome_screen_desc "] = _welcomeDesc;
    mapFeedbackForm["welcome_screen_btn_title "] = _welcomeBtnLabel;
    mapFeedbackForm["thankyou_screen_desc "] = _thankYouDesc;
    mapFeedbackForm["thankyou_screen_btn_title "] = _thankYouBtnLabel;
    mapFeedbackForm["gender_choice"] = json.encode(_choiceList);
    return mapFeedbackForm;
  }

  FeedbackFormModel.fromMapFeedbackForm(Map<String, dynamic> map) {
    this._id = map["id"];
    this._name = map["name"];
    this._gender = map["gender"];
    this._email = map["email"];
    this._age = map["age"];
    this._phone = map["phone"];
    this._experience = map["experience"];
    this._dateOfVisit = map["visit_date"];
    this._visitAgain = map["visit_again"];
    this._surveyTitle = map["survey_title"];
    this._welcomeTitle = map["welcome_screen_title"];
    this._welcomeDesc = map["welcome_screen_desc"];
    this._welcomeBtnLabel = map["welcome_screen_btn_title"];
    this._thankYouDesc = map["thankyou_screen_desc"];
    this._thankYouBtnLabel = map["thankyou_screen_btn_title"];
    this._choiceList = List.castFrom<dynamic, String>(
      json.decode(map["gender_choice"]),
    );
  }
}
