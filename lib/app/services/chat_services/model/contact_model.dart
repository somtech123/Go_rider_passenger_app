import 'package:cloud_firestore/cloud_firestore.dart';

class Contact {
  final String? uid;
  final Timestamp? addedOn;

  Contact({this.uid, this.addedOn});

  Map<String, dynamic> toMap(Contact contact) {
    var data = <String, dynamic>{};

    data['contact_id'] = contact.uid;
    data['added_on'] = contact.addedOn;

    return data;
  }

  factory Contact.fromMap(Map<String, dynamic> json) =>
      Contact(uid: json['contact_id'], addedOn: json['added_on']);
}
