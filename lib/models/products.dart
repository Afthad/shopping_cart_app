String tableProducts = 'products';

class ProductsDto {
  ProductsDto({
    required this.data,
  });

  Data data;

  factory ProductsDto.fromJson(Map<String, dynamic> json) => ProductsDto(
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.products,
  });

  List<Product> products;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    required this.prodImage,
    required this.prodCode,
    required this.prodName,
    required this.prodMrp,
    required this.prodRkPrice,
    required this.prodId,
  });

  String prodImage;

  String prodCode;

  String prodName;
  dynamic prodMrp;
  dynamic prodRkPrice;
  dynamic prodId;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
      prodImage: json["prodImage"],
      prodCode: json["prodCode"].toString(),
      prodName: json["prodName"],
      prodMrp: json["prodMrp"],
      prodRkPrice: json["prodRkPrice"],
      prodId: json['prodId']);

  Map<String, dynamic> toJson() => {
        "prodImage": prodImage,
        "prodCode": prodCode,
        "prodName": prodName,
        "prodMrp": prodMrp,
        "prodRkPrice": prodRkPrice,
      };
}
