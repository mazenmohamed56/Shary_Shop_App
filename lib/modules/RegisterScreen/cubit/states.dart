import 'package:flutter/widgets.dart';
import 'package:shop_app/models/login_model.dart';

abstract class RegisterScreenStates {}

class InitRegisterState extends RegisterScreenStates {}

class RegisterLoadingState extends RegisterScreenStates {}

class RegisterSucssesState extends RegisterScreenStates {
  @required
  LoginModel model;
  RegisterSucssesState(this.model);
}

class RegisterErrorState extends RegisterScreenStates {
  @required
  String error;
  RegisterErrorState(this.error);
}

class RegisterPasswordIconChange extends RegisterScreenStates {}
