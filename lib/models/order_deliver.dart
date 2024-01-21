class OrderDeliver {
  String orderId;
  String uid;
  String timeStamp;
  bool isCompleted;

  OrderDeliver({
    required this.orderId,
    required this.uid,
    required this.timeStamp,
    required this.isCompleted,
  });

  // Method to convert the Order object to a Map
  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'uid': uid,
      'timeStamp': timeStamp,
      'isCompleted': isCompleted,
    };
  }

  // Factory method to create an Order object from a Map
  factory OrderDeliver.fromMap(Map<String, dynamic> map) {
    return OrderDeliver(
      orderId: map['orderId'],
      uid: map['uid'],
      timeStamp: map['timeStamp'],
      isCompleted: map['isCompleted'],
    );
  }
}
