class LocationModel {
  double? lattitude;
  double? longitude;

  LocationModel({this.lattitude, this.longitude});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lattitude: json['latitude'],
        longitude: json['longitude'],
      );

  LocationModel copyWith({
    double? lattitude,
    double? longitude,
  }) =>
      LocationModel(
          lattitude: lattitude ?? this.lattitude,
          longitude: longitude ?? this.longitude);
}
