class Cart {
  int productId;
  int count;
  dynamic price;
  Cart({
    required this.productId,
    required this.count,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'prodId': productId,
      'count': count,
      'price': price,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      price: map['price'],
      productId: map['prodId'] ?? '',
      count: map['count'] ?? '',
    );
  }
}
