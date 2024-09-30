import 'package:crud_app/model/product.dart';
import 'package:crud_app/screens/update_product_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../utils/routes_name.dart';

// class ProductItem extends StatefulWidget {
//   const ProductItem({super.key});
//
//   @override
//   State<ProductItem> createState() => _ProductItemState();
// }
//
// class _ProductItemState extends State<ProductItem> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     //debugPrint("ProductItem build called");
//     return
//   }
//
//   Future<void> getProductList() async{
//     Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
//     Response response = await get(uri);
//     print(response.statusCode);
//     print(response.body);
//   }
// }

class ProductItem extends StatelessWidget {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      tileColor: Colors.white,
      title: Text("Product Name: ${product.productName}"),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Product Code: ${product.productCode}"),
          Text("Product Price: \$ ${product.unitPrice}"),
          Text("Product Quantity: ${product.quantity}"),
          Text("Total Price: \$ ${product.totalPrice}"),
          Divider(),
          ButtonBar(
            children: [
              TextButton.icon(
                // Wrap editButton with an anonymous function to pass context later
                onPressed: () => editButton(context),
                icon: const Icon(Icons.edit),
                label: const Text('Edit'),
              ),
              TextButton.icon(
                onPressed: () => deleteButton(context),
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                label: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void editButton(BuildContext context) {
    debugPrint(product
        .productName); // Check if the product is not null before navigating
    // Navigator.pushNamed((context), RoutesName.updateProductScreen, arguments: product.productName);

    String name = product.productName.toString();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProductList(product: product),
      ),
    );
  }


  void deleteButton(BuildContext context) {
    _deleteProduct(context);
  }

  Future<void> _deleteProduct(BuildContext context) async {
    final url = Uri.parse(
        'http://localhost:8080/api/product/deleteById/${product
            .id}'); // Correct URL

    try {
      print("Attempting to delete product with ID: ${product.id}");
      print("URL: $url");

      final response = await delete(url);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Product deleted successfully")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to delete product")),
        );
      }
    } catch (e) {
      print("Error occurred while deleting product: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error occurred while deleting product")),
      );
    }
  }
}
