import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/safe_area_values.dart';
import 'package:top_snackbar_flutter/tap_bounce_container.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';// import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/layout/shop_app/states.dart';
import 'package:shop_app/models/boarding_model.dart';
import 'package:shop_app/models/categories/page_categories_data_model.dart';
import 'package:shop_app/models/home/products_model.dart';
import 'package:shop_app/shared/constants/styles/styles.dart';

Widget conditionalBuilder({
  required bool condition,
  required Widget builder,
  Widget? fallback,
}) =>
    condition ? builder : fallback ?? Container();

Widget myDivider() => Padding(
      padding: EdgeInsets.all(defaultPadding_20-10),
      child: Container(
        width: doubleInfinity,
        height: height_1,
        color: greyColor,
        padding: EdgeInsetsDirectional.only(
          start: defaultPadding_20,
        ),
      ),
    );

void navigateTo(context, widget) => Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (route) => false);

Widget buildBoardingItem(BoardingModel model) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(model.image),
          ),
        ),
        SizedBox(
          height: defaultHeight_20 + 10,
        ),
        Text(
          model.title,
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: defaultHeight_20,
        ),
        Text(
          model.body,
          style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: defaultHeight_20,
        ),
      ],
    );

void showSnackBar(context,{
  required String text,
  required SnackBarState state,
}) => showTopSnackBar(
  context,
  chooseToastColor(state, text),
);

enum SnackBarState{SUCCESS, ERROR, WARNING}

Widget chooseToastColor(SnackBarState state, String text)
{
  Widget customSnackBar;
 switch(state) {
   case SnackBarState.SUCCESS:
     customSnackBar = CustomSnackBar.success(message: text);
     break;
   case SnackBarState.ERROR:
     customSnackBar = CustomSnackBar.error(message: text);
     break;
   case SnackBarState.WARNING:
     customSnackBar = CustomSnackBar.info(message: text,backgroundColor: Colors.amber,);
     break;
 }
 return customSnackBar;
}

Widget buildListProducts(ProductsModel model, context,{bool isSearch = false}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Container(
          height: 120.0,
          width: 120.0,
          child: Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              CachedNetworkImage(
                imageUrl: '${model.image}',
                fit: BoxFit.cover,
                width: 200,
                height: 200,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
              if(isSearch && model.discount !=0)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 5.0,),
                  color: Colors.red,
                  child: Text(
                    '${model.discount}',
                    style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white
                    ),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
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
              Spacer(),
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
                  if(isSearch && model.discount !=0)
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
                    },
                    icon: CircleAvatar(
                      backgroundColor:
                      ShopCubit.get(context).favorites[model.id!]! ?
                      Colors.redAccent : Colors.grey,
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
  ),
);

Widget buildCategoryItem(PageCategoriesDataModel model, context) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: GestureDetector(
    onTap: (){
      ShopCubit.get(context).getCategoryProductData(model.id!);
    },
    child: Row(
      children: [
        Image(
          image: NetworkImage('${model.image}'),
          width: 80.0,
          height: 80.0,
        ),
        SizedBox(
          width: 20.0,
        ),
        Text(
          '${model.name}',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(),
        Icon(
          Icons.arrow_forward_ios,
        ),
      ],
    ),
  ),
);
