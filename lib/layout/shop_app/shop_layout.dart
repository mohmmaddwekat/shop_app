import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/modules/search/search_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit shopCubit= ShopCubit.get(context);
    return BlocConsumer <ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder:  (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Shop App',
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
              )
            ],
          ),
          body: shopCubit.bottomScreen[shopCubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: shopCubit.currentIndex,
            items: shopCubit.bottomItems,
            onTap: (index) {
              shopCubit.changeBottom(index);
            },
          ),
        );
      },
    );
  }
}
