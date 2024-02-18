import 'package:go_rider/utils/app_constant/app_string.dart';

class UserModel {
  String? email;
  String? username;
  String? profileImage;
  DateTime? dateCreated;
  final String? userId;
  String? fcmToken;
  UserModel({
    this.email,
    this.profileImage,
    this.username,
    this.dateCreated,
    this.userId,
    this.fcmToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        username: json['userName'],
        userId: json['id'],
        fcmToken: json['fcmToken'],
        dateCreated: DateTime.parse(json['dateCreated']),
        profileImage: json["profileImage"].isEmpty
            ? AppStrings.dummyProfilePicture
            : json['profileImage'],
      );

  UserModel copyWith({
    String? email,
    String? username,
    String? profileImage,
    DateTime? dateCreated,
  }) =>
      UserModel(
        username: username ?? this.username,
        email: email ?? this.email,
        profileImage: profileImage ?? this.profileImage,
        dateCreated: dateCreated ?? this.dateCreated,
      );
}
