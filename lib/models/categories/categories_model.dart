import 'package:shop_app/models/categories/categories_data_model.dart';

class CategoriesModel
{
  bool? status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String, dynamic> json)
  {
    status =json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }

}

