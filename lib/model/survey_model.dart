class SurveyModel {
  final String title;
  final SettingsModel settingsModel;
  final List<WelcomeScreenModel> welcomeScreens;
  final List<ThanksYouScreenModel> thankYouScreens;
  final List<SurveyFormFields> surveyFormFields;

  SurveyModel({this.title, this.settingsModel, this.welcomeScreens, this.thankYouScreens, this.surveyFormFields});

  factory SurveyModel.fromJson(Map<String, dynamic> parsedJson) {

    var welcomeList = parsedJson['welcome_screens'] as List;
    List<WelcomeScreenModel> welcomesList = welcomeList.map((i) => WelcomeScreenModel.fromJson(i)).toList();

    var thankList = parsedJson['thankyou_screens'] as List;
    List<ThanksYouScreenModel> thankYouList = thankList.map((i) => ThanksYouScreenModel.fromJson(i)).toList();

    var formFieldList = parsedJson['fields'] as List;
    List<SurveyFormFields> formFields = formFieldList.map((i) => SurveyFormFields.fromJson(i)).toList();
    
    return SurveyModel(
        title: parsedJson['title'],
        settingsModel: SettingsModel.fromJson(parsedJson['settings']),
        welcomeScreens: welcomesList,
        thankYouScreens: thankYouList,
      surveyFormFields: formFields
    );
  }
}

class SettingsModel {
  final String language;

  SettingsModel({this.language});

  factory SettingsModel.fromJson(Map<String, dynamic> parsedJson) {
    return SettingsModel(language: parsedJson['language']);
  }
}

class WelcomeScreenModel {
  final String title;
  final WelcomeScreenProperties welcomeScreenProperties;

  WelcomeScreenModel({this.title, this.welcomeScreenProperties});

  factory WelcomeScreenModel.fromJson(Map<String, dynamic> parsedJson) {
    return WelcomeScreenModel(
        title: parsedJson['title'],
        welcomeScreenProperties: WelcomeScreenProperties.fromJson(parsedJson['properties']));
  }
}

class WelcomeScreenProperties {
  final bool showButton;
  final String buttonText, description;

  WelcomeScreenProperties({this.showButton, this.buttonText, this.description});

  factory WelcomeScreenProperties.fromJson(Map<String, dynamic> parsedJson) {
    return WelcomeScreenProperties(
        showButton: parsedJson['show_button'],
        buttonText: parsedJson['button_text'],
        description: parsedJson['description']);
  }
}

class ThanksYouScreenModel {
  final String title;
  final ThankYouScreenProperties thankYouScreenProperties;

  ThanksYouScreenModel({this.title, this.thankYouScreenProperties});

  factory ThanksYouScreenModel.fromJson(Map<String, dynamic> parsedJson) {
    return ThanksYouScreenModel(
        title: parsedJson['title'],
        thankYouScreenProperties: ThankYouScreenProperties.fromJson(parsedJson['properties']));
  }
}

class ThankYouScreenProperties {
  final bool showButton, shareIcon;
  final String buttonText, buttonMode;

  ThankYouScreenProperties({this.showButton, this.shareIcon, this.buttonText, this.buttonMode});

  factory ThankYouScreenProperties.fromJson(Map<String, dynamic> parsedJson) {
    return ThankYouScreenProperties(
        showButton: parsedJson['show_button'],
        shareIcon: parsedJson['share_icons'],
        buttonText: parsedJson['button_text'],
        buttonMode: parsedJson['button_mode']);
  }
}

class SurveyFormFields {
  final String title;
  final String type;
  final SurveyFormProperties surveyFormProperties;
  final SurveyFormValidation surveyFormValidation;

  SurveyFormFields({this.title, this.type, this.surveyFormProperties, this.surveyFormValidation});

  factory SurveyFormFields.fromJson(Map<String, dynamic> parsedJson) {

    if(parsedJson.containsKey('properties')){
      return SurveyFormFields(
          title: parsedJson['title'],
          type: parsedJson['type'],
          surveyFormProperties: SurveyFormProperties.fromJson(parsedJson['properties']),
          surveyFormValidation: SurveyFormValidation.fromJson(parsedJson['validations'])
      );
    }else{
      return SurveyFormFields(
          title: parsedJson['title'],
          type: parsedJson['type'],
          //surveyFormProperties: SurveyFormProperties.fromJson(parsedJson['properties']),
          surveyFormValidation: SurveyFormValidation.fromJson(parsedJson['validations'])
      );
    }
  }
}

class SurveyFormValidation {
  final bool required;

  SurveyFormValidation({this.required});

  factory SurveyFormValidation.fromJson(Map<String, dynamic> parsedJson) {
    return SurveyFormValidation(required: parsedJson['required']);
  }
}

class SurveyFormProperties {
  final bool alphabeticalOrder;
  final int steps;
  final String shape, structure, separator;
  final List<ChoiceProperties> choiceList;

  SurveyFormProperties(
      {this.alphabeticalOrder, this.steps, this.shape, this.structure, this.separator, this.choiceList});

  factory SurveyFormProperties.fromJson(Map<String, dynamic> parsedJson) {

    List<ChoiceProperties> choicesList;

    if(parsedJson.containsKey('choices')){
      var choiceList = parsedJson['choices'] as List;
      choicesList = choiceList.map((i) => ChoiceProperties.fromJson(i)).toList();
    }else{
      choicesList = [];
    }

    return SurveyFormProperties(
        alphabeticalOrder: parsedJson['alphabetical_order'],
        steps: parsedJson['steps'],
        shape: parsedJson['shape'],
        separator: parsedJson['separator'],
        structure: parsedJson['structure'],
        choiceList: choicesList
    );
  }
}

class ChoiceProperties {
  final String label;

  ChoiceProperties({this.label});

  factory ChoiceProperties.fromJson(Map<String, dynamic> prsedJson) {
    return ChoiceProperties(label: prsedJson['label']);
  }
}
