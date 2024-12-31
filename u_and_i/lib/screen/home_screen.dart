import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({Key? key}) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.pink[100],
      body: SafeArea(
        top: true,
        bottom: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _DDay(),
            _CoupleImage(),
          ],
        )
      )
    );
  }
}

class _DDay extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text('dday widget');
  }
}

class _CoupleImage extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Text('Couple image Widget');
  }
}