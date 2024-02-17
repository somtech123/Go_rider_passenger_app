// ignore_for_file: must_be_immutable

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';

abstract class ChatBlocEvent extends Equatable {}

class FetchMessage extends ChatBlocEvent {
  ChatUser user;
  ChatUser receiver;

  String receiverId;
  String senderId;

  FetchMessage(
      {required this.receiver,
      required this.receiverId,
      required this.senderId,
      required this.user});

  @override
  List<Object?> get props => [receiver, user, receiverId, senderId];
}

class SendMessage extends ChatBlocEvent {
  ChatMessage message;
  UserModel sender;
  RiderModel receiver;

  SendMessage(
      {required this.message, required this.receiver, required this.sender});

  @override
  List<Object?> get props => [message, receiver, sender];
}
