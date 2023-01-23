import 'package:shop_app/models/categories/page_categories_data_model.dart';

class CategoriesDataModel
{
  int? currentPage;
  List<PageCategoriesDataModel> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json)
  {
    currentPage =json['current_page'];
    json['data'].forEach((element) {
      data.add(PageCategoriesDataModel.fromJson(element));
    });
  }

}

