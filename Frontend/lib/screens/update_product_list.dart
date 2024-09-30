import 'dart:convert';

import 'package:crud_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class UpdateProductList extends StatefulWidget {
  final Product product;

  const UpdateProductList({super.key, required this.product});

  @override
  State<UpdateProductList> createState() => _UpdateProductListState();
}

class _UpdateProductListState extends State<UpdateProductList> {
  late TextEditingController _nameController;
  late TextEditingController _codeController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  late TextEditingController _quantityController;
  late TextEditingController _unitPriceController;

  bool inProgress = false;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing product data for update
    _nameController =
        TextEditingController(text: widget.product.productName ?? '');
    _codeController =
        TextEditingController(text: widget.product.productCode ?? '');
    _imageController =
        TextEditingController(text: widget.product.productImage ?? '');
    _unitPriceController =
        TextEditingController(text: widget.product.unitPrice.toString() ?? '');
    _quantityController =
        TextEditingController(text: widget.product.quantity.toString() ?? '');
    _priceController =
        TextEditingController(text: widget.product.totalPrice.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _codeController.dispose();
    _imageController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    _unitPriceController.dispose();
    super.dispose();
  }

  final bool _inProgress = false;

  final _formKey = GlobalKey<
      FormState>(); //Global key is used for 1. Validation, 2. Saving data 3. Resetting fields value

  // Reusable text field widget
  Widget _reusableTextFormField(
      {required String labelTextField,
      required String hintTextField,
      required TextEditingController textEditingController,
      TextInputType keyboardTypeField = TextInputType.text,
      TextInputAction textInputActionField = TextInputAction.next}) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: labelTextField,
          hintText: hintTextField,
          hintStyle: const TextStyle(
            color: Color(0xFFA2A2A2),
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
          border: OutlineInputBorder()),
      controller: textEditingController,
      keyboardType: keyboardTypeField,
      textInputAction: textInputActionField,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $hintTextField";
        }
        return null;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _nameController,
                  labelTextField: 'Product Name',
                  hintTextField: 'Name',
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _codeController,
                  labelTextField: 'Product Code',
                  hintTextField: 'Code',
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _unitPriceController,
                  labelTextField: 'Product Price',
                  hintTextField: 'Price',
                  keyboardTypeField: TextInputType.number,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _imageController,
                  labelTextField: 'Product Image',
                  hintTextField: 'Image',
                  keyboardTypeField: TextInputType.url,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _quantityController,
                  labelTextField: 'Product Quantity',
                  hintTextField: 'Quantity',
                  keyboardTypeField: TextInputType.number,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _priceController,
                  labelTextField: 'Total Price',
                  hintTextField: 'Total',
                  keyboardTypeField: TextInputType.number,
                  textInputActionField: TextInputAction.done,
                ),
                SizedBox(height: 20),
                inProgress ? const Center(child: CircularProgressIndicator(),) : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size.fromWidth(double.maxFinite)),
                  onPressed: _onTabAddProductButton,
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTabAddProductButton() {
    if (_formKey.currentState?.validate() ?? false) {
      _submit();
      // _formKey.currentState?.reset(); //Using global key for resetting the field values
      //_formKey.currentState?.save(); //Using global key for saving the data
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      inProgress = true;
    });

    // Use the text property of each TextEditingController
    final productData = {
      "img": _imageController.text, // Use .text to get the input value
      "productCode": _codeController.text,
      "productName": _nameController.text,
      "qty": int.parse(_quantityController.text), // Assuming Qty should be an integer
      "totalPrice": double.parse(_priceController.text), // Assuming TotalPrice should be a double
      "unitPrice": double.parse(_unitPriceController.text) // Assuming UnitPrice should be a double
    };

    final uri = Uri.parse(
        'http://localhost:8080/api/product/updateProduct/${widget.product.id}');

    // Perform the PUT request
    final response = await put(
      uri,
      body: jsonEncode(productData),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true); // Return to the product list screen
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Failed to update product")),
      );
    }

    setState(() {
      inProgress = false;
    });
  }
}
