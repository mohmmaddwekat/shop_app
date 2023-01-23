import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit.dart';
import 'package:shop_app/models/home/products_model.dart';
import 'package:shop_app/modules/search/cubit.dart';
import 'package:shop_app/modules/search/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/form/default_form_field.dart';
import 'package:shop_app/shared/constants/styles/styles.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state){

        },
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    DefaultFomField(
                      controller: searchController,
                      type: TextInputType.text,
                      validate: (String? value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'enter text to search';
                            }
                          return null;
                        },
                      onSubmit: (String value)
                      {
                        SearchCubit.get(context).search(value);                      },
                      label: 'Search',
                      prefix: Icons.search,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchLoadingState)
                      LinearProgressIndicator(),
                    if(state is SearchSuccessState)
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) => buildListProducts(SearchCubit.get(context).model!.data!.data[index],context),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount: SearchCubit.get(context).model!.data!.data.length
                      ),
                      ),
                  ],
                ),
              ),
            )
          );
        },
      ),
    );
  }
}
