import 'package:shop_app/models/auth/user_model.dart';
class LoginModel
{
  bool? status;
  String? message;
  UserModel? data;
  LoginModel.formJason(Map<String, dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserModel.fromJason(json['data']): null;
  }
}

