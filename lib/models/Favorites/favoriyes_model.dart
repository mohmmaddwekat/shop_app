import 'package:shop_app/models/Favorites/favorites_data_model.dart';

class FavoritesModel {
  bool? status;
  String? message;
  FavoritesDataModel? data;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = FavoritesDataModel.fromJson(json['data']);
  }

}
