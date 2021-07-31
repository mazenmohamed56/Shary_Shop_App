import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/cubit.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/styles/colors.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20, top: 10),
              child: Text('Categories',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              height: 10,
            ),
            ConditionalBuilder(
              condition: HomeCubit.get(context).categoriesModel != null,
              builder: (context) => Expanded(child: listViewBuilder(context)),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          ],
        );
      },
    );
  }

  Widget listViewBuilder(context) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Image(
                          fit: BoxFit.cover,
                          width: 100,
                          height: 100,
                          image: NetworkImage(HomeCubit.get(context)
                              .categoriesModel
                              .data
                              .categories[index]
                              .image)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        HomeCubit.get(context)
                            .categoriesModel
                            .data
                            .categories[index]
                            .name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Spacer(),
                      IconButton(
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: defaultColor,
                          ),
                          onPressed: () {})
                    ],
                  ),
                ),
            separatorBuilder: (context, index) => mySeparator(),
            itemCount:
                HomeCubit.get(context).categoriesModel.data.categories.length),
      );
}
