import 'package:flutter/material.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home:Scaffold(
        body:Container(
          decoration:BoxDecoration(
            color:Colors.white,
          ),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Image.asset(
                      'assets/세종소식.jpg',
                      width :330,
                    ),
                    const SizedBox(height:30),
                    CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(
                        Colors.black,
                      )
                    ),
                  ]
              ),
            ]
          )
        ),
      ),
    );
  }
}