import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/cubit.dart';
import 'package:shop_app/layouts/HomeLayout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';
import 'package:shop_app/shared/styles/colors.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = HomeCubit.get(context).userModel.data;
        emailController.text = model.email;
        nameController.text = model.name;
        phoneController.text = model.phone;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              if (state is UpdateUserDataLoadingState)
                LinearProgressIndicator(),
              if (state is UpdateUserDataLoadingState)
                SizedBox(
                  height: 10,
                ),
              Row(
                children: [
                  Text('Profile',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.w600)),
                  Spacer(),
                  IconButton(
                    onPressed: () {
                      HomeCubit.get(context).changeUpdateEditbutton();
                    },
                    icon: CircleAvatar(
                      backgroundColor: defaultColor,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              defaultFormField(
                  isClickable: HomeCubit.get(context).isClicable,
                  controller: nameController,
                  type: TextInputType.text,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Name must not be empty';
                    }
                  },
                  label: 'Name',
                  prefix: Icons.person),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                  isClickable: HomeCubit.get(context).isClicable,
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Email must not be empty';
                    }
                  },
                  label: 'Email',
                  prefix: Icons.email_outlined),
              SizedBox(
                height: 20,
              ),
              defaultFormField(
                  isClickable: HomeCubit.get(context).isClicable,
                  controller: phoneController,
                  type: TextInputType.phone,
                  validate: (String value) {
                    if (value.isEmpty) {
                      return 'Phone must not be empty';
                    }
                  },
                  label: 'Phone',
                  prefix: Icons.phone),
              SizedBox(
                height: 20,
              ),
              ConditionalBuilder(
                condition: true,
                builder: (BuildContext context) => defaultButton(
                  function: () {
                    HomeCubit.get(context).updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
                  },
                  text: 'save & update',
                  isUpperCase: true,
                ),
                fallback: (contex) =>
                    Center(child: CircularProgressIndicator()),
              ),
              SizedBox(
                height: 20,
              ),
              ConditionalBuilder(
                condition: true,
                builder: (BuildContext context) => defaultButton(
                  function: () {
                    signOut(context);
                  },
                  text: 'logout',
                  isUpperCase: true,
                ),
                fallback: (contex) =>
                    Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        );
      },
    );
  }
}
