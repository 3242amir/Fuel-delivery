class OrderRequest {
  String uid;
  String fuelType;
  double totalPrice;
  String timeStamp;
  String deliveryCharges;
  String taxes;
  double latitude;
  double longitude;
  bool isDeliver;
  String? quantity;

  OrderRequest({
    required this.uid,
    required this.fuelType,
    required this.totalPrice,
    required this.timeStamp,
    required this.deliveryCharges,
    required this.taxes,
    required this.latitude,
    required this.longitude,
    required this.isDeliver,
    this.quantity,
  });

  // Convert the model to a Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fuelType': fuelType,
      'totalPrice': totalPrice,
      'timeStamp': timeStamp,
      'deliveryCharges': deliveryCharges,
      'taxes': taxes,
      'latitude': latitude,
      'longitude': longitude,
      'isDeliver': isDeliver,
      'quantity': quantity,
    };
  }

  // Create an instance of the model from a Map
  factory OrderRequest.fromMap(Map<String, dynamic> map) {
    return OrderRequest(
      uid: map['uid'],
      fuelType: map['fuelType'],
      totalPrice: map['totalPrice'],
      timeStamp: map['timeStamp'],
      deliveryCharges: map['deliveryCharges'],
      taxes: map['taxes'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      isDeliver: map['isDeliver'],
      quantity: map['quantity'],
    );
  }
}
