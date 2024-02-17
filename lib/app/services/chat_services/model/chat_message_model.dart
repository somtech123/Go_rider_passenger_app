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

  // ChatMessageModel2.imageMessage(
  //     {this.isRead,
  //     this.photoUrl,
  //     this.timestamp,
  //     this.senderId,
  //     this.receiverId,
  //     this.type,
  //     this.message});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};

    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['message'] = this.message;
    map['photoUrl'] = this.photoUrl;
    map['isRead'] = this.isRead;
    map['timestamp'] = this.timestamp;

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
    map['senderId'] = this.senderId;
    map['receiverId'] = this.receiverId;
    map['type'] = this.type;
    map['timestamp'] = this.timestamp;
    map['isRead'] = this.isRead;
    map['photoUrl'] = this.photoUrl;
    return map;
  }
}
