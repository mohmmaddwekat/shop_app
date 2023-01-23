import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/shop_layout.dart';
import 'package:shop_app/modules/login/cubit.dart';
import 'package:shop_app/modules/register/cubit.dart';
import 'package:shop_app/modules/register/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/form/default_button.dart';
import 'package:shop_app/shared/components/form/default_form_field.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/constants/styles/styles.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state)
        {
          if (state is RegisterSuccessState) {
            if (state.loginModel!.status!) {
              showSnackBar(context,text: state.loginModel!.message!, state: SnackBarState.SUCCESS);
              CacheHelper.saveData(
                  key: 'token',
                  value: state.loginModel!.data!.token
              ).then((value) {
                token = state.loginModel!.data!.token;
                ShopCubit.get(context).getUserData();
                navigateAndFinish(context, ShopLayout());
              }).catchError((error){
                print(error);
              });
            } else {
              showSnackBar(context,text: state.loginModel!.message!, state: SnackBarState.ERROR);
            }
          }
        },
        builder: (context, state)
        {
          RegisterCubit loginCubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                child: Padding(
                  padding: EdgeInsets.all(defaultPadding_20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                            color: darkColor,
                          ),
                        ),
                        Text(
                          'Register now to browse our hot offers',
                          style: Theme
                              .of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                              color: greyColor
                          ),
                        ),
                        SizedBox(
                          height: height_40 - 10,
                        ),
                        DefaultFomField(
                            controller: nameController,
                            type: TextInputType.name,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your name address';
                              }
                            },
                            label: 'Name',
                            prefix: Icons.person
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFomField(
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your email address';
                              }
                            },
                            label: 'Email Address',
                            prefix: Icons.email_outlined
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFomField(
                          controller: passwordController,
                          suffix: loginCubit.suffix,
                          suffixPressed: () {
                            loginCubit.changePasswordVisibility();
                          },
                          onSubmit: (value) {
                          },
                          type: TextInputType.visiblePassword,
                          isPassword: loginCubit.isPassword,
                          validate: (String? value) {
                            if (value!.isEmpty) {
                              return 'password is  too short';
                            }
                          },
                          label: 'Password',
                          prefix: Icons.lock_outline,
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        DefaultFomField(
                            controller: phoneController,
                            type: TextInputType.phone,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter your phone address';
                              }
                            },
                            label: 'Phone',
                            prefix: Icons.phone
                        ),
                        SizedBox(
                          height: height_40 - 10,
                        ),
                        ConditionalBuilder(
                          condition: state is! RegisterLoadingState,
                          builder: (context) => DefaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                RegisterCubit.get(context).userRegister(
                                  name: nameController.text,
                                  email: emailController.text,
                                  password: passwordController.text,
                                  phone: phoneController.text
                                );
                              }
                            },
                            text: 'register',
                            isUpperCase: true,
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator()),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
