import 'package:shop_app/models/search/search_data_model.dart';

class SearchModel {
  bool? status;
  String? message;
  SearchDataModel? data;
  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SearchDataModel.fromJson(json['data']) : null;
  }
}

