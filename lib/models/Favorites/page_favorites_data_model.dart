import 'package:shop_app/models/home/products_model.dart';

class PageFavoritesDataModel {
  int? id;
  ProductsModel? product;


  PageFavoritesDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = ProductsModel.fromJson(json['product']);
  }
}
