

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Cubits/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/Cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/Models/Banner_Model.dart';
import 'package:ecommerce/Models/Categories_Model.dart';
import 'package:ecommerce/Models/Products_Model.dart';
import 'package:ecommerce/Repository/banner_respository.dart';
import 'package:ecommerce/Repository/categories_respository.dart';
import 'package:ecommerce/Repository/products_respository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';














Widget buildCircle() {
  CategoriesRespository categoriesRespository = CategoriesRespository();
  return FutureBuilder<CategoriesModel>(
    future: categoriesRespository.getCategories(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text('Error: ${snapshot.error}'));
      } else if (snapshot.hasData && snapshot.data != null) {
        return Container(
          height: 100, // Provide a fixed height if needed
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true, // Allows the ListView to take only as much space as needed
            itemCount: snapshot.data!.data.data.length,
            itemBuilder: (context, index) {
              final itemCategories = snapshot.data!.data.data[index];
              return Container(
                width: 108,
                child: Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: Color(0xffEBF0FF),
                        child: CircleAvatar(
                          radius: 34,
                          backgroundColor: Colors.white,
                          child: Image.network(itemCategories.image),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      itemCategories.name,
                      style: TextStyle(
                        color: Color(0xff9098B1),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      } else {
        return Text('No data available');
      }
    },
  );
}

Widget GG(){
  return BlocProvider(
    create: (context) => CategoriesCubit(CategoriesRespository())..Categories_Items(),
    child: BlocBuilder<CategoriesCubit, CategoriesState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is CategoriesFaildNotVaild) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is CategoriesSuccess) {
          return Container(
            height: 100, // Provide a fixed height if needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: state.categories_res.data!.data.length,
              itemBuilder: (context, index) {
                final itemCategories = state.categories_res.data!.data[index];
                return Container(
                  width: 108,
                  child: Column(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        child: CircleAvatar(
                          radius: 35,
                          backgroundColor: Color(0xffEBF0FF),
                          child: CircleAvatar(
                            radius: 34,
                            backgroundColor: Colors.white,
                            child: Image.network(itemCategories.image,),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        itemCategories.name,
                        style: TextStyle(
                          color: Color(0xff9098B1),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else {
          return Text('No data available');
        }
      },
    ),
  );
}


Widget Products() {
        return BlocProvider(
          create: (context)=> ProductCubit(ProductsRespository())..Products(),
          child: BlocBuilder<ProductCubit,ProductState>(
            builder: (context,state){
              if(state is ProductLoading)
                {
                  return Center(child: CircularProgressIndicator());
                }
              else if(state is ProductFaildNotVaild){
                return Center(child: Text('Error: ${state.message}'));
              }
              else if(state is ProductSuccess)
                {
                  return Container(
                    height: 290,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.productsModel_res.data!.data.length,
                      itemBuilder: (context, index) {
                        final itemProduct = state.productsModel_res.data!.data[index];
                        return Container(
                          padding: EdgeInsets.all(16),
                          height: 290,
                          width: 141,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                            border: Border.all(
                              color: Color(0xffEBF0FF),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 109,
                                height: 109,
                                child: Image.network(itemProduct.image),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                itemProduct.name,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                style: TextStyle(
                                  color: Color(0xff223263),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                itemProduct.price.toString(),
                                style: TextStyle(
                                  color: Color(0xff40BFFF),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                constraints: BoxConstraints(maxWidth: 105),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Row(
                                    children: [
                                      Text(
                                        itemProduct.oldPrice.toString(),
                                        style: TextStyle(
                                          color: Color(0xff9098B1),
                                          decoration: TextDecoration.lineThrough,
                                        ),
                                      ),
                                      const SizedBox(width: 3.8),
                                      Text(
                                        '${itemProduct.discount}% Off',
                                        style: TextStyle(
                                          color: Color(0xffFB7181),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
              else {
                return Text('No data available');
              }
            }

          ),
        );
}

