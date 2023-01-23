import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/categories/categories_model.dart';
import 'package:shop_app/models/categories/page_categories_data_model.dart';
import 'package:shop_app/models/home/home_model.dart';
import 'package:shop_app/models/home/products_model.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shop_app/shared/constants/styles/styles.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';


class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer <ShopCubit, ShopStates>(
        listener: (context, state){
          if(state is ShopFavoritesSuccessState)
            {
              if(!state.model.status!)
                {
                  showSnackBar(context, text: state.model.message!, state: SnackBarState.ERROR);
                }
            }
        },
        builder: (context, state) {
          ShopCubit shopCubit = ShopCubit.get(context);
          return ConditionalBuilder(
              condition: shopCubit.homeModel != null && shopCubit.categoriesModel != null,
              builder: (context) => productsBuilder
                (
                  shopCubit.homeModel,
                  shopCubit.categoriesModel,context
              ),
              fallback: (context) => Center(child: CircularProgressIndicator(),)
          );
        },
      )
    );
  }

  Widget productsBuilder(HomeModel? model, CategoriesModel? categoriesModel, context) => SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CarouselSlider(
            items:
              model!.data!.banners.map((e) {
                return CachedNetworkImage(
                  imageUrl: '${e.image}',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                );
              }).toList(),
            options: CarouselOptions(
              height: 250.0,
              viewportFraction: 1.0,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(seconds: 1),
              autoPlayCurve: Curves.fastOutSlowIn,
              scrollDirection: Axis.horizontal,
            )
        ),
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Categories',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                height: 100.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) => buildCategoriesItem(categoriesModel!.data!.data[index]),
                  separatorBuilder: (context, index) => SizedBox(
                    width: 10.0,
                  ),
                  itemCount: categoriesModel!.data!.data.length,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'New Products',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            mainAxisSpacing: 1.0,
            crossAxisSpacing: 2.0,
            childAspectRatio: 1 / 1.51,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: List.generate(
              model.data!.products.length,
                  (index) => buildGridProduct(model.data!.products[index],context),
              ),
          ),
        ),
      ],
    ),
  );

  Widget buildCategoriesItem(PageCategoriesDataModel model) => Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children: [
      CachedNetworkImage(
        imageUrl: '${model.image}',
        width: 100,
        height: 100,
        placeholder: (context, url) => CircularProgressIndicator(),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
      Container(
        color: Colors.black.withOpacity(.8,),
        width: 100.0,
        child: Text(
          '${model.name}',
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductsModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            CachedNetworkImage(
              imageUrl: '${model.image}',
              width: 200,
              height: 200,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            if(model.discount !=0)
              Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0,),
              color: Colors.red,
              child: Text(
                'DISCOUNT',
                style: TextStyle(
                  fontSize: 8.0,
                  color: Colors.white
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  height: 1.3
                ),
              ),
              Row(
                children: [
                  Text(
                    '${model.price.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount !=0)
                    Text(
                    '${model.oldPrice.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        ShopCubit.get(context).changeFavorites(model.id!);
                        print(model.id);
                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]! ? Colors.redAccent : Colors.grey,
                        radius: 15.0,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                          color: Colors.white,
                        ),
                      ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
