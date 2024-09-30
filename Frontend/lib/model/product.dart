class Product {
  final int id;
  final String? productName;
  final String? productCode;
  final String? productImage;
  final String? unitPrice;
  final String? quantity;
  final String? totalPrice;

  Product(
      {required this.id,
      required this.productName,
      required this.productCode,
      required this.productImage,
      required this.unitPrice,
      required this.quantity,
      required this.totalPrice});
}
