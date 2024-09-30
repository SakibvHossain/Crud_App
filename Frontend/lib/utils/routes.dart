import 'package:crud_app/main.dart';
import 'package:crud_app/model/product.dart';
import 'package:crud_app/screens/add_product.dart';
import 'package:crud_app/screens/product_list_screen.dart';
import 'package:crud_app/screens/update_product_list.dart';
import 'package:crud_app/utils/routes_name.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case RoutesName.addProductScreen:
        return MaterialPageRoute(builder: (context) => const AddProduct());

      case RoutesName.homeScreen:
        return MaterialPageRoute(
            builder: (context) => const ProductListScreen());


      default:
        return MaterialPageRoute(builder: (context) {
          return const Scaffold(
            body: Center(
              child: Text('No routes defined'),
            ),
          );
        });
    }
  }
}
