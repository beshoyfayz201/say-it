import"package:flutter/material.dart";


// ignore: must_be_immutable
class RoundedButton extends StatelessWidget{
  String tit;
  Function onpressed;
RoundedButton({this.tit,this.onpressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 70),
      child: RaisedButton(
        onPressed: onpressed,
        color: Color(0xff3E3C55),
        disabledElevation: 10,
        shape: StadiumBorder(),
        child: Text(tit,style: TextStyle(
            color: Colors.white
        ),),

      ),
    );
  }

}