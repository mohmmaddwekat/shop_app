import 'package:shop_app/models/Favorites/change_favorites_model.dart';
import 'package:shop_app/models/auth/login_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopBottomState extends ShopStates {}

class ShopGetSearchLoadingState extends ShopStates {}

class ShopSearchSuccessState extends ShopStates {}

class ShopSearchErrorState extends ShopStates {
  final String error;

  ShopSearchErrorState(this.error);
}

class ShopChangeModeState extends ShopStates {}

class ShopHomeSuccessState extends ShopStates {}

class ShopHomeErrorState extends ShopStates {
  String? error;

  ShopHomeErrorState(this.error);
}

class ShopCategoriesSuccessState extends ShopStates {}

class ShopCategoriesErrorState extends ShopStates {
  String? error;

  ShopCategoriesErrorState(this.error);
}

class ShopCategoryProductLoadingState extends ShopStates {}

class ShopCategoryProductSuccessState extends ShopStates {}

class ShopCategoryProductErrorState extends ShopStates {
  String? error;

  ShopCategoryProductErrorState(this.error);
}

class ShopFavoritesSuccessState extends ShopStates {
  final ChangeFavoritesModel model;

  ShopFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesState extends ShopStates {}

class ShopFavoritesErrorState extends ShopStates {
  String? error;

  ShopFavoritesErrorState(this.error);
}

class ShopLoadingGetFavoritesState extends ShopStates {}

class ShopGetFavoritesSuccessState extends ShopStates {}

class ShopGetFavoritesErrorState extends ShopStates {
  String? error;

  ShopGetFavoritesErrorState(this.error);
}

class ShopLoadingUserDataSuccessState extends ShopStates {}

class ShopUserDataSuccessState extends ShopStates {
  final LoginModel login;

  ShopUserDataSuccessState(this.login);
}

class ShopUserDataErrorState extends ShopStates {
  String? error;

  ShopUserDataErrorState(this.error);
}

class ShopLoadingUpdateUserSuccessState extends ShopStates {}

class ShopUpdateUserSuccessState extends ShopStates {
  final LoginModel login;

  ShopUpdateUserSuccessState(this.login);
}

class ShopUpdateUserErrorState extends ShopStates {
  String? error;

  ShopUpdateUserErrorState(this.error);
}
