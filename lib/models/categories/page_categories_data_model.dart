class PageCategoriesDataModel
{
  int? id;
  String? name;
  String? image;
  PageCategoriesDataModel.fromJson(Map<String, dynamic> json)
  {
    id =json['id'];
    name =json['name'];
    image =json['image'];
  }
}