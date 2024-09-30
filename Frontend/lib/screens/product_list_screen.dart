import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/product.dart';
import '../utils/routes_name.dart';
import '../widgets/product_item.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  List<Product> productList = [];
  bool inProgress = false;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint("ProductItem build called");
    return inProgress ? Center(child: CircularProgressIndicator(),) : Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Product List"),
        actions: [
          ElevatedButton(onPressed: (){
            getProductList();
          }, child: const Icon(Icons.refresh))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListView.separated(
            itemBuilder: (context, index) {
              return ProductItem(product: productList[index],);
            },
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 16,
              );
            },
            itemCount: productList.length),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, RoutesName.addProductScreen);
      },
        child: const Icon(Icons.add),),
    );
  }

  Future<void> getProductList() async {
    inProgress = true;

    setState(() {

    });

    Uri uri = Uri.parse('http://localhost:8080/api/product/getAllProduct');
    Response response = await get(uri);
    // print(response.statusCode);
    // print(response.body);

    if (response.statusCode == 200) {
      productList.clear();

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      for (var item in jsonResponse['data']) {
        Product product = Product(id: item['id'],
            productName: item['productName'],
            productCode: item['productCode'],
            productImage: item['img'],
            unitPrice: item['unitPrice'],
            quantity: item['qty'],
            totalPrice: item['totalPrice']);

        productList.add(product);
      }
    }
    inProgress = false;
    setState(() {

    });
  }
}
