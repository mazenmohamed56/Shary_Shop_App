import 'package:flutter/widgets.dart';
import 'package:shop_app/models/login_model.dart';

abstract class LoginScreenStates {}

class InitLoginState extends LoginScreenStates {}

class LoginLoadingState extends LoginScreenStates {}

class LoginSucssesState extends LoginScreenStates {
  @required
  LoginModel model;
  LoginSucssesState(this.model);
}

class LoginErrorState extends LoginScreenStates {
  @required
  String error;
  LoginErrorState(this.error);
}

class LoginPasswordIconChange extends LoginScreenStates {}
