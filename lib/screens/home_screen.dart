import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:online_survey/bloc/feedback_form_bloc.dart';
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:online_survey/screens/feedback_form_screen.dart';
import 'package:online_survey/util/database_helper.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final db = new DataBaseHelper();
  final feedbackFormBloc = FeedbackFormBloc();

  @override
  void initState() {
    super.initState();
    feedbackFormBloc.saveData();
  }

  Widget welcomeLabel({String title, String desc}) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 30.0,
            ),
          ),
          SizedBox(height: 10.0,),
          Text(
            desc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.blue,
              fontSize: 20.0,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget startButton({String label}){
    return Padding(
      padding: const EdgeInsets.only(left:50.0, right: 50.0, bottom: 30.0),
      child: RaisedButton(
        color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Text(label, style: TextStyle(
              fontSize: 25.0,
              color: Colors.white
            ),),
          ),
          onPressed: ()=> Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=> FeedbackFormScreen())),
          shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<FeedbackFormModel>(
          stream: feedbackFormBloc.feedbackFormStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              FeedbackFormModel formData = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  welcomeLabel(
                    title: formData.welcome_screen_title,
                    desc: formData.welcome_screen_desc,
                  ),
                  startButton(label: snapshot.data.welcome_screen_btn_title)
                ],
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
