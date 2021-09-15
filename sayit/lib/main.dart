import 'package:flutter/material.dart';
import 'package:sayit/screens/chatscreen.dart';
import 'package:sayit/screens/loginscreen.dart';
import 'package:sayit/screens/signup.dart';
import 'package:sayit/screens/welcome.dart';

void main()=>runApp(Sayit());

class Sayit extends StatelessWidget{
  build(BuildContext context)=>MaterialApp(
    theme: ThemeData.dark().copyWith(accentColor: Colors.white),
    routes:{
      Welcome.id:(context)=>Welcome(),
      LoginScreen.id:(context)=>LoginScreen(),
      Signup.id:(context)=>Signup(),
      ChatScreen.id:(context)=>ChatScreen()


    } ,
    initialRoute:Welcome.id,
  );
}