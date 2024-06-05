import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:garena/Cards/no_money.dart';
import 'package:garena/Cards/single_card.dart';
import 'package:garena/main_page/add_money.dart';
import 'package:garena/main_page/wallet.dart';
import 'package:garena/models/providers.dart';
import 'package:garena/models/user_model.dart';
import 'package:garena/other/result.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import 'package:appinio_animated_toggle_tab/appinio_animated_toggle_tab.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart' ;
import 'package:garena/models/game_models.dart' ;
import 'package:image_picker/image_picker.dart' ;
import 'package:provider/provider.dart' ;
import 'package:social_login_buttons/social_login_buttons.dart' ;
import 'package:simple_progress_indicators/simple_progress_indicators.dart' ;
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../models/upload.dart' ;


class Add extends StatefulWidget {
  String id;
  String uid;
  bool isleague ;
  bool changing ;
  GameModel user ;
  Add({super.key, required this.id, required this.uid, required this.changing, required this.isleague, required this.user});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  final TextEditingController sessionNameController = TextEditingController();

  String s = " ";

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController startd = TextEditingController();
  final TextEditingController start = TextEditingController();
  final TextEditingController endd = TextEditingController();
  final TextEditingController endt = TextEditingController();
  final TextEditingController typeController = TextEditingController();

  final TextEditingController versionController = TextEditingController();

  final TextEditingController mappController = TextEditingController();

  final TextEditingController matchTypeController = TextEditingController();

  final TextEditingController feeController = TextEditingController();

  final TextEditingController scheduleController = TextEditingController();

  final TextEditingController endsController = TextEditingController();

  final TextEditingController aboutController = TextEditingController();

  final TextEditingController importantController = TextEditingController();

  final TextEditingController behaviorController = TextEditingController();

  final TextEditingController techController = TextEditingController();

  final TextEditingController complaintController = TextEditingController();

  final TextEditingController inGameController = TextEditingController();

  final TextEditingController penaltyController = TextEditingController();

  final TextEditingController participantsController = TextEditingController();

  final TextEditingController prizeController = TextEditingController();

  final TextEditingController killController = TextEditingController();

  final TextEditingController notesController = TextEditingController();

  final TextEditingController pictureController = TextEditingController();

  final TextEditingController winnerController = TextEditingController();

  final TextEditingController runnerController = TextEditingController();
  final TextEditingController mode = TextEditingController();
  final TextEditingController first = TextEditingController();
  final TextEditingController second = TextEditingController();
  final TextEditingController num = TextEditingController();
  final TextEditingController server = TextEditingController();
  final TextEditingController level = TextEditingController();
  final TextEditingController ytlink = TextEditingController();
  final TextEditingController link = TextEditingController();
  String photoUrl = " ";

  String st = " ";
  final RegExp doubleRegExp = RegExp(r'^\d+(\.\d+)?$');
  String ssg = "your value";
  String en = " ";

