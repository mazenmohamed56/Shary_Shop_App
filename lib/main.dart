import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/cubit.dart';
import 'package:shop_app/modules/LoginScreen/login_screen.dart';
import 'package:shop_app/shared/BlocObserver.dart';
import 'package:shop_app/shared/Network/local/sharedPreferences.dart';
import 'package:shop_app/shared/Network/remote/DioHelper.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'layouts/HomeLayout/home_layout.dart';
import 'modules/BoardingScreen/boarding_screen.dart';
import 'shared/styles/Themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Widget widget;
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  DioHelper.init();
  bool isOnBoarding = CacheHelper.getData(key: 'isOnBoarding');
  String token = CacheHelper.getData(key: 'token');
  if (isOnBoarding != null) {
    if (token != null)
      widget = HomeLayout();
    else
      widget = LoginScreen();
  } else
    widget = BoardingScreen();

  runApp(MyApp(widget));
}

class MyApp extends StatelessWidget {
  @required
  final Widget startWidget;

  MyApp(this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppCubit()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              debugShowCheckedModeBanner: false,
              home: startWidget);
        },
      ),
    );
  }
}
