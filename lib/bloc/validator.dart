import 'dart:async';

class Validators{

  var emailValidator = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      bool emailValid = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);

      if(emailValid){
        sink.add(email);
      }else{
        sink.addError('Email is invalid');
      }
    }
  );


  var phoneValidator = StreamTransformer<String, String>.fromHandlers(
      handleData: (phoneNo, sink){
        if(phoneNo.length == 10){
          sink.add(phoneNo);
        }else{
          sink.addError('PhoneNo is invalid');
        }
      }
  );

  var validateEmptyField = StreamTransformer<String, String>.fromHandlers(
    handleData: (textField, sink){
      if(textField!=null && textField.isNotEmpty){
        sink.add(textField);
      }else{
        sink.addError('Please enter the value');
      }
    }
  );

}