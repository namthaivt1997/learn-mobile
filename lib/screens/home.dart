import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'left-menu.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: LeftMenuWidget(),
      appBar: AppBar(
        title: Text('HomeScreen'),
      ),

      body: SafeArea(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/login");
                },
                child: Text("Login")),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed("/event/1/market/2");
                },
                child: Text("Market"))
          ],
        ),
      ),
    );
  }
}
