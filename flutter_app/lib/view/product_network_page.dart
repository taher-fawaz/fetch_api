import 'package:flutter/material.dart';
import 'package:flutter_app/api/products_api.dart';
import 'package:flutter_app/model/product.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_app/view/product_page.dart';
import 'package:provider/provider.dart';

class ProductNetworkPage extends StatelessWidget {
  const ProductNetworkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        body: FutureBuilder<List<Product>>(
          future: ProductsApi.getProducts(),
          builder: (context, snapshot) {
            final products = snapshot.data;

            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (snapshot.hasError) {
                  return const Center(child: Text('Some error occurred!'));
                } else {
                  return buildProducts(products!);
                }
            }
          },
        ),
      );

  Widget buildProducts(List<Product> products) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];

        return ListTile(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ProductPage(product),
          )),
          title: Text(product.title!),
          subtitle: Text(product.content!),
          leading: Container(
              height: 28,
              width: 28,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white70,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFfae3e2),
                      blurRadius: 25.0,
                      offset: Offset(0.0, 0.75),
                    ),
                  ]),
              child: Consumer<Cart>(builder: (context, value, ch) {
                return IconButton(
                  onPressed: () {
                    value.addCartItem(
                      products[index].id!,
                      products[index].title!,
                      products[index].content!,
                    );
                    ScaffoldMessenger.of(context)
                      ..removeCurrentSnackBar()
                      ..showSnackBar(
                        SnackBar(
                          content: Text(
                            "${products[index].title!} has been added to your cart",
                          ),
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                              label: "UNDO",
                              textColor: Colors.white,
                              onPressed: () {
                                value.removeSingleItem(products[index].id!);
                              }),
                        ),
                      );
                  },
                  padding: const EdgeInsets.only(right: 10),
                  icon: Icon(
                    Icons.shopping_cart,
                    color: Theme.of(context).colorScheme.secondary,
                    size: 26,
                  ),
                );
              })),
        );
      },
    );
  }
}
