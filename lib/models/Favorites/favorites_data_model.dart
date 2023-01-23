import 'package:shop_app/models/Favorites/page_favorites_data_model.dart';

class FavoritesDataModel {
  int? currentPage;
  List<PageFavoritesDataModel> data = [];
  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(PageFavoritesDataModel.fromJson(element));
    });
  }
}