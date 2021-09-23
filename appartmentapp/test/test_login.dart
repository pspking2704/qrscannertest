import 'package:appartmentapp/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  testWidgets("test", (WidgetTester tester) async{
    await tester.pumpWidget(MyApp());

    //điền mã xác nhận
    var textField = find.byType(TextField);
    await tester.enterText(textField, "123");

    //nhấn nút xác nhận
    var button = find.text("Xác nhận");
    await tester.tap(button);
    
    //chuyển qua trang Home
    await tester.pump();


  });
}