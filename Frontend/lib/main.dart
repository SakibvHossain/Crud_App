import 'package:crud_app/screens/product_list_screen.dart';
import 'package:crud_app/utils/routes_name.dart';
import 'package:crud_app/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'utils/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Define the light theme (optional)
      themeMode: ThemeMode.dark, // Force dark theme
      debugShowCheckedModeBanner: false,
      title: "Employee Management System",
      initialRoute: RoutesName.homeScreen,
      onGenerateRoute: Routes.generateRoutes,
      home: ProductListScreen(),
    );
  }
}



