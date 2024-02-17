class HistoryModel {
  String? amount;
  String? destination;
  String? pickUpLocation;
  String? riderId;

  String? rideStatus;
  DateTime? dateCreated;
  RiderDetailModel? riderDetail;

  HistoryModel(
      {this.amount,
      this.dateCreated,
      this.destination,
      this.pickUpLocation,
      this.rideStatus,
      this.riderId,
      this.riderDetail});

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
      amount: json['amount'],
      dateCreated: DateTime.parse(json['dateCreated']),
      destination: json['destination'],
      pickUpLocation: json['pickupLocation'],
      rideStatus: json['rideStatus'],
      riderId: json['rideId'],
      riderDetail: RiderDetailModel.fromJson(json['rider_details']));
}

class RiderDetailModel {
  String? riderModel;
  String? riderName;
  String? riderPlate;

  RiderDetailModel({this.riderModel, this.riderName, this.riderPlate});

  factory RiderDetailModel.fromJson(Map<String, dynamic> json) =>
      RiderDetailModel(
          riderName: json['riderName'],
          riderModel: json['riderModel'],
          riderPlate: json['riderPlate']);
}
