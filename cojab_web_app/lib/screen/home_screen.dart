import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class HomeScreen extends StatelessWidget{
  WebViewController webViewController=WebViewController()
  ..loadRequest(Uri.parse('https://courtjabja.kr/'))
  ..setJavaScriptMode(JavaScriptMode.unrestricted);
  
  HomeScreen({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff034638),
        title: Text(
          '코트잡자',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle : true,
      ),
      body: WebViewWidget(
        controller: webViewController,
      ),
    );
  }
}