import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:week1_videoplayer_grafik/model/api.dart';
import 'package:week1_videoplayer_grafik/widget/label_app.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_button.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_input_field.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_password_field.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email, password, nama;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      save();
    }
  }

  save() async {
    final response = await http.post(BaseUrl.register, body: {
      "nama": nama,
      "email": email,
      "password": password,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    if (value == 1) {
      _showDialog("Berhasil", "Pendaftaran Sukses");
      setState(() {
        Navigator.pop(context);
      });
    } else {
      _showDialog("Gagal", pesan);
      print(pesan);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color(0xFFFF729F),
      ),
      body: SingleChildScrollView(
        child: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          key: _key,
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Padding(
                      padding: EdgeInsets.all(16),
                      child: namaApp(24, Colors.black, Color(0xFFFF729F))),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset('assets/Udacoding.png'),
                    ),
                  ),
                  RoundedInputField(
                    icon: Icons.email,
                    onSaved: (e) => email = e,
                    hintText: "Email",
                    onChanged: (value) {},
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Tolong masukkan email anda";
                      }
                    },
                  ),
                  RoundedPasswordField(
                    obsecureText: _secureText,
                    showPass: showHide,
                    colorIcon: _secureText ? Color(0xFF81F4E1) : Colors.grey,
                    onSaved: (e) => password = e,
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Tolong masukkan pasword anda";
                      }
                    },
                  ),
                  RoundedInputField(
                    icon: Icons.person,
                    onSaved: (e) => nama = e,
                    hintText: "Nama",
                    onChanged: (value) {},
                    validator: (e) {
                      if (e.isEmpty) {
                        return "Tolong masukkan nama anda";
                      }
                    },
                  ),
                  RoundedButton(
                    text: "SIGN UP",
                    press: () {
                      check();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showDialog(String title, String content) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(content),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
