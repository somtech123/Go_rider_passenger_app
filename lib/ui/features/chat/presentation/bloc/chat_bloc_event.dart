// ignore_for_file: must_be_immutable

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:equatable/equatable.dart';

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
