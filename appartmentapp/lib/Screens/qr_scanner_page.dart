import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget{
  @override 
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>{
  final qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? controller;
  @override 
  void dispose(){
    controller?.dispose();
    super.dispose();
  }
  @override 
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
        ],
      ),
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
  void onQRViewCreated(QRViewController controller){
    setState(() => this.controller = controller);
  }
}