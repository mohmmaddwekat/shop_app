import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/categories/categories_data_model.dart';
import 'package:shop_app/modules/categories/category_products_screen.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoriesScreen extends StatelessWidget {
  CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){
        if(state is ShopCategoryProductSuccessState)
          {
            navigateAndFinish(context, CategoryProductsScreen());
          }
      },
      builder: (context, state){
        CategoriesDataModel model = ShopCubit.get(context).categoriesModel!.data!;
        return ListView.separated(
            itemBuilder: (context, index) => buildCategoryItem(model.data[index], context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: model.data.length
        );
      },

    );
  }
}
