import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();

    Timer.periodic(Duration(seconds: 3), (timer) {
      int? nextPage = pageController.page?.toInt();
      if (nextPage == null) {
        return;
      }
      if(nextPage==8){
        print(nextPage);
        nextPage=0;
      }else{
        print(nextPage);
        nextPage++;
      }
      pageController.animateToPage(
        nextPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    return Scaffold(
      body: PageView(
        controller: pageController,
        children: [1, 2, 3, 4, 5, 6, 7, 8, 9]
            .map((number) => Image.asset(
                  'asset/img/$number.png',
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