  void initState(){
    mappController.text = widget.uid ;
    if(widget.changing){
      nameController.text = widget.user.Name ;
    aboutController.text = widget.user.About ;
    importantController.text = widget.user.Important ;
    killController.text = widget.user.Kill ;
    mappController.text = widget.user.Mapp ;
    notesController.text= widget.user.Notes ;
    matchTypeController.text = widget.user.Type ;
    versionController.text = widget.user.Version ;
    endd.text = widget.user.date_e ;
    startd.text = widget.user.date_f ;
    first.text = widget.user.first ;
    level.text = widget.user.Level ;
    mode.text = widget.user.mode ;
    second.text = widget.user.second ;
    server.text = widget.user.Server ;
    level.text = widget.user.Level ;
    endt.text = widget.user.time_e ;
    start.text  = widget.user.time_s ;
      feeController.text = widget.user.Fee.toString() ;
      num.text = widget.user.limit.toString() ;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserModel? _user = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add Event to ${widget.uid}",
            style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Center(
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey.shade200,
                  child: IconButton(
                      onPressed: () async {
                        try {
                          Uint8List? _file =
                          await pickImage(ImageSource.gallery);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Uploading Please wait"),
                            ),
                          );
                          photoUrl = await StorageMethods()
                              .uploadImageToStorage('users', _file!, true);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Pic Uploaded"),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${e}'),
                            ),
                          );
                        }
                      },
                      icon: Icon(
                        Icons.camera,
                        size: 55,
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              a(nameController, "Name"),
              a(versionController, "VIEW"),
              a(mode, "Mode : 'PC/Tablet/Phone'"),
              a(server, "Server"),
              a(level, "Team" ),
              ac(mappController, "Map"),
              SizedBox(height : 13),
              Center(
                child: Icon(Icons.description, color: Colors.red, size: 55),
              ),
              Center(
                  child: Text("Basic Details",
                      style: TextStyle(color: Colors.red))),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: TextFormField(
                  controller: feeController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(doubleRegExp),
                  ],
                  decoration: InputDecoration(
                    labelText: "Please type Price in Rupees",
                    isDense: true,
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please type your value';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Handle onChanged event if needed
                  },
                ),
              ),
              a(killController, "Per Kill Prize"),
              a(matchTypeController, "Match Type"),
              TextButton.icon(
                  onPressed: () async {
                    List<DateTime>? dateTimeList =
                    await showOmniDateTimeRangePicker(
                      context: context,
                      startInitialDate: DateTime.now(),
                      startFirstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                      startLastDate: DateTime.now().add(
                        const Duration(days: 3652),
                      ),
                      endInitialDate: DateTime.now(),
                      endFirstDate:
                      DateTime(1600).subtract(const Duration(days: 3652)),
                      endLastDate: DateTime.now().add(
                        const Duration(days: 3652),
                      ),
                      is24HourMode: false,
                      isShowSeconds: false,
                      minutesInterval: 1,
                      secondsInterval: 1,
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                      constraints: const BoxConstraints(
                        maxWidth: 350,
                        maxHeight: 650,
                      ),
                      transitionBuilder: (context, anim1, anim2, child) {
                        return FadeTransition(
                          opacity: anim1.drive(
                            Tween(
                              begin: 0,
                              end: 1,
                            ),
                          ),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 200),
                      barrierDismissible: true,
                      selectableDayPredicate: (dateTime) {
                        // Disable 25th Feb 2023
                        if (dateTime == DateTime(2023, 2, 25)) {
                          return false;
                        } else {
                          return true;
                        }
                      },
                    );
                    setState(() {
                      DateTime sth = dateTimeList![0];
                      DateTime sgh = dateTimeList[1];
                      startd.text = "${sth.day}/${sth.month}/${sth.year}";
                      start.text  = "${sth.hour}:${sth.minute}";
                      endd.text = "${sgh.day}/${sgh.month}/${sgh.year}";
                      endt.text  = "${sgh.hour}:${sgh.minute}";
                    });
                  },
                  label: Text("Choose Date and Time"),
                  icon: Icon(Icons.calendar_month)),
              ac(startd, "Start Date"),
              ac(start, "Start Time"),
              ac(endd, "End Date"),
              ac(endt, "End Time"),
              aa(aboutController, "About the Game in Brief", 4),
              SizedBox(height : 13),
              Center(
                child: Icon(Icons.receipt, color: Colors.blue, size: 55),
              ),
              Center(
                  child:
                  Text("T & C", style: TextStyle(color: Colors.blue))),
              aa(importantController, "Type Terms & Conditions", 6),
              a(notesController, "Any Notes for Contestants"),
              SizedBox(height : 13),
              Center(
                child: Icon(Icons.inventory_2, color: Colors.green, size: 55),
              ),
              Center(
                  child: Text("Game Essentials",
                      style: TextStyle(color: Colors.green))),
              a(first, "First Prize ? "),
              a(second, "Second Prize ?"),
              a(link, "Game Joining Link (  Active before 20 minutes of Start of Event )"),
              a(ytlink, "Link for Youtube after matched is played ( Active After Eventis overed ) ")
              ,
              an(num, "MAXIMUM No. of Participants"),


            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: SocialLoginButton(
            backgroundColor: Color(0xff50008e),
            height: 40,
            text: widget.changing ? "Update Now " : 'Add Event Now',
            borderRadius: 20,
            fontSize: 21,
            buttonType: SocialLoginButtonType.generalLogin,
            onPressed: () async {
              int numa = int.parse( feeController.text);
              int max = int.parse( num.text);
              String s = DateTime.now().microsecondsSinceEpoch.toString();
              GameModel sjjjj = GameModel(Name: nameController.text, About: aboutController.text, Fee: numa,
                  Important: importantController.text, Kill: killController.text, Mapp: mappController.text,
                  Notes: notesController.text, Participants: [],
                  Picture: photoUrl, Type: matchTypeController.text, Version: versionController.text,
                  limit: max, date_e: endd.text, date_f: startd.text,
                  first: first.text, hostedby: _user!.Name, hosteid: _user.uid, hostname: s,
                  ytlink : ytlink.text , link : link.text , status : "O",
                  Level: level.text, mode: mode.text, second: second.text, Server: server.text,
                  Team: level.text, time_e: endt.text, time_s: start.text);
              if ( widget.changing ){
                if ( widget.isleague){
                  try {
                    CollectionReference collection = FirebaseFirestore
                        .instance
                        .collection("League");
                    await collection
                        .doc(widget.user.hostname)
                        .update(sjjjj.toJson());
                    Navigator.pop(context);
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                }else{
                  try {
                    CollectionReference collection = FirebaseFirestore
                        .instance
                        .collection(widget.id)
                        .doc('GAME')
                        .collection(widget.uid);
                    await collection
                        .doc(widget.user.hostname)
                        .update(sjjjj.toJson());
                    Navigator.pop(context);
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                }
              }else{
                if ( widget.isleague){
                  try {
                    CollectionReference collection = FirebaseFirestore
                        .instance
                        .collection("League");
                    await collection
                        .doc(s)
                        .set(sjjjj.toJson());
                    Navigator.pop(context);
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                }else{
                  try {
                    CollectionReference collection = FirebaseFirestore
                        .instance
                        .collection(widget.id)
                        .doc('GAME')
                        .collection(widget.uid);
                    await collection
                        .doc(s)
                        .set(sjjjj.toJson());
                    Navigator.pop(context);
                  } catch (e) {
                    print('${e}');
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${e}'),
                      ),
                    );
                  }
                }
              }

              ;
            },
          ),
        ),
      ],
    );
  }

  Widget a(TextEditingController c, String ssg) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: c,
        decoration: InputDecoration(
          labelText: "Please Type $ssg",
          isDense: true,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type your Password';
          }
          return null;
        },
        onChanged: (value) {},
      ),
    );
  }
  Widget an(TextEditingController c, String ssg) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: c, keyboardType: TextInputType.number,
        decoration: InputDecoration(
          labelText: "Please Type $ssg",
          isDense: true,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type your Password';
          }
          return null;
        },
        onChanged: (value) {},
      ),
    );
  }
  Widget ac(TextEditingController c, String ssg) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: c, readOnly: true,
        decoration: InputDecoration(
          labelText: "$ssg",
          isDense: true,
          border: OutlineInputBorder(

          ),fillColor: Colors.blue.shade200
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type your Password';
          }
          return null;
        },
        onChanged: (value) {},
      ),
    );
  }
  Widget aa(TextEditingController c, String ssg, int max) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: TextFormField(
        controller: c, maxLines: max,
        decoration: InputDecoration(
          labelText: "Type $ssg in brief",
          isDense: true,
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type your Password';
          }
          return null;
        },
        onChanged: (value) {},
      ),
    );
  }
}
