import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:x_system/controllers/user_session_controller.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _username = new TextEditingController();
  final TextEditingController _password = new TextEditingController();
  final UserSessionController session = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Username:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 10,
              ),
              TextField(obscureText: false, controller: _username, decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true)),
              SizedBox(
                height: 10,
              ),
              Text('Password:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              SizedBox(
                height: 10,
              ),
              TextField(obscureText: true, controller: _password, decoration: InputDecoration(border: InputBorder.none, fillColor: Color(0xfff3f3f4), filled: true)),
              SizedBox(
                height: 10,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var post = await http.post(Uri.parse('https://www.funsport101.com/member-service/login/login'),
                        body: {'loginId': _username.text, 'password': _password.text}, headers: session.getSessionHeaders());
                    var loginResponse = _LoginResponse.fromJson(jsonDecode(post.body));
                    if (loginResponse.data == 1) {
                      session.updateSession(post);

                      var resp = await http.get(Uri.parse('https://www.funsport101.com/member-service/user/balance'), headers: session.getSessionHeaders());
                      showDialog(
                          context: context,
                          builder: (c) {
                            return AlertDialog(
                              content: Text(resp.body),
                            );
                          });
                    } else {
                      session.clearSession();
                      showDialog(
                          context: context,
                          builder: (c) {
                            return AlertDialog(
                              content: Text(post.body + jsonEncode(post.headers)),
                            );
                          });
                    }
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(50, 15, 50, 15)),
                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(25), side: BorderSide(color: Colors.blue))),
                  ),
                  child: Text('Login', style: TextStyle(fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginResponse {
  final int data;
  final bool upper18Age;
  final bool ic;
  final bool state;
  final String brand;

  _LoginResponse({required this.data, required this.upper18Age, required this.ic, required this.state, required this.brand});

  factory _LoginResponse.fromJson(Map<String, dynamic> json) {
    return _LoginResponse(
      data: json['data'],
      upper18Age: json['upper18Age'],
      ic: json['ic'],
      state: json['state'],
      brand: json['brand'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['data'] = this.data;
    data['upper18Age'] = this.upper18Age;
    data['ic'] = this.ic;
    data['state'] = this.state;
    data['brand'] = this.brand;
    return data;
  }
}
