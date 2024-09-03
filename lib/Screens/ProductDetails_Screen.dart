import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/Cubits/fav_cubit/fav_cubit.dart';
import 'package:ecommerce/Models/Fav_Model.dart';
import 'package:ecommerce/Models/Products_Model.dart';
import 'package:ecommerce/Screens/Search_Screen.dart';
import'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class ProductdetailsScreen extends StatefulWidget {
   const ProductdetailsScreen({required this.itemOfProduct, super.key});

 final Datum itemOfProduct;

  @override
  State<ProductdetailsScreen> createState() => _ProductdetailsScreenState();
}

class _ProductdetailsScreenState extends State<ProductdetailsScreen> {
  bool isFav = false;
  @override
  Widget build(BuildContext context) {

    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.itemOfProduct.name,style: const TextStyle(
          color: Color(0xff9098B1),
          fontWeight: FontWeight.w700,
        ),),
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: const Icon(Icons.arrow_back,color: Color(0xff9098B1),),),
        actions:[IconButton(onPressed: (){ showSearch(context: context, delegate: SearchScreen());}, icon: const Icon(Icons.search,color: Color(0xff9098B1),),),
          IconButton(
            onPressed: () {


              final favCubit = context.read<FavCubit>();

              final favItem = FavModel(widget.itemOfProduct);
              favCubit.addItemToFav(favItem);
              setState(() {
              isFav =true;
              });
            },
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border_outlined,
              color: isFav ?  Colors.red : const Color(0xff9098B1),
            ),
          ),


        ]
      ),
      body: SizedBox(
        child: Container(
          padding: EdgeInsets.all(widthScreen*0.04),
          width: widthScreen,
          height: heightScreen,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
            CarouselSlider(
            options: CarouselOptions(
              height: heightScreen*0.34,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 2),
              autoPlayCurve: Curves.easeInOut,
            ),
            items: widget.itemOfProduct.images.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    width:widthScreen*0.54,
                    height: heightScreen*0.25,
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(i), // Load image from a URL
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
                    ),
            SizedBox(height: heightScreen*0.02,),
            Text(widget.itemOfProduct.name,style: const TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.w700,
            ),),
                SizedBox(height: heightScreen*0.02,),
                Container(
                  width: widthScreen*0.3,
                  padding: EdgeInsets.all(widthScreen*0.015),
                  height: heightScreen*0.1,
                  decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        widget.itemOfProduct.price.toString(),
                        style: TextStyle(
                          fontSize: widthScreen*0.04,
                          color: const Color(0xff40BFFF),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                       SizedBox(height: heightScreen*0.01),
                      Container(
                        constraints: BoxConstraints(maxWidth: widthScreen*0.5),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Row(
                            children: [
                              Text(
                                widget.itemOfProduct.oldPrice.toString(),
                                style: TextStyle(
                                  fontSize: widthScreen*0.04,
                                  color: const Color(0xff9098B1),
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                              SizedBox(width: widthScreen*0.02),
                              Text(
                                '${widget.itemOfProduct.discount}% Off',
                                style: TextStyle(
                                  fontSize: widthScreen*0.04,
                                  color: const Color(0xffFB7181),
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
                SizedBox(height: heightScreen*0.02,),
                SizedBox(
                width: widthScreen,
                child: Text(widget.itemOfProduct.description,textAlign: TextAlign.right,style: TextStyle(fontSize: widthScreen*0.04),)),
            ],),
          ),
        ),
      ),
    );
  }
}
