class BannersModel
{
  int? id;
  String? image;
  String? category;
  String? product;
  BannersModel.fromJson(Map<String, dynamic> json)
  {
    id = json['id'];
    image = json['image'];
    category = json['category'];
    product = json['product'];
  }
}