import 'package:shop_app/models/categories/categories_data_model.dart';
import 'package:shop_app/models/categories/category_data_model.dart';

class CategoryProductsModel {
  bool? status;
  String? message;
  CategoryDataModel? data;

  CategoryProductsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? CategoryDataModel.fromJson(json['data']) : null;
  }
}


