class FeedbackDataModel {
  int _id;
  String _fdName;
  String _fdGender;
  String _fdEmail;
  String _fdPhone;
  String _fdAge;
  String _fdExperience;
  String _fdDateOfVisit;
  String _fdVisitAgain;

  FeedbackDataModel(
      this._fdName,
      this._fdGender,
      this._fdEmail,
      this._fdPhone,
      this._fdAge,
      this._fdExperience,
      this._fdDateOfVisit,
      this._fdVisitAgain,
      [this._id]);

  FeedbackDataModel.map(dynamic obj) {
    this._id = obj["id"];
    this._fdName = obj["fd_name"];
    this._fdGender = obj["fd_gender"];
    this._fdEmail = obj["fd_age"];
    this._fdPhone = obj["fd_phone"];
    this._fdAge = obj["fd_email"];
    this._fdExperience = obj["fd_experience"];
    this._fdDateOfVisit = obj["fd_visit_date"];
    this._fdVisitAgain = obj["fd_visit_again"];
  }

  int get id => _id;
  String get name => _fdName;
  String get gender => _fdGender;
  String get age => _fdEmail;
  String get phone => _fdPhone;
  String get email => _fdAge;
  String get experience => _fdExperience;
  String get visit_date => _fdDateOfVisit;
  String get visit_again => _fdVisitAgain;

  Map<String, dynamic> toMapFeedbackData() {
    var mapFeedbackForm = new Map<String, dynamic>();
    if (_id != null) {
      mapFeedbackForm["id"] = _id;
    }
    mapFeedbackForm["fd_name"] = _fdName;
    mapFeedbackForm["fd_gender"] = _fdGender;
    mapFeedbackForm["fd_age"] = _fdEmail;
    mapFeedbackForm["fd_phone"] = _fdPhone;
    mapFeedbackForm["fd_email"] = _fdAge;
    mapFeedbackForm["fd_experience"] = _fdExperience;
    mapFeedbackForm["fd_visit_date"] = _fdDateOfVisit;
    mapFeedbackForm["fd_visit_again"] = _fdVisitAgain;
    return mapFeedbackForm;
  }

  FeedbackDataModel.fromMapFeedbackData(Map<String, dynamic> map) {
    this._id = map["id"];
    this._fdName = map["fd_name"];
    this._fdGender = map["fd_gender"];
    this._fdEmail = map["fd_age"];
    this._fdAge = map["fd_email"];
    this._fdPhone = map["fd_phone"];
    this._fdExperience = map["fd_experience"];
    this._fdDateOfVisit = map["fd_visit_date"];
    this._fdVisitAgain = map["fd_visit_again"];
  }
}
