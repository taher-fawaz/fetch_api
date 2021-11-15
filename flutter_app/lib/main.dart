import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_app/view/cart_page.dart';
import 'package:flutter_app/view/product_network_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Cart()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.teal,
          ),
          home: const MainPage(title: "Taher fawaz Test"),
          routes: {CartPage.routeName: (context) => const CartPage()},
        ),
      );
}

class MainPage extends StatelessWidget {
  final String? title;
  const MainPage({this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(title!),
          actions: <Widget>[
            Stack(
              children: [
                Consumer<Cart>(builder: (context, value, ch) {
                  return Badge(
                    position: BadgePosition.topEnd(top: 0, end: 3),
                    badgeColor: Colors.white,
                    animationDuration: const Duration(milliseconds: 300),
                    animationType: BadgeAnimationType.slide,
                    badgeContent: Text(
                      value.itemCount.toString(),
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  );
                }),
                IconButton(
                    icon: const Icon(
                      Icons.shopping_basket,
                      color: Color(0xFF3a3737),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, CartPage.routeName);
                    }),
              ],
            )
          ],
        ),
        body: const ProductNetworkPage(),
      );
}
