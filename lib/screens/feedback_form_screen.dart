import 'package:flutter/material.dart';
import 'package:online_survey/bloc/feedback_data_bloc.dart';
import 'package:online_survey/bloc/feedback_form_bloc.dart';
import 'package:online_survey/model/feedback_form_model.dart';
import 'package:online_survey/widgets/text_fied.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:intl/intl.dart';

class FeedbackFormScreen extends StatefulWidget {
  final FeedbackFormModel formModel;

  FeedbackFormScreen({this.formModel});

  @override
  _FeedbackFormScreenState createState() => _FeedbackFormScreenState();
}

class _FeedbackFormScreenState extends State<FeedbackFormScreen> {
  final feedbackDataBloc = FeedbackDataBloc();
  final feedbackFormBloc = FeedbackFormBloc();

  Widget genderWidget({String hintText, BuildContext context, List<String> choicesList}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(4.0), border: Border.all(color: Colors.grey)),
        child: StreamBuilder<String>(
            stream: feedbackDataBloc.genderStream,
            builder: (context, snapshot) {
              return DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text('  $hintText'),
                  value: snapshot.data,
                  //<String>['Male', 'Female', 'Rather not say']
                  items: choicesList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    feedbackDataBloc.genderSink.add(val);
                  },
                ),
              );
            }),
      ),
    );
  }

  Widget dateOfVisit({BuildContext context, String hintText}) {
    Future _selectDate() async {
      DateTime picked = await showDatePicker(
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(2016),
          lastDate: new DateTime(2020));

      var formatter = new DateFormat('MM/dd/yyyy');
      String formatted = formatter.format(picked);
      if (picked != null) feedbackDataBloc.visitDateSink.add(formatted.toString());
    }

    TextEditingController dateOfVisitController = TextEditingController();

    return StreamBuilder<String>(
        stream: feedbackDataBloc.visitDateStream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            dateOfVisitController.text = snapshot.data.toString();
          }

          return InkWell(
            onTap: () {
              _selectDate(); // Call Function that has showDatePicker()
            },
            child: IgnorePointer(
                child: TextFieldWidget(
              controller: dateOfVisitController,
              hintText: hintText,
              enable: false,
            )),
          );
        });
  }

  Widget ratingWidget({String ratingLabel}) {
    var rating = 0.0;

    return StreamBuilder<Object>(
        stream: feedbackDataBloc.experienceStream,
        builder: (context, snapshot) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  ratingLabel,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              SmoothStarRating(
                  allowHalfRating: false,
                  onRatingChanged: (v) {
                    rating = v;
                    feedbackDataBloc.experienceSink.add(v.toString());
                  },
                  starCount: 7,
                  rating: snapshot.hasData ? double.parse(snapshot.data) : rating,
                  size: 40.0,
                  color: Colors.green,
                  borderColor: Colors.green,
                  spacing: 0.0),
              snapshot.hasError?Text("Please add rating", style: TextStyle(
                color: Colors.red
              ),):SizedBox()
            ],
          );
        });
  }

  Widget revisitWidget({String revisitLabel}) {
    return StreamBuilder<String>(
        stream: feedbackDataBloc.visitAgainStream,
        builder: (context, snapshot) {
          print("radio: ${snapshot.data}");
          int selectedRadio = int.parse(snapshot.data ?? 1.toString());
          return Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  revisitLabel,
                  style: TextStyle(
                    fontSize: 20.0,
                  ),
                ),
              ),
              Radio(
                value: 1,
                groupValue: selectedRadio,
                activeColor: Colors.green,
                onChanged: (val) {
                  print("Radio $val");
                  feedbackDataBloc.visitAgainSink.add(val.toString());
                  //setSelectedRadio(val);
                },
              ),
              Radio(
                value: 2,
                groupValue: selectedRadio,
                activeColor: Colors.blue,
                onChanged: (val) {
                  print("Radio $val");
                  feedbackDataBloc.visitAgainSink.add(val.toString());
                },
              ),
            ],
          );
        });
  }

  Widget submitButton() {
    return StreamBuilder(
        stream: feedbackDataBloc.submitCheck,
        builder: (context, snapshot) {
          return MaterialButton(
            color: Colors.blue,
            onPressed: snapshot.hasData && snapshot.data ? () => feedbackDataBloc.saveData() : null,
            child: Text("Save"),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    FeedbackFormModel formData = widget.formModel;

    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  TextFieldWidget(
                    hintText: formData.name,
                    stream: feedbackDataBloc.nameStream,
                    onChanged: feedbackDataBloc.nameSink,
                  ),
                  TextFieldWidget(
                    hintText: formData.email,
                    stream: feedbackDataBloc.emailStream,
                    onChanged: feedbackDataBloc.emailSink,
                  ),
                  TextFieldWidget(
                    hintText: formData.phone,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    stream: feedbackDataBloc.phoneNoStream,
                    onChanged: feedbackDataBloc.phoneNoSink,
                  ),
                  TextFieldWidget(
                    hintText: formData.age,
                    keyboardType: TextInputType.number,
                    stream: feedbackDataBloc.ageStream,
                    onChanged: feedbackDataBloc.ageSink,
                  ),
                  genderWidget(hintText: formData.gender, context: context, choicesList: formData.gender_choice),
                  dateOfVisit(
                    context: context,
                    hintText: formData.visit_date,
                  ),
                  ratingWidget(ratingLabel: formData.experience),
                  revisitWidget(revisitLabel: formData.visit_again),
                  submitButton()
                ],
              ),
            ),
          )),
    );
  }
}
