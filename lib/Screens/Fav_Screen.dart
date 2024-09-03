import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce/Cubits/fav_cubit/fav_cubit.dart';
import 'package:ecommerce/Cubits/fav_cubit/fav_state.dart';

class FavScreen extends StatelessWidget {
  const FavScreen({super.key});

  @override
  Widget build(BuildContext context) {

    double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites',style: TextStyle(fontSize: widthScreen*0.06,fontWeight: FontWeight.w700),),
      ),
      body: SafeArea(
        child: BlocBuilder<FavCubit, FavState>(
          builder: (context, state) {
            if (state is FavLoadedState) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  return ListTile(
                    leading: SizedBox(
                      width: widthScreen*0.2,
                      child: Image.network(item.favList.image),
                    ),
                    title: Text(item.favList.name,style: TextStyle(fontSize: widthScreen*0.035),),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        context.read<FavCubit>().removeItemFromFav(item);
                      },
                    ),
                  );
                },
              );
            } else if (state is FavLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text('No favorites yet.'));
            }
          },
        ),
      ),
    );
  }
}
