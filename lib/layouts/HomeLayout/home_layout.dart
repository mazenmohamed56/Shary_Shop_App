import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/cubit.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/states.dart';
import 'package:shop_app/modules/SearchScreen/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class HomeLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()
        ..getHomeData()
        ..getCategoriesData()
        ..getFavorites()
        ..getUserData(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeCubit.get(context);

          return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        navigateTo(context, SearchScreen());
                      })
                ],
                titleSpacing: 10,
                title: Text('Shary'),
              ),
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currnetIndex,
                onTap: (index) {
                  cubit.changeNaveBottomBar(index);
                },
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.home), label: 'Home'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps), label: 'Categories'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.favorite), label: 'Favorite'),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.settings), label: 'Settinges'),
                ],
              ),
              body: cubit.screens[cubit.currnetIndex]);
        },
      ),
    );
  }
}
