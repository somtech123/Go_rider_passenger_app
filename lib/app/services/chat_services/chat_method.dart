import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_rider/app/resouces/app_logger.dart';
import 'package:go_rider/app/services/chat_services/model/chat_message_model.dart';
import 'package:go_rider/app/services/chat_services/model/chat_model.dart';
import 'package:go_rider/app/services/chat_services/model/contact_model.dart';
import 'package:go_rider/app/services/firebase_services/firebase_repository.dart';
import 'package:go_rider/app/services/notification/notification_repo_implementation.dart';
import 'package:go_rider/app/services/notification/usecase.dart';

var log = getLogger('Chat_method');

class ChatsMethod {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  final NotificationServices _services =
      NotificationServices(NotificationRepoImplementation());

  static final CollectionReference<Map<String, dynamic>> _userCollection =
      _firestore.collection('users');

  static final CollectionReference<Map<String, dynamic>> _riderCollection =
      _firestore.collection('rider');

  final CollectionReference _messageCollection =
      _firestore.collection('messages');

  DocumentReference getContactsDocument({String? of, String? forContact}) =>
      _userCollection.doc(of).collection('contacts').doc(forContact);

  DocumentReference getReceiverDocument({String? of, String? forContact}) =>
      _riderCollection.doc(of).collection('contacts').doc(forContact);

  //add the contact to the sender document

  Future<void> _addToSenderContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot snap =
        await getContactsDocument(of: senderId, forContact: receiverId).get();

    if (snap.exists) {
      Contact receiverContact = Contact(uid: receiverId, addedOn: currentTime);

      var receiverMap = receiverContact.toMap(receiverContact);

      await getContactsDocument(of: senderId, forContact: receiverId)
          .set(receiverMap, SetOptions(merge: true));
    }
  }

//add the contact to the receiver document
  Future<void> _addToReceiverContacts(
      String senderId, String receiverId, currentTime) async {
    DocumentSnapshot snaps =
        await getReceiverDocument(of: receiverId, forContact: senderId).get();

    if (!snaps.exists) {
      //does not exists
      Contact senderContact = Contact(uid: senderId, addedOn: currentTime);

      var senderMap = senderContact.toMap(senderContact);

      await getReceiverDocument(of: receiverId, forContact: senderId)
          .set(senderMap, SetOptions(merge: true));
    }
  }

  //add to contact for both sender and receiver

  _addToContacts({String? senderId, String? receiverId}) async {
    Timestamp currentTime = Timestamp.now();

    await _addToSenderContacts(senderId!, receiverId!, currentTime);
    await _addToReceiverContacts(senderId, receiverId, currentTime);
  }

//send chat message and add it to db
  Future<void> addMessageToDb2(ChatMessageModel2 message, ChatUserModel sender,
      ChatUserModel receiver, String fcm) async {
    log.w("receiver is ${receiver.toJson()}");

    var map = message.toMap();

    await _firebaseRepository.getFirebaseUser(
        collection: 'rider', uid: receiver.userId!);

    await _messageCollection
        .doc(sender.userId)
        .collection(receiver.userId!)
        .add(map);

    await _messageCollection
        .doc(receiver.userId!)
        .collection(sender.userId!)
        .add(map);

    await _addToContacts(
        senderId: sender.userId!, receiverId: receiver.userId!);

    await _notifyUser(
        sender: sender.userName!, message: message.message!, to: fcm);
  }

  _notifyUser(
      {required String sender,
      required String message,
      required String to}) async {
    Map<String, dynamic> payload() => {
          "to": to,
          "notification": {"title": sender, "body": message}
        };

    await _services.sendPushNotification(payload());
  }
}
