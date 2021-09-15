import 'dart:ui';
import'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:flutter/material.dart';
import 'package:sayit/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'chatscreen.dart';

class LoginScreen extends StatefulWidget {
  static String id = "/login";
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {

  final GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  TextEditingController t1 = new TextEditingController();
  TextEditingController t2 = new TextEditingController();
  bool load=false;
  String email="a",password="12";
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
  double h= MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: ModalProgressHUD(
        inAsyncCall: load,
        child: Stack(
          children: <Widget>[
            //screen back Ground
            Positioned(

              child: Container(
                height: double.infinity,
                width: double.infinity,
                child: Container(padding: EdgeInsets.fromLTRB(100, 25, 50, 10),
                  child: Text(
                    "SAY I T",
                    style: TextStyle(
                        fontFamily: 'cc',
                        fontSize: 60,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decorationThickness: 3,
                        decoration: TextDecoration.underline,
                        decorationStyle: TextDecorationStyle.dotted,
                        shadows: [
                          Shadow(color: Colors.white, blurRadius: 6),
                        ]),
                  ),
                ),

                decoration: BoxDecoration(

                    gradient: LinearGradient(
                        colors: [Color(0xff3E3C55).withOpacity(1), Colors.lightBlue[500]],
                    )),
              ),
            ),
            ///////////////////////

            Positioned(
              child: Container(
                padding: EdgeInsets.only(top: 90),
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(70)),
                ),
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.only(bottom:5.0,top:30),
                      child: TextFormField(
                        onChanged: (val){
                          email=val;
                        },
                        decoration: tFInpbord.copyWith(labelText:"Email",icon: Icon(Icons.person)),
                        controller: t1,
                       cursorColor: Colors.white,
                      keyboardType: TextInputType.emailAddress,),
                    ),
                    TextFormField(
                      onChanged: (val){
                        password=val;
                      },
                      controller: t2,
                      keyboardType: TextInputType.multiline,
                      cursorColor: Colors.white,
                      decoration: tFInpbord.copyWith(labelText: "Password"),
                      obscureText: true,
                    ),


                    Padding(
                      padding: EdgeInsets.only(top: 30, bottom: 10),
                      child: Text(
                        "Forget password ?",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),


                    RaisedButton(
                      padding: EdgeInsets.only(right: 25, left: 25),
                      shape: StadiumBorder(),
                      color: Color(0xff3E3C55),
                      child: Text(
                        "       Login       ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () async {
                        try{
                         setState(() {
                           load=true;
                         });
                        final newuserau=await  auth.signInWithEmailAndPassword(email: email, password: password);
                          Navigator.pushNamed(context, ChatScreen.id);
                         setState(() {
                           load=false;
                         });
                        }
                       catch(e){
                          print(e.message);
                       }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 35),
                      child: Text(
                        "-or coninue with -",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 40.0),
                            child: RaisedButton(
                              padding: EdgeInsets.only(right: 30, left: 30),
                              shape: StadiumBorder(),
                              color: Colors.red[400],
                              child: Text(
                                "Google",
                                style:
                                TextStyle(color: Colors.white, fontSize: 20),
                              ),
                              onPressed: () {},
                            ),
                          ),
                          RaisedButton(
                            padding: EdgeInsets.only(right: 25, left: 25),
                            shape: StadiumBorder(),
                            color: Colors.blue[700],
                            child: Text(
                              "FaceBook",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () {},
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}