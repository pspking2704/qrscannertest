import 'package:appartmentapp/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  @override 
  Widget build(BuildContext context){
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Hello " + controllerLoginCode.text,
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 30,
              color: Colors.grey,
            )
          )
        ],
      ),
    );
  }
}