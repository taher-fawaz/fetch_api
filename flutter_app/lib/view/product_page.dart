import 'package:flutter/material.dart';
import 'package:flutter_app/model/product.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatelessWidget {
  final Product product;

  const ProductPage(
    this.product, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 40),
            Text(
              product.content!,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 64),
            ElevatedButton(
              // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              // color: Colors.teal,
              child: const Text(
                'Send Email',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {},
            ),
            Container(
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
                        product.id!,
                        product.title!,
                        product.content!,
                      );
                      ScaffoldMessenger.of(context)
                        ..removeCurrentSnackBar()
                        ..showSnackBar(
                          SnackBar(
                            content: Text(
                              "${product.title!} has been added to your cart",
                            ),
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
                            duration: const Duration(seconds: 2),
                            action: SnackBarAction(
                                label: "UNDO",
                                textColor: Colors.white,
                                onPressed: () {
                                  value.removeSingleItem(product.id!);
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
          ],
        ),
      ),
    );
  }
}
