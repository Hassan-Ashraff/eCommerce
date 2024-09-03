import 'package:ecommerce/Cubits/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/Cubits/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/Cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/Repository/banner_respository.dart';
import 'package:ecommerce/Repository/categories_respository.dart';
import 'package:ecommerce/Repository/products_respository.dart';
import 'package:ecommerce/Screens/Fav_Screen.dart';
import 'package:ecommerce/Screens/Login_Screen.dart';
import 'package:ecommerce/Screens/ProductDetails_Screen.dart';
import 'package:ecommerce/Screens/Search_Screen.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {
  void logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access-token');

    if (token != null && token.isNotEmpty) {
      // Remove the token
      await prefs.remove('access-token');

      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
            builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor:const Color(0xff40BFFF),
        leading: IconButton(onPressed: (){
          logout();


        }, icon: const Icon(Icons.exit_to_app,color: Color(0xff223263),),),


        title:const Text('Lafyuu',style: TextStyle( color: Color(0xff223263),
            fontWeight: FontWeight.w700),),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){ showSearch(context: context, delegate: SearchScreen());}, icon: const Icon(Icons.search,color: Color(0xff223263),),),

          IconButton(onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const FavScreen();

                }),

              );

          }, icon: const Icon(Icons.favorite_border_outlined,color: Color(0xff223263),),),



        ],

      ),
      body:
      Container(
        width: widthScreen,
        height: heightScreen,
        padding: EdgeInsets.all(widthScreen*0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocProvider(
                create: (context)=> BannerCubit(BannerRespository())..getBannersItem(),
                child: BlocBuilder<BannerCubit,BannerState>(
                  builder: (context,state) {
                    if(state is BannerLoading)
                      {
                        return const Center(child: CircularProgressIndicator(),);
                      }
                    else if(state is BannerFailed)
                      {
                        return Center(child: Text('Error: ${state.message}'));
                      }
                    else if(state is BannerSuccess){
                      return CarouselSlider(
                        options: CarouselOptions(
                          height: heightScreen*0.3,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 2),
                          autoPlayCurve: Curves.easeInOut,
                        ),
                        items: state.banner_res.data.map((bannerItem) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                margin:  EdgeInsets.symmetric(horizontal: widthScreen*0.01),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    image: NetworkImage(bannerItem.image), // Load image from a URL
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              );
                            },
                          );
                        }).toList(),
                      );
                    }
                  else{
                      return const Center(child: Text('No data available'));
                    }
                  }
                ),
              ),
               SizedBox(
                   height: heightScreen*0.035//24
              ),
              //category
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(
                      fontSize: widthScreen*0.04,
                        color: const Color(0xff223263),
                        fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'More Category',
                    style: TextStyle(
                        fontSize: widthScreen*0.04,
                        color: const Color(0xff40BFFF),
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
               SizedBox(
                   height: heightScreen*0.013//12
              ),
          BlocProvider(
            create: (context) => CategoriesCubit(CategoriesRespository())..Categories_Items(),
            child: BlocBuilder<CategoriesCubit, CategoriesState>(
              builder: (context, state) {
                if (state is CategoriesLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is CategoriesFaildNotVaild) {
                  return Center(child: Text('Error: ${state.message}'));
                } else if (state is CategoriesSuccess) {
                  return SizedBox(
                    height: 100, // Provide a fixed height if needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: state.categories_res.data.data.length,
                      itemBuilder: (context, index) {
                        final itemCategories = state.categories_res.data.data[index];
                        return SizedBox(
                          width: widthScreen*0.2,
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: widthScreen*0.07,
                                backgroundColor: const Color(0xffEBF0FF),
                                child:  CircleAvatar(
                                  radius: widthScreen*0.069,
                                  backgroundImage: NetworkImage(itemCategories.image,),
                                ),
                              ),
                               SizedBox(height: heightScreen*0.01),
                              Text(
                                itemCategories.name,
                                style:  TextStyle(
                                  fontSize: widthScreen*0.03,
                                  color: const Color(0xff9098B1),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Text('No data available');
                }
              },
            ),
          ),
              SizedBox(
                  height: heightScreen*0.035//24
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Text(
                    'Flash Sale',
                    style: TextStyle(
                      fontSize: widthScreen*0.04,
                        color: const Color(0xff223263),
                        fontWeight: FontWeight.w700),
                  ),
                  GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushAndRemoveUntil(
                        //   MaterialPageRoute(builder: (context) {
                        //     return SuperFlashSale();
                        //   }),
                        //       (route) => false,
                        // );
                      },
                      child:  Text(
                        'See More',
                        style: TextStyle(
                            fontSize: widthScreen*0.04,
                            color: const Color(0xff40BFFF),
                            fontWeight: FontWeight.w700),
                      )),
                ],
              ),
               SizedBox(
                height: heightScreen*0.02,
              ),
          BlocProvider(
            create: (context)=> ProductCubit(ProductsRespository())..Products(),
            child: BlocBuilder<ProductCubit,ProductState>(
                builder: (context,state){
                  if(state is ProductLoading)
                  {
                    return const Center(child: CircularProgressIndicator());
                  }
                  else if(state is ProductFaildNotVaild){
                    return Center(child: Text('Error: ${state.message}'));
                  }
                  else if(state is ProductSuccess)
                  {
                    return SizedBox(
                      height: heightScreen*0.41,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: state.productsModel_res.data.data.length,
                        itemBuilder: (context, index) {
                          final itemProduct = state.productsModel_res.data.data[index];
                          return Row(
                            children: [
                              InkWell(
                                onTap:(){
                                  Navigator.of(context).push(
                                    MaterialPageRoute(builder: (context) {
                                      return ProductdetailsScreen(itemOfProduct: itemProduct,);
                                    }),

                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(widthScreen*0.04),
                                  height: heightScreen*0.41,
                                  width: widthScreen*0.34,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                    border: Border.all(
                                      color: const Color(0xffEBF0FF),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: widthScreen*0.3,
                                        height: heightScreen*0.15,
                                        child: Image.network(itemProduct.image),
                                      ),
                                       SizedBox(height: heightScreen*0.02),
                                      SizedBox(
                                        height:heightScreen*0.1,
                                        child: Text(
                                          itemProduct.name,
                                          overflow: TextOverflow.ellipsis,
                                         maxLines: 3,
                                          style: const TextStyle(
                                            color:  Color(0xff223263),
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: heightScreen*0.02),
                                      Text(
                                        itemProduct.price.toString(),
                                        style: const TextStyle(
                                          color: Color(0xff40BFFF),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Container(
                                        constraints:  BoxConstraints(maxWidth: widthScreen*0.5),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Row(
                                            children: [
                                              Text(
                                                itemProduct.oldPrice.toString(),
                                                style: const TextStyle(
                                                  color: Color(0xff9098B1),
                                                  decoration: TextDecoration.lineThrough,
                                                ),
                                              ),
                                               SizedBox(width: widthScreen*0.02),
                                              Text(
                                                '${itemProduct.discount}% Off',
                                                style: const TextStyle(
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
                                ),
                              ),
                               SizedBox(width: widthScreen*0.03,),
                            ],
                          );
                        },
                      ),
                    );
                  }
                  else {
                    return const Center(child: CircularProgressIndicator());

                  }
                }

            ),
          ),

            ],
          ),
        ),
      ),
    );
  }
}
