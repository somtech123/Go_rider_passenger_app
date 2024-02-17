import 'package:go_rider/app/services/chat_services/chat_method.dart';
import 'package:go_rider/app/services/chat_services/model/chat_message_model.dart';
import 'package:go_rider/app/services/chat_services/model/chat_model.dart';

class ChatRepository {
  final ChatsMethod _chatsMethod = ChatsMethod();

  Future<void> sendMessage(ChatMessageModel2 message, ChatUserModel sender,
          ChatUserModel receiver) =>
      _chatsMethod.addMessageToDb2(message, sender, receiver);
}
