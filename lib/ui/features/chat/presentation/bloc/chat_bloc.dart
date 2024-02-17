// ignore_for_file: invalid_use_of_visible_for_testing_member

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/chat_services/model/chat_message_model.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_event.dart';
import 'package:go_rider/ui/features/chat/presentation/bloc/chat_bloc_state.dart';

var log = getLogger('Chat_Bloc');

class ChatBloc extends Bloc<ChatBlocEvent, ChatBlocState> {
  ChatBloc() : super(ChatBlocState(messages: [])) {
    on<FetchMessage>((event, emit) {
      fetchMessage(
          senderid: event.senderId,
          receiverid: event.receiverId,
          user: event.user,
          receiver: event.receiver);
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
}
