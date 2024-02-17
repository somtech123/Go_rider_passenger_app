import 'package:go_rider/utils/app_constant/app_string.dart';

class ChatUserModel {
  final String? userId;

  final String? userName;

  final String? profileUrl;

  ChatUserModel({
    this.userName,
    this.userId,
    this.profileUrl,
  });

  factory ChatUserModel.fromMap(Map<String, dynamic> json) => ChatUserModel(
        userId: json['id'],
        userName: json['userName'],
        profileUrl: json['profileImage'] ?? AppStrings.dummyProfilePicture,
      );

  Map<String, dynamic> toJson() =>
      {"user_id": userId, 'userName': userName, 'profileImage': profileUrl};
}
