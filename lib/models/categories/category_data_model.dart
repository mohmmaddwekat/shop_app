import 'package:shop_app/models/home/products_model.dart';

class CategoryDataModel
{
  int? currentPage;
  List<ProductsModel> data = [];

  CategoryDataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage = json['current_page'];
      json['data'].forEach((v) {
        data!.add(ProductsModel.fromJson(v));
      });
  }
}