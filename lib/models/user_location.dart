class UserLocation {
  String deliveryId, uid;
  double latitude;
  double longitude;

  UserLocation({
    required this.uid,
    required this.deliveryId,
    required this.latitude,
    required this.longitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'latitude': latitude,
      'longitude': longitude,
      'deliveryId': deliveryId,
    };
  }

  factory UserLocation.fromMap(Map<String, dynamic> map) {
    return UserLocation(
      uid: map['uid'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      deliveryId: map['deliveryId'],
    );
  }
}
