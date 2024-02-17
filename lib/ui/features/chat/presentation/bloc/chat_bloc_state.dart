// ignore_for_file: override_on_non_overriding_member

import 'package:dash_chat_2/dash_chat_2.dart';

class ChatBlocState {
  List<ChatMessage>? messages;

  ChatBlocState({this.messages});

  ChatBlocState copyWith({
    List<ChatMessage>? messages,
  }) =>
      ChatBlocState(messages: messages ?? this.messages);

  @override
  List<Object?> get props => [messages];
}
