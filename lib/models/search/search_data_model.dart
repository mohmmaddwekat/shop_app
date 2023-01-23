import 'package:shop_app/models/home/products_model.dart';

class SearchDataModel {
  int? currentPage;
  List<ProductsModel> data = [];
  SearchDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(ProductsModel.fromJson(element));
    });
  }
}
