import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScanner extends StatefulWidget{
  @override 
  _QrScannerState createState() => _QrScannerState();
}

class _QrScannerState extends State<QrScanner>{
  final qrKey = GlobalKey(debugLabel: "QR");

  QRViewController? controller;
  Barcode? barcode;

  @override 
  void dispose(){
    controller?.dispose();
    super.dispose();
  }

  @override 
  void reassemble() async{
    super.reassemble();

    if(Platform.isAndroid){
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }


  @override 
  Widget build(BuildContext context) => SafeArea(
    child: Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          buildQrView(context),
          Positioned(bottom:10, child: buildResult(),),
          Positioned(top:10, child: buildButtonController(),)
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
    barcode != null ? 'Result ${barcode!.code}' : 'Scan a code',
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

  Widget buildButtonController() => Container(
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
          icon: FutureBuilder<bool?>(
            future: controller?.getFlashStatus(),
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
            await controller?.toggleFlash();
            setState(() {});
          },
        ),
        IconButton(
          onPressed: () async{
            await controller?.flipCamera();
            setState(() {}); 
          },
          icon: FutureBuilder(
            future: controller?.getCameraInfo(),
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
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
  }
}