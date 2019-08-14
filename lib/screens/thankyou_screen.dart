import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_survey/bloc/feedback_form_bloc.dart';
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:online_survey/screens/feedback_form_screen.dart';
import 'package:online_survey/util/database_helper.dart';

class ThankYouScreen extends StatelessWidget {
  FeedbackFormModel formModel;


  ThankYouScreen({this.formModel});

  @override
  Widget build(BuildContext context) {

    Widget welcomeLabel({String title, String desc}) {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset('images/thankyou.png', height: MediaQuery.of(context).size.height/2,),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 10.0,),
          ],
        ),
      );
    }

    Widget startButton({String label, FeedbackFormModel feedbackForm}){
      return Padding(
        padding: const EdgeInsets.only(left:50.0, right: 50.0, bottom: 30.0),
        child: RaisedButton(
            color: Colors.green[200],
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(label, style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.black
              ),),
            ),
            onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> FeedbackFormScreen(formModel: feedbackForm,))),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))
        ),
      );
    }


    return Scaffold(
      backgroundColor: Colors.white30,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          welcomeLabel(
            title: formModel.thankyou_screen_desc??"null",
          ),
          startButton(label: formModel.thankyou_screen_btn_title??"null", feedbackForm: formModel)
        ],
      ),
    );
  }
}
