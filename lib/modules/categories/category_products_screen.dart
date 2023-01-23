import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/shared/components/components.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(),
          body: ConditionalBuilder(
            condition: state is! ShopCategoryProductSuccessState,
            builder: (context) =>  ListView.separated(
                itemBuilder: (context, index) => buildListProducts(ShopCubit.get(context).categoryProductsModel!.data!.data[index],context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
          ),
        );
      },

    );
  }
}
