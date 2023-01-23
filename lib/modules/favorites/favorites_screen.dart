import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/Favorites/change_favorites_model.dart';
import 'package:shop_app/models/Favorites/page_favorites_data_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/constants/styles/styles.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state){},
      builder: (context, state){
        return ConditionalBuilder(
            condition: state is ShopGetFavoritesSuccessState && ShopCubit.get(context).favoritesModel != null,
            builder: (context) =>  ListView.separated(
                itemBuilder: (context, index) => buildListProducts(ShopCubit.get(context).favoritesModel!.data!.data[index].product!,context),
                separatorBuilder: (context, index) => myDivider(),
                itemCount: ShopCubit.get(context).favoritesModel!.data!.data.length
            ),
            fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },

    );
  }
}
