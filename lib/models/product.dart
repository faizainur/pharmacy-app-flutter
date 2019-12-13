class Product {
  String productName;
  int serialId;
  DateTime exp;
  int productStock;
  int price;
  int rak;

  // Constructor
  Product(
    this.serialId,
    this.productName,
    this.price,
    this.productStock,
    this.exp,
    this.rak,
  );
}
