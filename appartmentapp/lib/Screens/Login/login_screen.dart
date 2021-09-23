import 'package:appartmentapp/Screens/Home/home_screen.dart';
import 'package:appartmentapp/Screens/Login/Component/QRComponent/qr_scanner_code.dart';
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget{
  @override 
  _LoginScreenState createState() => _LoginScreenState();
}

var controllerLoginCode = TextEditingController();

class _LoginScreenState extends State<LoginScreen>{
  @override 
  Widget build(BuildContext context){
    Size size = MediaQuery.of(context).size;
    // controllerLoginCode.text = "${name}";
    return Container(
      constraints: BoxConstraints(
        maxHeight: size.height,
        maxWidth: size.width,
      ),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ContainerLogoApp(size),
          ContainerLoginComponent(size),
        ],
      ),
    );
  }

  Widget ContainerLogoApp(size) => Container(
    height: size.height*0.4,
    child: LogoApp(context),
  );

  Widget ContainerLoginComponent(size) => Container(
    height: size.height*0.6,
    width: size.width,
    decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
            Colors.blue.shade900,
            Colors.blue.shade500,
          ],
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
      ),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50)
      )
    ),
    child: Padding(
      padding: EdgeInsets.all(24),
      child: FunctionLogin(context),
    ),
  );

  Widget FunctionLogin(context) => Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      TitileLogin(),
      SizedBox(height: 30,),
      InputCodeLogin(context),
      SizedBox(height:120),
      ButtonLogin(context),
    ],
  );

  Widget TitileLogin() => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(
        "MÃ XÁC NHẬN",
        style: TextStyle(
          // fontFamily: 'Raleway',
          color: Colors.white,
          fontSize: 25,
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.none,
        ),
        textAlign: TextAlign.start,
      ),
    ],
  );

  Widget InputCodeLogin(context) => Material(
    borderRadius: BorderRadius.circular(30),
    child: TextField(
      controller: controllerLoginCode,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(30),
        ),
        fillColor: Colors.white, 
        filled: true, 
        hintText: "Nhập mã xác nhận",
        prefixIcon: Icon(
          Icons.code_rounded,
          color: Colors.grey.shade400,
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.qr_code),
          color: Colors.green,
          onPressed: (){
            setState(() {
              Navigator.push(
                context, 
                MaterialPageRoute(builder: (context) => QrScanner())
              );
            });
          },
        ),
      ),
      
    ),
  );

  Widget ButtonLogin(context) => Container(
    width: MediaQuery.of(context).size.width*0.5,
    height: MediaQuery.of(context).size.width*0.13,
    child: RaisedButton(
      onPressed: () {
        if(controllerLoginCode.text == "1234"){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context)=> HomeScreen())
          );
          controllerLoginCode.text = "";
        }
        else if(controllerLoginCode.text == "" || controllerLoginCode.text == null){
          showDialog(
            context: context, 
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Vui lòng nhập mã xác nhận !!!"),
              );
            }
          );
        }
        else{
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Nhập sai mã xác nhận !!!"),
              );
            }
          );
          controllerLoginCode.text = "";
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(80.0)),
      padding: const EdgeInsets.all(0.0) ,
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.greenAccent.shade400,
              Colors.greenAccent.shade200,
            ],
            begin: Alignment.topLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(80.0)),
        ),
        child: Container(
          constraints: BoxConstraints(minWidth: 88.0, minHeight: 36.0),
          alignment: Alignment.center,
          child: Text(
            'Xác nhận',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );

  Widget LogoApp(context) => Stack(
    alignment: Alignment.center,
    children:[
      Positioned(
        height: MediaQuery.of(context).size.height*0.5,
        child: Image.asset(
          "assets/images/logoapp.png",
          width: MediaQuery.of(context).size.width*0.8,
        ),
      ),
    ],
  );
}