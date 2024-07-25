import 'package:flutter/material.dart';
import 'package:garena/other/myuser.dart';
import 'package:garena/page/add_notify.dart';
import 'package:page_transition/page_transition.dart';

import '../Cards/transactions.dart';

class Admin extends StatelessWidget {
  const Admin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Admin View",style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: Transaction(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
              ));
            },
            leading: Icon(Icons.credit_card),
            title: Text("Transaction Admin"),
            subtitle: Text("Check transact on App"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                  context, PageTransition(
                  child: Myuser(), type: PageTransitionType.rightToLeft, duration: Duration(milliseconds: 500)
              ));
            },
            leading: Icon(Icons.credit_card),
            title: Text("User Admin"),
            subtitle: Text("Allow User to Add or Manage widget"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
          ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Not(viewonly:false, id: '', str: '', b: true,)),
              );
            },
            leading: Icon(Icons.notification_add),
            title: Text("Notices"),
            subtitle: Text("Add Notifications for App"),
            trailing: Icon(Icons.arrow_forward_ios_sharp),
          ),
        ],
      ),
    );
  }
}
