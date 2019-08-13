import 'package:http/http.dart' as http;
import 'package:online_survey/bloc/validator.dart';
import 'package:online_survey/model/feedback_data_model.dart';
import 'dart:convert' as convert;
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:online_survey/model/survey_model.dart';
import 'package:online_survey/util/database_helper.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackDataBloc extends Object with Validators {
  final db = new DataBaseHelper();

  static final _nameController = BehaviorSubject<String>();
  static final _genderController = BehaviorSubject<String>();
  static final _ageController = BehaviorSubject<String>();
  static final _emailController = BehaviorSubject<String>();
  static final _phoneNoController = BehaviorSubject<String>();
  static final _experienceController = BehaviorSubject<String>();
  static final _visitDateController = BehaviorSubject<String>();
  static final _visitAgainController = BehaviorSubject<String>.seeded(1.toString());

  Stream<String> get nameStream => _nameController.stream.transform(validateEmptyField);
  Stream<String> get genderStream => _genderController.stream.transform(validateEmptyField);
  Stream<String> get ageStream => _ageController.stream.transform(validateEmptyField);
  Stream<String> get emailStream => _emailController.stream.transform(emailValidator);
  Stream<String> get phoneNoStream => _phoneNoController.stream.transform(phoneValidator);
  Stream<String> get experienceStream => _experienceController.stream.transform(validateRating);
  Stream<String> get visitDateStream => _visitDateController.stream.transform(validateEmptyField);
  Stream<String> get visitAgainStream => _visitAgainController.stream;

  Function(String) get nameSink => _nameController.sink.add;
  Sink<String> get genderSink => _genderController.sink;
  Function(String) get ageSink => _ageController.sink.add;
  Function(String) get emailSink => _emailController.sink.add;
  Function(String) get phoneNoSink => _phoneNoController.sink.add;
  Sink<String> get experienceSink => _experienceController.sink;
  Sink<String> get visitDateSink => _visitDateController.sink;
  Sink<String> get visitAgainSink => _visitAgainController.sink;

  Stream<bool> get submitCheck =>
      Observable.combineLatest6(nameStream, genderStream, ageStream, emailStream, visitDateStream, visitAgainStream,
          (n, g, a, e, vd, va) {
        if (_nameController.value != null &&
            _genderController.value != null &&
            _ageController.value != null &&
            _emailController.value != null &&
            _visitDateController.value != null &&
            _visitAgainController.value != null) {
          return true;
        } else {
          return false;
        }
      });

  void saveData() async {
    FeedbackDataModel formData = FeedbackDataModel(
        _nameController.value,
        _genderController.value,
        _emailController.value,
        _phoneNoController.value,
        _ageController.value,
        _experienceController.value,
        _visitDateController.value,
        _visitAgainController.value);

    print("Saved Data: $formData");

    await db.insertFeedbackData(formData).then((data) {
      print("Saved Survey Data: $data");
      db.getFeedbackData();
    });
  }

  dispose() {
    _nameController.close();
    _genderController.close();
    _ageController.close();
    _emailController.close();
    _phoneNoController.close();
    _experienceController.close();
    _visitDateController.close();
    _visitAgainController.close();
  }
}
