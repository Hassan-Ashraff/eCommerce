import 'package:ecommerce/Cubits/auth_cubit/auth_cubit.dart';
import 'package:ecommerce/Cubits/banner_cubit/banner_cubit.dart';
import 'package:ecommerce/Cubits/categories_cubit/categories_cubit.dart';
import 'package:ecommerce/Cubits/fav_cubit/fav_cubit.dart';
import 'package:ecommerce/Cubits/product_cubit/product_cubit.dart';
import 'package:ecommerce/Repository/banner_respository.dart';
import 'package:ecommerce/Repository/categories_respository.dart';
import 'package:ecommerce/Repository/products_respository.dart';
import 'package:ecommerce/Screens/Splash_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(CategoriesRespository()),
        ),
        BlocProvider<ProductCubit>(
          create: (context) => ProductCubit(ProductsRespository()),
        ),
        BlocProvider<BannerCubit>(
          create: (context) => BannerCubit(BannerRespository()),
        ),
        BlocProvider<FavCubit>(
          create: (context) => FavCubit(),
        ),
      ],
    child: DevicePreview(
    enabled: false,
    builder: (context) => MaterialApp(
    debugShowCheckedModeBanner: false,

        theme: ThemeData(
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    ));
  }
}
