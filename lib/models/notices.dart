import 'package:cloud_firestore/cloud_firestore.dart';

class Notice {
  Notice({
    required this.id,
    required this.date,
    required this.name,
    required this.description,
    required this.link,
    required this.pic,
    required this.namet,
    required this.coTeach,
    required this.follo,
  });

  late final List follo;

  late final String id;
  late final String date;
  late final String name;
  late final String description;
  late final String link;
  late final String pic;
  late final String namet;
  late final bool coTeach;

  Notice.fromJson(Map<String, dynamic> json) {
    follo = json['follo'] ??[];
    id = json['id'] ?? '';
    date = json['date'] ?? '';
    name = json['name'] ?? '';
    description = json['description'] ?? '';
    link = json['link'] ?? '';
    pic = json['pic'] ?? '';
    namet = json['namet'] ?? '';
    coTeach = json['coTeach'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['follo']=follo;
    data['id'] = id;
    data['date'] = date;
    data['name'] = name;
    data['description'] = description;
    data['link'] = link;
    data['pic'] = pic;
    data['namet'] = namet;
    data['coTeach'] = coTeach;
    return data;
  }

  static Notice fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return Notice.fromJson(snapshot);
  }
}
