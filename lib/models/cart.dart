class Cart {
  int productId;
  int count;
  Cart({
    required this.productId,
    required this.count,
  });

  Map<String, dynamic> toMap() {
    return {
      'prodId': productId,
      'count': count,
    };
  }

  factory Cart.fromMap(Map<String, dynamic> map) {
    return Cart(
      productId: map['prodId'] ?? '',
      count: map['count'] ?? '',
    );
  }
}
