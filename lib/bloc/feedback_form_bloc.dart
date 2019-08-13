import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:online_survey/model/survey_model.dart';
import 'package:online_survey/util/database_helper.dart';
import 'package:rxdart/rxdart.dart';

class FeedbackFormBloc{
  final db = new DataBaseHelper();

  final _feedbackFormController = BehaviorSubject<FeedbackFormModel>();

  Stream<FeedbackFormModel> get feedbackFormStream => _feedbackFormController.stream;
  Sink<FeedbackFormModel> get feedbackFormSink => _feedbackFormController.sink;


  saveData() async {

    var url = "https://firebasestorage.googleapis.com/v0/b/collect-plus-6ccd0.appspot.com/o/mobile_tasks%2Fform_task.json?alt=media&token=d048a623-415e-41dd-ad28-8f77e6c546be";

    // Await the http get response, then decode the json-formatted responce.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      print("jsonResponse : $jsonResponse");
      SurveyModel surveyModel = SurveyModel.fromJson(jsonResponse);
      //print("surveyModel : " + surveyModel.surveyFormFields[1].surveyFormProperties.choiceList.map((controller) => controller.label.toString()).toList(growable: false).toString());


      FeedbackFormModel formModel = FeedbackFormModel(
          surveyModel.surveyFormFields[0].title,
          surveyModel.surveyFormFields[1].title,
          surveyModel.surveyFormFields[2].title,
          surveyModel.surveyFormFields[3].title,
          surveyModel.surveyFormFields[4].title,
          surveyModel.surveyFormFields[5].title,
          surveyModel.surveyFormFields[6].title,
          surveyModel.surveyFormFields[7].title,
          surveyModel.title,
          surveyModel.welcomeScreens[0].title,
          surveyModel.welcomeScreens[0].welcomeScreenProperties.description,
          surveyModel.welcomeScreens[0].welcomeScreenProperties.buttonText,
          surveyModel.thankYouScreens[0].title,
          surveyModel.thankYouScreens[0].thankYouScreenProperties.buttonText,
        surveyModel.surveyFormFields[1].surveyFormProperties.choiceList.map((controller) => controller.label.toString()).toList(growable: false),

      );

      //print("formModel: " + formModel.welcome_screen_desc.toString());

      await db.insertFeedbackForm(formModel).then((val){
        print("data inserted $val");
        getFeedbackForm();
      });

    } else {
      print("Request failed with status: ${response.statusCode}.");
    }
  }

  getFeedbackForm()async{
    db.getSurveyForm().then((data){
      print("Data Added $data");
      feedbackFormSink.add(data);
      print("Dtata: ${_feedbackFormController.value}");
    });
  }

  dispose(){
    _feedbackFormController.close();

  }

}