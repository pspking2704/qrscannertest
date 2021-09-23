import 'dart:io';
import 'package:appartmentapp/Screens/Login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget{
  @override 
  _QrScannerState createState() => _QrScannerState();
}

QRViewController? controllerQR;
Barcode? barcodeQR;

class _QrScannerState extends State<QrScanner>{
  final qrKey = GlobalKey(debugLabel: "QR");


  @override 
  void dispose(){
    controllerQR?.dispose();
    super.dispose();
  }

  @override 
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await controllerQR!.pauseCamera();
    }
    controllerQR!.resumeCamera();
  }


  @override 
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(bottom:10, child: buildResult(),),
          Positioned(top:10, child: buildButtonController(context),)
        ],
      ),
    ),
  );

  Widget buildResult() => Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Text(
    barcodeQR == null ?  'Scan a code' : "Code is accept !!!",
    maxLines: 3,
    ),
  );

  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey, 
    onQRViewCreated: onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderColor: Theme.of(context).accentColor,
      borderWidth:10,
      borderLength: 20,
      borderRadius: 10,
      cutOutSize: MediaQuery.of(context).size.width*0.8,
    ),
  );

  Widget buildButtonController(context) => Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(8)
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: (){
            Navigator.pop(context);
            controllerLoginCode.text = barcodeQR!.code;
          },
          icon: Icon(Icons.arrow_back,)
        ),
        IconButton(
          icon: FutureBuilder<bool?>(
            future: controllerQR?.getFlashStatus(),
            builder: (context, snapshot){
              if(snapshot.data != null){
                return Icon(
                  snapshot.data! ? Icons.flash_on : Icons.flash_off
                );
              }
              else{
                return Container();
              }
            },
          ),
          onPressed: () async{
            await controllerQR?.toggleFlash();
            setState(() {});
          },
        ),
        IconButton(
          onPressed: () async{
            await controllerQR?.flipCamera();
            setState(() {}); 
          },
          icon: FutureBuilder(
            future: controllerQR?.getCameraInfo(),
            builder: (context,snapshot){
              if(snapshot.data != null){
                return Icon(Icons.switch_camera);
              }
              else{
                return Container();
              }
            }
          ),
        ),
      ],
    ),
  );

  void onQRViewCreated(QRViewController controller){
    setState(() => controllerQR = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => barcodeQR = barcode));
  }
}
