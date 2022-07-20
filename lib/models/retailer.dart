class Retailer {
  String retailerName;
  String ownerName;
  String address;
  String city;
  String mobileNumber;
  String shopImage;
  String state;
  Retailer({
    required this.retailerName,
    required this.ownerName,
    required this.address,
    required this.city,
    required this.mobileNumber,
    required this.shopImage,
    required this.state,
  });

  Map<String, dynamic> toMap() {
    return {
      'retailerName': retailerName,
      'ownerName': ownerName,
      'mobileNumber': mobileNumber,
      'address': address,
      'city': city,
      'shopImage': shopImage,
      'state': state,
    };
  }

  factory Retailer.fromMap(Map<String, dynamic> map) {
    return Retailer(
      retailerName: map['retailerName'] ?? '',
      ownerName: map['ownerName'] ?? '',
      address: map['address'] ?? '',
      city: map['city'] ?? '',
      mobileNumber: map['mobileNumber'] ?? '',
      shopImage: map['shopImage'] ?? '',
      state: map['state'] ?? '',
    );
  }
}

class RetailerList {
  List<Retailer> retailers;
  RetailerList({required this.retailers});
  factory RetailerList.fromMap(Map<dynamic, dynamic> map) {
    return RetailerList(
        retailers: List<Retailer>.from(
            map['retailers'].map((x) => Retailer.fromMap(x))));
  }
}
