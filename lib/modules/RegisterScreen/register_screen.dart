import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/HomeLayout/home_layout.dart';
import 'package:shop_app/modules/RegisterScreen/cubit/cubit.dart';
import 'package:shop_app/modules/RegisterScreen/cubit/states.dart';
import 'package:shop_app/shared/Network/local/sharedPreferences.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterScreenStates>(
        listener: (context, state) {
          if (state is RegisterSucssesState) {
            if (state.model.status) {
              print(state.model.message);
              print(state.model.data.token);
              CacheHelper.putData(
                key: 'token',
                value: state.model.data.token,
              ).then((value) {
                token = state.model.data.token;
                print(token);

                navigateAndFinsh(
                  context,
                  HomeLayout(),
                );
              });
            } else {
              print(state.model.message);
              showToast(msg: state.model.message, state: ToastState.ERROR);
            }
          }
        },
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
              appBar: AppBar(),
              body: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Register',
                              style: TextStyle(
                                fontSize: 35,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              'Welcome To Shop App , Register now to see our new offers',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey[700],
                              )),
                          SizedBox(
                            height: 50,
                          ),
                          defaultFormField(
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
                              onSubmit: (value) {},
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              validate: (String value) {
                                if (value.isEmpty) {
                                  return 'Password is to short';
                                }
                              },
                              suffixPressed: () {
                                cubit.changePasswordVisibilty();
                              },
                              label: 'Password',
                              prefix: Icons.lock,
                              isPassword: cubit.isPassword,
                              suffix: cubit.suffix),
                          SizedBox(
                            height: 20,
                          ),
                          defaultFormField(
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
                            condition: state is! RegisterLoadingState,
                            builder: (BuildContext context) => defaultButton(
                              function: () {
                                if (formKey.currentState.validate()) {
                                  cubit.postRegister(
                                      email: emailController.text,
                                      password: passwordController.text,
                                      name: nameController.text,
                                      phone: phoneController.text);
                                }
                              },
                              text: 'Register',
                              isUpperCase: true,
                            ),
                            fallback: (contex) =>
                                Center(child: CircularProgressIndicator()),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
