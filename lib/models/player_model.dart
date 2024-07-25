import 'package:cloud_firestore/cloud_firestore.dart';

class PlayerModel {
  PlayerModel({
    required this.username,
    required this.uid,
    required this.id,
  });

  late final String username;
  late final String uid;
  late final String id;

  PlayerModel.fromJson(Map<String, dynamic> json) {
    username = json['username'] ?? '';
    uid = json['uid'] ?? '';
    id = json['id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['username'] = username;
    data['uid'] = uid;
    data['id'] = id;
    return data;
  }

  static PlayerModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return PlayerModel.fromJson(snapshot);
  }
}
