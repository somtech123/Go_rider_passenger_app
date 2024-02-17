// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/chat_services/chat_repository.dart';
import 'package:go_rider/app/services/chat_services/model/chat_message_model.dart';
import 'package:go_rider/app/services/chat_services/model/chat_model.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_event.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_state.dart';
import 'package:go_rider/ui/features/dashboard/data/rider_model.dart';
import 'package:go_rider/ui/features/dashboard/data/user_model.dart';

var log = getLogger('Chat_Bloc');

class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  final ChatRepository _repository = ChatRepository();

  ChatBloc() : super(ChatBlocState(messages: [])) {
    on<FetchMessage>((event, emit) {
      fetchMessage(
          senderid: event.senderId,
          receiverid: event.receiverId,
          user: event.user,
          receiver: event.receiver);
    });

    on<SendMessage>((event, emit) async {
      await sendMessage(
          m: event.message, sender: event.sender, receiver: event.receiver);
    });
  }

  fetchMessage({
    required String senderid,
    required String receiverid,
    ChatUser? user,
    ChatUser? receiver,
  }) async {
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore
        .instance
        .collection('messages')
        .doc(senderid)
        .collection(receiverid)
        .orderBy('timestamp', descending: false)
        .get();

    for (var i = 0; i < querySnapshot.docs.length; i++) {
      if (querySnapshot.docs[i].id != senderid) {
        var res = ChatMessageModel2.fromMap(querySnapshot.docs[i].data());
        log.w(" sender id is ${res.senderId}");

        var incomingMessage = ChatMessage(
            user: res.senderId == senderid ? user! : receiver!,
            createdAt: res.timestamp!.toDate(),
            text: res.message!);
        log.w("$senderid message is ${incomingMessage.toJson().toString()}");

        List<ChatMessage>? messages = state.messages;

        messages!.insert(0, incomingMessage);

        emit(state.copyWith(messages: messages));
      }
    }
  }

  sendMessage(
      {required ChatMessage m,
      required UserModel sender,
      required RiderModel receiver}) async {
    ChatMessageModel2 _message = ChatMessageModel2(
        senderId: sender.userId,
        receiverId: receiver.id,
        type: 'text',
        message: m.text,
        timestamp: Timestamp.now(),
        photoUrl: sender.profileImage);
    List<ChatMessage>? messages = state.messages;

    messages!.insert(0, m);

    emit(state.copyWith(messages: messages));

    SystemChannels.textInput.invokeMethod('TextInput.hide');

    var _sender = ChatUserModel(
        userName: sender.username,
        userId: sender.userId,
        profileUrl: sender.profileImage);

    var _receiver = ChatUserModel(
        userName: receiver.username,
        userId: receiver.id,
        profileUrl: receiver.profileImage);

    await _repository.sendMessage(_message, _sender, _receiver);
  }
}
