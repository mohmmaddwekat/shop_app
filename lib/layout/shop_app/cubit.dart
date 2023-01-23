import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/Favorites/change_favorites_model.dart';
import 'package:shop_app/models/Favorites/favoriyes_model.dart';
import 'package:shop_app/models/auth/login_model.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/categories/category_products_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorites_screen.dart';
import 'package:shop_app/modules/products/products_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/constants/constants.dart';
import 'package:shop_app/shared/network/end_point.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  bool isDark = false;
  int currentIndex = 0;
  List<Widget> bottomScreen =
  [
    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];
  HomeModel? homeModel;
  Map<int, bool> favorites = {};
  CategoriesModel? categoriesModel;
  CategoryProductsModel? categoryProductsModel;
  ChangeFavoritesModel? changeFavoritesModel;
  FavoritesModel? favoritesModel;
  LoginModel? userModel;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
            Icons.home
        ),
        label: 'Home'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.category
        ),
        label: 'Categories'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.favorite
        ),
        label: 'Favorites'
    ),
    BottomNavigationBarItem(
        icon: Icon(
            Icons.settings
        ),
        label: 'Settings'
    ),
  ];

  static ShopCubit get(context) => BlocProvider.of(context);

  void changeBottom(index) {
    currentIndex = index;
    switch(currentIndex)
    {
      case 0 :
        getHomeData();
        break;
      case 1 :
        getCategoriesData();
        break;
      case 2 :
        getFavoritesData();
        break;
      case 3 :
        getUserData();
        break;
    }
    emit(ShopBottomState());
  }

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ShopChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.saveData(
          key: 'isDark',
          value: isDark
      ).then((value) {
        emit(ShopChangeModeState());
      });
    }
  }

  void getHomeData()
  {
    DioHelper.getData(
        url: HOME,
      token: token,
    ).then((value)
    {
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products.forEach((element) {
        favorites.addAll({
          element.id! : element.inFavorites!,
        });
      });
      print(favorites.toString());
      emit(ShopHomeSuccessState());
    }).catchError((error)
    {
      print(error);
      emit(ShopHomeErrorState(error.toString()));
    });
  }

  void getCategoriesData()
  {
    DioHelper.getData(
        url: GET_CATEGORIES,
    ).then((value)
    {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopCategoriesSuccessState());
    }).catchError((error)
    {
      print(error);
      emit(ShopCategoriesErrorState(error.toString()));
    });
  }

  void getCategoryProductData(int categoryId)
  {
    emit(ShopCategoryProductLoadingState());
    DioHelper.getData(
        url: GET_CATEGORYPRODUCTS,
        query: {
          'category_id' : categoryId,
        }
    ).then((value)
    {
      categoryProductsModel = CategoryProductsModel.fromJson(value.data);
      print(categoryProductsModel.toString());
      emit(ShopCategoryProductSuccessState());
    }).catchError((error)
    {
      print(error);
      emit(ShopCategoryProductErrorState(error.toString()));
    });
  }

  void changeFavorites(int productId)
  {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoritesState());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id' : productId,
      },
      token:  token,
    )
        .then((value){
          changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
          if(!changeFavoritesModel!.status!)
            {
              favorites[productId] = !favorites[productId]!;
            } else
              {
                getFavoritesData();
              }
          emit(ShopFavoritesSuccessState(changeFavoritesModel!));
        })
        .catchError((error){
          favorites[productId] = !favorites[productId]!;
          emit(ShopFavoritesErrorState(error));
        });
  }

  void getFavoritesData()
  {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value)
    {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopGetFavoritesSuccessState());
    }).catchError((error)
    {
      print(error);
      emit(ShopGetFavoritesErrorState(error.toString()));
    });
  }

  void getUserData()
  {
    emit(ShopLoadingUserDataSuccessState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      print('----------');
      print(token);
      userModel = LoginModel.formJason(value.data);
      emit(ShopUserDataSuccessState(userModel!));
    }).catchError((error)
    {
      print(error);
      emit(ShopUserDataErrorState(error.toString()));
    });
  }

  void updateUserData({
  required String name,
  required String email,
  required String phone,
})
  {
    emit(ShopLoadingUpdateUserSuccessState());
    DioHelper.putData(
      url: UPDATE_PROPFILE,
      token: token,
      data: {
        'name' : name,
        'email' : email,
        'phone' : phone,
      },
    ).then((value)
    {
      userModel = LoginModel.formJason(value.data);
      emit(ShopUpdateUserSuccessState(userModel!));
    }).catchError((error)
    {
      print(error);
      emit(ShopUpdateUserErrorState(error.toString()));
    });
  }
}