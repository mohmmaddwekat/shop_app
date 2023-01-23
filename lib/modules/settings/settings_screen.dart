import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/shared/components/form/default_button.dart';
import 'package:shop_app/shared/components/form/default_form_field.dart';
import 'package:shop_app/shared/constants/constants.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        LoginModel? model = ShopCubit.get(context).userModel;
        print(token);
        print(model!.data!.name);
        nameController.text = model.data!.name!;
        emailController.text = model.data!.email!;
        phoneController.text = model.data!.phone!;
        return ConditionalBuilder(
          condition: ShopCubit.get(context).userModel != null,
          builder: (context) => SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    if(state is ShopLoadingUpdateUserSuccessState)
                      LinearProgressIndicator(),
                    SizedBox(height: 20,),
                    DefaultFomField
                      (
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultFomField
                      (
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'email must not be empty';
                        }
                        return null;
                      },
                      label: 'Email',
                      prefix: Icons.email,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultFomField
                      (
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String? value)
                      {
                        if(value!.isEmpty)
                        {
                          return 'phone must not be empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                        function: (){
                          if(formKey.currentState!.validate())
                            {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                        },
                        text: 'UPDATE',
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    DefaultButton(
                      function: (){
                        ShopCubit.get(context).currentIndex = 0;
                        signOut(context);
                      },
                      text: 'LOGOUT',
                    ),
                  ],
                ),
              ),
            ),
          ),
          fallback: (context) =>  Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
