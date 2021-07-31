import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/states.dart';
import 'package:shop_app/models/categories_model.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/models/home_model.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/CategoriesScreen/categories_screen.dart';
import 'package:shop_app/modules/FavoriteScreen/favorite_screen.dart';
import 'package:shop_app/modules/SettingsScreen/settings_screen.dart';
import 'package:shop_app/modules/productsHomeScreen/products_screen.dart';
import 'package:shop_app/shared/Network/end_points.dart';
import 'package:shop_app/shared/Network/local/sharedPreferences.dart';
import 'package:shop_app/shared/Network/remote/DioHelper.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(InitHomeState());
  static HomeCubit get(context) => BlocProvider.of(context);

  int currnetIndex = 0;
  List<Widget> screens = [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];
  void changeNaveBottomBar(int index) {
    if (currnetIndex == 3) isClicable = false;
    currnetIndex = index;
    emit(ChangeNaveBottomStateState());
  }

  HomeModel homeModel;
  Map<int, bool> favorites = {};
  void getHomeData() {
    emit(HomeDataLoadingState());
    DioHelper.getData(url: HOME, token: CacheHelper.getData(key: 'token'))
        .then((value) {
      homeModel = HomeModel.fromJson(value.data);
      homeModel.data.products.forEach((e) {
        favorites.addAll({e.id: e.inFavorites});
      });

      emit(HomeDataSuccessState(homeModel));
    }).catchError((error) {
      print(error.toString());
      emit(HomeDataErrorState(error));
    });
  }

  CategoriesModel categoriesModel;
  void getCategoriesData() {
    emit(HomeCategoriesDataLoadingState());
    DioHelper.getData(
      url: CATEGORIES,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(HomeCategoriesDataSuccessState(categoriesModel));
    }).catchError((error) {
      print(error.toString());
      emit(HomeCategoriesDataErrorState(error));
    });
  }

  EditFavoritesModel editFavoritesModel;

  void editFavorites({@required int productId}) {
    favorites[productId] = !favorites[productId];
    emit(EditFavoritesLoadingState());
    DioHelper.postData(
            url: FAVORITES,
            data: {'product_id': productId},
            token: CacheHelper.getData(key: 'token'))
        .then((value) {
      editFavoritesModel = EditFavoritesModel.fromJson(value.data);

      if (!editFavoritesModel.status)
        favorites[productId] = !favorites[productId];
      getFavorites();
      emit(EditFavoritesSuccessState(editFavoritesModel));
    }).catchError((error) {
      emit(EditFavoritesErrorState(error.toString()));
      print(error.toString());
    });
  }

  FavoritesModel favoritesModel;

  void getFavorites() {
    emit(GetFavoritesLoadingState());

    DioHelper.getData(
      url: FAVORITES,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);

      emit(GetFavoritesSuccessState(favoritesModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetFavoritesErrorState(error));
    });
  }

  bool isClicable = false;
  void changeUpdateEditbutton() {
    isClicable = !isClicable;
    emit(ChangeUpdateEditbuttonState());
  }

  LoginModel userModel;

  void getUserData() {
    emit(GetUserDataLoadingState());

    DioHelper.getData(
      url: PROFILE,
      token: CacheHelper.getData(key: 'token'),
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);

      emit(GetUserDataSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error));
    });
  }

  void updateUserData({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(UpdateUserDataLoadingState());

    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: CacheHelper.getData(key: 'token'),
      data: {
        'name': name,
        'email': email,
        'phone': phone,
      },
    ).then((value) {
      userModel = LoginModel.fromJson(value.data);
      print(userModel.message);
      isClicable = false;
      emit(UpdateUserDataSuccessState(userModel));
    }).catchError((error) {
      print(error.toString());
      emit(UpdateUserDataErrorState(error));
    });
  }
}
