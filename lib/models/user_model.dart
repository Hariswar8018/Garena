import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.Chess_Level,
    required this.Email,
    required this.Name,
    required this.Pic_link,
    required this.Bio,
    required this.Draw,
    required this.Gender,
    required this.Language,
    required this.Location,
    required this.Lose,
    required this.Talk,
    required this.Won,
    required this.uid,
    required this.Lat,
    required this.Lon,
    required this.lastlogin,
    required this.code,
    required this.age,
    required this.lastloginn,
  });

  late final String Chess_Level;
  late final String Email;
  late final String Name;
  late final String Pic_link;
  late final String Bio;
  late final int Draw;
  late final String Gender;
  late final String Language;
  late final String Location;
  late final int Lose;
  late final String Talk;
  late final double Won;
  late final String uid;
  late final double Lat;
  late final double Lon;
  late final String lastlogin;
  late final String code;
  late final String age;
  late final String lastloginn;

  UserModel.fromJson(Map<String, dynamic> json) {
    Chess_Level = json['Chess_Level'] ?? 'Begineer';
    Email = json['Email'] ?? 'demo@demo.com';
    Name = json['Name'] ?? 'samai';
    Pic_link = json['Pic_link'] ??
        'https://i.pinimg.com/736x/98/fc/63/98fc635fae7bb3e63219dd270f88e39d.jpg';
    Bio = json['Bio'] ?? 'Demo';
    Draw = json['Draw'] ?? 0 ;
    Gender = json['Gender'] ?? "Male";
    Language = json['Language'] ?? "English";
    Location = json['Location'] ?? "Spain";
    Lose = json['Lose'] ?? 0 ;
    Talk = json['Talk'] ?? "Little Talkative";
    Won = json['Won'] ?? 0 ;
    uid = json['uid'] ?? "Hello" ;
    Lat = json['Lat'] ?? 22.2661556 ;
    Lon = json['Lon'] ?? 84.9088836 ;
    lastlogin = json['lastlogin'] ?? "73838";
    code = json["Code"] ?? "0124" ;
    age = json["Age"] ?? "20";
    lastloginn = json['lastloginn'] ?? "7986345";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Chess_Level'] = Chess_Level;
    data['Email'] = Email;
    data['Name'] = Name;
    data['Pic_link'] = Pic_link;
    data['Bio'] =  Bio;
    data['Age'] =  age;
    data['Gender'] =  Gender;
    data['uid'] =  uid;
    data['Draw'] = Draw ;
    data['Lose'] = Lose ;
    data['Won'] = Won ;
    data['Language'] = Language;
    data['Location'] = Location;
    data['Code'] = code;
    data['Talk'] = Talk ;
    data['Lat'] =  Lat;
    data['Lon'] = Lon ;
    data['lastlogin'] = lastlogin ;
    data['lastloginn'] = lastloginn ;
    return data;
  }

  static UserModel fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return UserModel(
      Email: snapshot['Email'] ?? 'Demo',
      Name: snapshot['Name'] ?? 'Je',
      Pic_link: snapshot['Pic_link'] ??
          'https://cdn-icons-png.flaticon.com/512/552/552721.png',
      Bio: snapshot['Bio'] ?? 'Je',
      age : snapshot['Age'] ?? "20",
      Gender: snapshot['Gender'] ?? "Female",
      uid: snapshot['uid'] ?? "hi",
      Chess_Level: snapshot['ff'] ?? "hi",
      Draw: snapshot['Draw'] ?? 0,
      Language: snapshot['Language'] ?? "not set",
      Location: snapshot['Location'] ?? "not set",
      Lose:  snapshot['Lose'] ?? 0,
      code : snapshot['Code'] ?? "7666",
      Talk: snapshot['Talk'] ?? "Introvert",
      Won: snapshot['Won'] ?? 0,
      Lat: snapshot['Lat'] ?? 22.2661556,
      Lon: snapshot['Lon'] ?? 84.9088836,
      lastlogin: snapshot['lastlogin'] ?? "14 October, 15:22",
      lastloginn: snapshot['lastloginn'] ?? 3666732,
    );
  }
}
