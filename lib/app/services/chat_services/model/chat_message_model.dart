import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessageModel2 {
  final String? senderId;
  final String? receiverId;
  final String? type;
  final String? message;
  String? photoUrl;
  final String? isRead;
  final Timestamp? timestamp;

  ChatMessageModel2(
      {this.isRead,
      this.timestamp,
      this.senderId,
      this.receiverId,
      this.type,
      this.message,
      this.photoUrl});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['type'] = type;
    map['message'] = message;
    map['photoUrl'] = photoUrl;
    map['isRead'] = isRead;
    map['timestamp'] = timestamp;

    return map;
  }

  factory ChatMessageModel2.fromMap(Map<String, dynamic> json) =>
      ChatMessageModel2(
          senderId: json['senderId'],
          receiverId: json['receiverId'],
          isRead: json['isRead'],
          type: json['type'],
          message: json['message'],
          photoUrl: json['photoUrl'],
          timestamp: json['timestamp']);

  Map<String, dynamic> toImageMap() {
    var map = <String, dynamic>{};
    map['message'] = message;
    map['senderId'] = senderId;
    map['receiverId'] = receiverId;
    map['type'] = type;
    map['timestamp'] = timestamp;
    map['isRead'] = isRead;
    map['photoUrl'] = photoUrl;
    return map;
  }
}
