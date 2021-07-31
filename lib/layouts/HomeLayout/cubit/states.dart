import 'package:flutter/material.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';

abstract class HomeStates {}

class InitHomeState extends HomeStates {}

class ChangeNaveBottomStateState extends HomeStates {}

class HomeDataLoadingState extends HomeStates {}

class HomeDataSuccessState extends HomeStates {
  @required
  HomeModel model;
  HomeDataSuccessState(this.model);
}

class HomeDataErrorState extends HomeStates {
  @required
  String error;
  HomeDataErrorState(this.error);
}

class HomeCategoriesDataLoadingState extends HomeStates {}

class HomeCategoriesDataSuccessState extends HomeStates {
  @required
  CategoriesModel model;
  HomeCategoriesDataSuccessState(this.model);
}

class HomeCategoriesDataErrorState extends HomeStates {
  @required
  String error;
  HomeCategoriesDataErrorState(this.error);
}

class EditFavoritesLoadingState extends HomeStates {}

class EditFavoritesSuccessState extends HomeStates {
  @required
  EditFavoritesModel model;
  EditFavoritesSuccessState(this.model);
}

class EditFavoritesErrorState extends HomeStates {
  @required
  String error;
  EditFavoritesErrorState(this.error);
}

class GetFavoritesLoadingState extends HomeStates {}

class GetFavoritesSuccessState extends HomeStates {
  @required
  FavoritesModel model;
  GetFavoritesSuccessState(this.model);
}

class GetFavoritesErrorState extends HomeStates {
  @required
  String error;
  GetFavoritesErrorState(this.error);
}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {
  @required
  LoginModel model;
  GetUserDataSuccessState(this.model);
}

class GetUserDataErrorState extends HomeStates {
  @required
  String error;
  GetUserDataErrorState(this.error);
}

class UpdateUserDataLoadingState extends HomeStates {}

class UpdateUserDataSuccessState extends HomeStates {
  @required
  LoginModel model;
  UpdateUserDataSuccessState(this.model);
}

class UpdateUserDataErrorState extends HomeStates {
  @required
  String error;
  UpdateUserDataErrorState(this.error);
}

class ChangeUpdateEditbuttonState extends HomeStates {}
