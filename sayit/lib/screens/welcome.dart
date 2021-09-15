import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:sayit/screens/signup.dart';
import 'package:sayit/widgets/robutton.dart';
import 'loginscreen.dart';


class Welcome extends StatefulWidget {
  static String id = "WelcomeScreen";
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,


        appBar: AppBar(backgroundColor: Colors.lightBlue[600]),
        body: ListView(children: [
          Container(
              color: Colors.white,
              child: Stack(
                children: <Widget>[
                  //stack overlaps widgets
                  Opacity(
                    //semi red clippath with more height and with 0.5 opacity
                    opacity: 1,
                    child: ClipPath(
                      clipper: WaveClipper(), //set our custom wave clipper
                      child: Container(
                        color: Color(0xff3E3C55),
                        height: 180,
                      ),
                    ),
                  ),

                  ClipPath(
                    //upper clippath with less height
                    clipper: WaveClipper(), //set our custom wave clipper.
                    child: Container(
                        padding: EdgeInsets.only(bottom: 50),
                        color: Colors.lightBlue[600],
                        height: 165,
                        alignment: Alignment.center,
                        child: Hero(
                          tag: "aaa",
                          child: Text(
                            "SAY I T",
                            style: TextStyle(
                                fontFamily: 'cc',
                                fontSize: 40,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,

                                decorationThickness: 3,

                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.dotted,

                                shadows: [
                                  Shadow(color: Colors.white, blurRadius: 6),
                                ]),
                          ),
                        )),
                  ),
                ],
              )),
          Image.asset("assets/image/u.png",width: 200,fit: BoxFit.contain,height: 300,),

              RoundedButton(tit: "login",onpressed:(){Navigator.of(context).pushNamed(LoginScreen.id);},),
              RoundedButton(tit: "Sign in",onpressed:(){Navigator.of(context).pushNamed(Signup.id);},)

        ])

    );
  }
}



//Costom CLipper class with Path
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(
        0, size.height); //start path with this if you are making at bottom

    var firstStart = Offset(size.width / 5, size.height);
    //fist point of quadratic bezier curve
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    //second point of quadratic bezier curve
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    //third point of quadratic bezier curve
    var secondEnd = Offset(size.width, size.height - 10);
    //fourth point of quadratic bezier curve
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);

    path.lineTo(
        size.width, 0); //end with this path if you are making wave at bottom
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false; //if new instance have different instance than old instance
    //then you must return true;
  }
}
