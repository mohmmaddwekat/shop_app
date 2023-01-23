import 'package:shop_app/models/home/home_data_model.dart';

class HomeModel
{
  bool? status;
  HomeDataModel? data;
  HomeModel.fromJson(Map<String, dynamic> json)
  {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}


