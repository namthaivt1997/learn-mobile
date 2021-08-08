import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarketScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var marketId = Get.parameters["marketId"];
    var eventId = Get.parameters["eventId"];
    return Scaffold(
      body: Container(
        child: Text("Market: " + marketId! + ". Event: " + eventId!),
      ),
    );
  }

}
