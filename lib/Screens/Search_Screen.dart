import 'package:ecommerce/Models/Products_Model.dart';
import 'package:ecommerce/Repository/products_respository.dart';
import 'package:ecommerce/Screens/ProductDetails_Screen.dart';
import 'package:flutter/material.dart';

class SearchScreen extends SearchDelegate {

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: () {
        query = '';
        showSuggestions(context);
      }, icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: () {
      close(context, null);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Text('Search Result for "$query"');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<ProductsModel>(
      future: ProductsRespository().getProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data != null) {
          final products = snapshot.data!.data.data;

          List<Datum> filteredProducts;
          if (query.isEmpty) {
            filteredProducts = products;
          } else {
            filteredProducts = products
                .where((product) =>
                product.name.toLowerCase().contains(query.toLowerCase()))
                .toList();
          }

          return ListView.builder(
            itemCount: filteredProducts.length,
            itemBuilder: (context, index) {
              final itemProduct = filteredProducts[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) {
                        return ProductdetailsScreen(itemOfProduct: itemProduct);
                      }),

                    );
                  },
                  child: ListTile(
                    leading: SizedBox(
                      width: 50,
                      height: 50,
                      child: Image.network(itemProduct.image),
                    ),
                    title: Text(itemProduct.name),
                  ),
                ),
              );
            },
          );
        } else {
          return Center(child: Text('No results found'));
        }
      },
    );
  }
}
