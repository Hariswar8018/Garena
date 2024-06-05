import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';

class GameModel {
  GameModel({
    required this.Name,
    required this.About,
    required this.Fee,
    required this.Important,
    required this.Kill,
    required this.Mapp,
    required this.Notes,
    required this.Participants,
    required this.Picture,
    required this.Type ,
    required this.Version,
    required this.limit,
    required this.date_e,
    required this.date_f,
  required this.first,
  required this.hostedby,
  required this.hosteid,
  required this.hostname,
  required this.Level,
  required this.mode,
  required this.second,
  required this.Server,
  required this.Team,
  required this.time_e,
  required this.time_s,
    required this.link,
  required this.ytlink,
  required this.status,
  });

  late final String Name;
  late final String Type;
  late final String Version;
  late final String Mapp;
  late final String Team;
  late final String Level;
  late final String Server;
  late final String first;
  late final String second;
  late final String date_f;
  late final String date_e;
  late final String time_s;
  late final String time_e;
  late final String status ;
  late final String link ;
  late final String ytlink ;
  late final String mode;
  late final String hostedby ;
  late final String hosteid;
  late final String hostname;

   late final int Fee;
  late final String About;
  late final String Important;
  late final List Participants;
  late final String Kill;
  late final String Notes;
  late final String Picture;
  late final int limit;

  GameModel.fromJson(Map<String, dynamic> json) {
    link = json['link'] ?? "https://yjj.be";
    ytlink = json['link'] ?? "https://yt.be";
    status = json['status'] ?? "P";
    Name = json['Name'] ?? 'Garena View';
    Type = json['Type'] ?? "PT";
    Version = json['Version'] ?? "2.0";
    Mapp = json['Map'] ?? "Erangel";
    Fee = (json['Fee'] ?? 10.0).toInt(); // Convert double to int
    About = json['About'] ?? "No about for view";
    Important = json['Important'] ?? "hh";
    Participants = json['Participants'] ?? [];
    Kill = json['Kill'] ?? "30";
    Notes = json['Notes'] ?? "";
    Picture = json['Picture'] ?? "h";
    limit = (json['limit'] ?? 100).toInt(); // Convert double to int
    date_f = json['date_f'] ?? "13/2/2024";
    date_e = json['date_e'] ?? "14/2/2024";
    first = json['first'] ?? "200";
    hostedby = json['hostedby'] ?? "Ayusman";
    hosteid = json['hosteid'] ?? "DW932788";
    hostname = json['hostname'] ?? "Ayusman";
    Level = json['Level'] ?? "Begineer";
    mode = json['mode'] ?? "Laptop";
    second = json['second'] ?? "300";
    Server = json['Server'] ?? "ASIA";
    Team = json['Team'] ?? "Single";
    time_s = json['time_s'] ?? "13:20";
    time_e = json['time_e'] ?? "14:20";
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['Name'] = Name;
    data['Type'] = Type;
    data['Version'] = Version;
    data['Map'] = Mapp;
    data['Fee'] = Fee;
    data['About'] = About;
    data['Important'] = Important;
    data['Participants'] = Participants;
    data['Kill'] = Kill;
    data['Notes'] = Notes;
    data['Picture'] = Picture;
    data['limit'] = limit;
    data['date_f'] = date_f;
    data['date_e'] = date_e;
    data['first'] = first;
    data['hostedby'] = hostedby;
    data['hosteid'] = hosteid;
    data['hostname'] = hostname;
    data['Level'] = Level;
    data['mode'] = mode;
    data['second'] = second;
    data['Server'] = Server;
    data['Team'] = Team;
    data['time_s'] = time_s;
    data['time_e'] = time_e;
    data['link'] = link;
    data['ytlink'] = ytlink ;
    data['status'] = status ;
    return data;
  }

}
