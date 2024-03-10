class RatingModel {
  double? rating;

  RatingModel({this.rating});

  factory RatingModel.fromJson(Map<String, dynamic> json) =>
      RatingModel(rating: json['rating']);
}
