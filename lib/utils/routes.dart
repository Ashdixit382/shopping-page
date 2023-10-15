import 'package:flutter/material.dart';
import 'package:provider_learning/Screen/cart_page.dart';
import 'package:provider_learning/Screen/product_page_list.dart';
import 'package:provider_learning/utils/routes_name.dart';

class Routes {
  static Route<dynamic> getRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.ProductPage:
        return MaterialPageRoute(builder: (context) => ProductPageList());
      case RoutesName.CartPage:
        return MaterialPageRoute(builder: (context) => CartPage());
      default:
        return MaterialPageRoute(
          builder: (context) {
            return const Scaffold(
              body: Center(
                child: Text('no routes defined '),
              ),
            );
          },
        );
    }
  }
}
