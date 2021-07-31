import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/cubit.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/states.dart';
import 'package:shop_app/models/favorits_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return ConditionalBuilder(
          condition: state is! GetFavoritesLoadingState,
          builder: (context) => widgetbuilder(context, state, cubit),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget widgetbuilder(context, state, cubit) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state is EditFavoritesLoadingState) LinearProgressIndicator(),
          if (state is EditFavoritesLoadingState)
            SizedBox(
              height: 10,
            ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, top: 10),
            child: Text('Favorites',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
          ),
          SizedBox(
            height: 10,
          ),
          ConditionalBuilder(
            condition: cubit.favoritesModel.data.data.length != 0,
            builder: (context) => Expanded(
                child: listViewBuilder(context, cubit.favoritesModel, cubit)),
            fallback: (context) => Center(
              child: Container(
                child: Text('No products in Favorites',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                        fontWeight: FontWeight.w600)),
              ),
            ),
          )
        ],
      );

  Widget listViewBuilder(context, FavoritesModel model, cubit) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildListProduct(
                  model.data.data[index].product,
                  context,
                  isOldPrice: true,
                ),
            separatorBuilder: (context, index) => mySeparator(),
            itemCount: model.data.data.length),
      );
}
