
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/modules/register/states.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class RegisterCubit extends Cubit<RegisterStates>
{

  RegisterCubit() : super(RegisterInitialState());

  static RegisterCubit get(context) =>  BlocProvider.of(context);
  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;
  LoginModel? loginModel;
  void userRegister({
    required String name,
    required String email,
    required String password,
    required String phone,
  })
  {
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'name' : name,
        'email' : email,
        'password' : password,
        'phone' : phone,
      },
    ).then((value){
      loginModel = LoginModel.formJason(value.data);
      print(loginModel.toString());
      emit(RegisterSuccessState(loginModel));
    }).catchError((error){
      print(error);
      emit(RegisterErrorState(error.toString()));
    });
  }

  void changePasswordVisibility()
  {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ChangeRegisterPasswordVisibilityState());
  }
}