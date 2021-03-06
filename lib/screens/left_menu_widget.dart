import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:x_system/model/left_menu.dart';

class LeftMenuWidget extends StatefulWidget {
  const LeftMenuWidget({Key? key}) : super(key: key);

  @override
  _LeftMenuState createState() => _LeftMenuState();
}

class _LeftMenuState extends State<LeftMenuWidget> {
  late LeftMenu leftMenu =
      new LeftMenu(groupName: '', items: [], upItems: null);
  @override
  void initState() {
    print('>>>>>>>>>>> initState ${leftMenu.groupName}');
    super.initState();
    _getLeftMenu().then((value) => {
          setState(() {
            leftMenu = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.all(10),
        children: [],
      ),
    );
  }

  LeftMenu parse(String reponse) {
    var data = json.decode(reponse);
    return LeftMenu.fromJson(data);
  }

  Future<LeftMenu> _getLeftMenu() async {
    final response = await http.post(
        Uri.parse('https://www.fair999.com/member-market/sat/left-menu.json'),
        body: jsonEncode(<String,dynamic>{
          "type": "SPORTS",
          "selectedId": 0,
          "sportId": 0,
          "tzone": "GMT+05:30"
        }));
    print('////////////////////////////////////');
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print('200');

      print('ok : ${response.body.toString()}');
      // return compute(parse, response.body);
      // var a = jsonDecode(response.body);
      return LeftMenu.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      print('200');

      throw Exception('Failed to load album');
    }
  }
}
