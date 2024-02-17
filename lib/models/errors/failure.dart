import 'package:food_app/models/errors/exceptions.dart';

mixin Failure {
  String get message;

  String get title;

  bool get isInternetConnectionError =>
      runtimeType is NoInternetConnectionException;

  getMessagefromServer(Map error) {
    // checking the error format
    // so i can apporpriately get the error message
    // Note: input errors are different from normal error
    late String errorMessage;
    //input error test
    if (error.containsKey("message")) {
      //get the first error model in the list then
      //the msg of the error
      errorMessage = error["message"];
    }
    // normal error test
    else if (error.containsKey("data")) {
      errorMessage = error["errors"];
    } //default
    else if (error.containsKey("data")) {
      errorMessage = error["details"];
    } //default
    else {
      errorMessage = "Error";
    }
    return errorMessage;
  }
}
