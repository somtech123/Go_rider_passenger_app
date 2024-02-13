class RiderModel {
  String? email;
  String? id;
  String? username;
  String? profileImage;
  DateTime? dateCreated;
  String? phoneNumber;
  String? rideColor;
  String? rideModel;
  String? ridePlate;
  String? noOfSeat;

  RiderModel(
      {this.email,
      this.profileImage,
      this.username,
      this.id,
      this.dateCreated,
      this.phoneNumber,
      this.rideColor,
      this.rideModel,
      this.noOfSeat,
      this.ridePlate});

  factory RiderModel.fromJson(Map<String, dynamic> json) => RiderModel(
      email: json['email'],
      id: json['id'],
      username: json['userName'],
      dateCreated: DateTime.parse(json['dateCreated']),
      phoneNumber: json['phoneNumber'],
      rideColor: json['rideColor'],
      rideModel: json['rideModel'],
      noOfSeat: json['noOfSeat'],
      ridePlate: json['ridePlate']);

  RiderModel copyWith({
    String? email,
    String? username,
    String? profileImage,
    DateTime? dateCreated,
    String? phoneNumber,
    String? rideColor,
    String? rideModel,
    String? ridePlate,
    String? noOfSeat,
  }) =>
      RiderModel(
          username: username ?? this.username,
          email: email ?? this.email,
          profileImage: profileImage ?? this.profileImage,
          dateCreated: dateCreated ?? this.dateCreated,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          rideColor: rideColor ?? this.rideColor,
          rideModel: rideModel ?? this.rideModel,
          ridePlate: ridePlate ?? this.ridePlate,
          noOfSeat: noOfSeat ?? this.noOfSeat);
}
