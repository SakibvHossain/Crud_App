import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _codeTEController = TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  late var _inProgress = false;

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
        title: const Text('Add Product'),
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
                  textEditingController: _productNameTEController,
                  labelTextField: 'Product Name',
                  hintTextField: 'Name',
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _codeTEController,
                  labelTextField: 'Product Code',
                  hintTextField: 'Code',
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _unitPriceTEController,
                  labelTextField: 'Product Price',
                  hintTextField: 'Price',
                  keyboardTypeField: TextInputType.number,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _imageTEController,
                  labelTextField: 'Product Image',
                  hintTextField: 'Image',
                  keyboardTypeField: TextInputType.url,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _quantityTEController,
                  labelTextField: 'Product Quantity',
                  hintTextField: 'Quantity',
                  keyboardTypeField: TextInputType.number,
                ),
                SizedBox(height: 10),
                _reusableTextFormField(
                  textEditingController: _totalPriceTEController,
                  labelTextField: 'Total Price',
                  hintTextField: 'Total',
                  keyboardTypeField: TextInputType.number,
                  textInputActionField: TextInputAction.done,
                ),
                SizedBox(height: 20),
                _inProgress ? const Center(child: CircularProgressIndicator(color: Colors.pink,),) : ElevatedButton(
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
      addNewProduct();
      //Using Global key for validation
      // Handle form submission
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );

      _formKey.currentState?.reset(); //Using global key for resetting the field values
      // _formKey.currentState?.save(); //Using global key for saving the data
    }
  }

  Future<void> addNewProduct() async {
    _inProgress = true;
    setState(() {});

    Map<String, dynamic> requestBody = {
      "img": _imageTEController.text,
      "productCode": _codeTEController.text,
      "productName": _productNameTEController.text,
      "qty": _quantityTEController.text,
      "totalPrice": _totalPriceTEController.text,
      "unitPrice": _unitPriceTEController.text
    };

    Uri url = Uri.parse('http://localhost:8080/api/product/add_product');
    Response response = await post(url, headers: {
     "Content-Type": "application/json"
    },
    body: jsonEncode(requestBody));

    print(response.body);
    print(response.statusCode);

    _inProgress = false;
    setState(() {

    });

  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _quantityTEController.dispose();
    _totalPriceTEController.dispose();
    _unitPriceTEController.dispose();
    _imageTEController.dispose();
    _codeTEController.dispose();

    super.dispose();
  }
}
