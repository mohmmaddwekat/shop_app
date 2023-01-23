import 'package:shop_app/models/home/banners_model.dart';
import 'package:shop_app/models/home/products_model.dart';

class HomeDataModel
{
  List<BannersModel> banners = [];
  List<ProductsModel> products = [];
  HomeDataModel.fromJson(Map<String, dynamic> json)
  {
    json['banners'].forEach((element){
      banners.add(BannersModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(ProductsModel.fromJson(element));

    });
  }
}