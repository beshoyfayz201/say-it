

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:sayit/consts.dart';

class ChatScreen extends StatefulWidget {
  static String id = "/chatScreen";
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String message = "";
  final Firestore firestore = Firestore.instance;
  final  auth = FirebaseAuth.instance;
  FirebaseUser fbu;
  getCurrentUser() async {
    try {
      final user = await auth.currentUser();
      if (user != null) {
        fbu = user;
        print("\n" + fbu.email);
      }
    } catch (e) {
      print(e.message);
    }
  }

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }
TextEditingController chController=new TextEditingController();
bool load =false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black38,
     // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('chat room'),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: SafeArea(
            child: Container(

              decoration: BoxDecoration(
                color: Colors.white
//                  gradient: LinearGradient(
//                    colors: [Color(0xff3E3C55), Colors.lightBlue[500]],
//                  ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: <Widget>[
              StreamBuilder<QuerySnapshot>(
                stream: firestore.collection("messages").snapshots(),
                // ignore: missing_return
                builder:getmessages ,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.lightBlue[800],
                    border: Border(
                      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    )),
                child:Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: chController,
                        decoration:
                        InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                hintText: 'Type your message here...',
                border: InputBorder.none,
              ),
                        onChanged: (val) {
                          message = val;
                        },
                        onSubmitted: (val){
                          chController.clear();
                          firestore.collection("messages").add({"sender":fbu.email,"text":val});
                        },
                      ),
                    ),FlatButton(child: Text("Send"),onPressed:
                        (){
                      firestore.collection("messages").add({"sender":fbu.email,"text":message});
                      chController.clear();
                    },)
                  ],
                ) ,
              )
          ],
        ),
            )),
      ),
    );
  }

  Widget getmessages(context, snapshot) {
    if (snapshot.hasData) {

      List<Widget> msgList = [];
      final snpDocs = snapshot.data.documents;
      for (var data in snpDocs) {
        String msg = data.data["text"];
        String sndr = data.data["sender"];

        msgList.add(Meassages(from: sndr,notme: (sndr==fbu.email),text: msg,));
      }
      return  Expanded(child: ListView(
        reverse: true,
          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 15),

          children: msgList));
    }
  }
}

//class messagebody extends StatelessWidget {
//
//   String snr;
//  String msg;
//  String f;
//
//  messagebody(this.snr,this.msg,this.f);
//
//  @override
//  Widget build(BuildContext context) {
//    double w=MediaQuery.of(context).size.width;
//    bool user=(snr==f);
//    return
//      Row(
//        children: <Widget>[
//          (user)?SizedBox(width: 1,):CircleAvatar(child: Icon(Icons.person),radius: 15,),
//          SizedBox(width: 10),
//
//          Container(
//            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
//
//              decoration: BoxDecoration(
//                  gradient: LinearGradient(
//                      colors: (!user)?[Color(0xff3E3C55), Colors.black38]:[ Colors.lightBlue[800],Color(0xff3E3C55)]
//                  ),
//                  boxShadow: [BoxShadow(color: Colors.black,blurRadius: 3,spreadRadius: 0.4)],
//
//                  borderRadius: BorderRadius.all(Radius.circular(10))
//              ),
//              margin: (user)?EdgeInsets.fromLTRB(w*0.7, 5, 5, 5):EdgeInsets.fromLTRB(5, 5, 100, 5),
//
//              child:Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
//                children: <Widget>[
//                  if(!user)
//                  Text(snr.substring(0,snr.indexOf("@")) ,style: TextStyle(fontSize: 15,color: Colors.grey[300]),),
//                  Text(msg,style:TextStyle(fontSize: 18,color: Colors.white),)],
//              ))
//
//        ],
//      )
////      ListTile(
////
////
////          leading: (user)?null:CircleAvatar(child: Icon(Icons.person),),
////          trailing: (!user)?null:CircleAvatar(child: Icon(Icons.person),),
////          title: Text(snr.substring(0,snr.indexOf("@")) ,style: TextStyle(fontSize: 15,color: Colors.grey[300]),),
////          subtitle: Text(msg,style:TextStyle(fontSize: 18,color: Colors.white),),
////
////      ),
//    ;
//  }
//}

class Meassages extends StatelessWidget {
  final String text;
  final String from;
  final bool notme;

  Meassages({Key key, this.text, this.from, this.notme}) :super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget w=(!notme)?
    CircleAvatar(maxRadius: 15,backgroundImage: AssetImage("assets/image/u.png"),):SizedBox(width: 10,);
    return Row(
      mainAxisAlignment: !notme ? MainAxisAlignment.start : MainAxisAlignment.end,

      children: <Widget>[
        w,
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
          decoration: BoxDecoration(gradient: LinearGradient(
                    colors: (!notme)?[Colors.white54, Colors.grey[500]]:[Colors.cyan[500], Colors.lightBlue[700]]
                ),
                boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 3,spreadRadius: 0.4)],

                borderRadius:notme? BorderRadius.only(
                    bottomLeft:  Radius.circular(30),
                  bottomRight:  Radius.circular(30),
                  topLeft:  Radius.circular(30),
                  topRight:  Radius.circular(5),
                ):BorderRadius.only(
                  bottomLeft:  Radius.circular(5),
                  bottomRight:  Radius.circular(30),
                  topLeft:  Radius.circular(30),
                  topRight:  Radius.circular(30),
                )),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          child: Text(
              text,
            style: TextStyle(color:notme? Colors.grey[100]:Colors.black),
          ),
        )
      ],
    );
  }


}