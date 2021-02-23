import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:week1_videoplayer_grafik/model/api.dart';
import 'package:week1_videoplayer_grafik/views/home.dart';
import 'package:week1_videoplayer_grafik/widget/label_app.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_button.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_input_field.dart';
import 'package:week1_videoplayer_grafik/widget/rounded_password_field.dart';
import 'register.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginState extends State<Login> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;
  String email, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    //Validasi Form
    final form = _key.currentState;
    if (form.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    final response = await http
        .post(BaseUrl.login, body: {"email": email, "password": password});
    final data = jsonDecode(response.body);
    int value = data['value'];
    String pesan = data['message'];
    String emailAPI = data['email'];
    String namaAPI = data['nama'];
    if (value == 1) {
      setState(() {
        _loginStatus = LoginStatus.signIn;
        savePref(value, emailAPI, namaAPI);
      });
      print(pesan);
      print(emailAPI);
    } else {
      print(pesan);
    }
  }

  savePref(int value, String email, String nama) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", value);
      preferences.setString("email", email);
    });
  }

  var value;
  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");
      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setInt("value", null);
      _loginStatus = LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    switch (_loginStatus) {
      case LoginStatus.notSignIn:
        return Scaffold(
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
                        colorIcon:
                            _secureText ? Color(0xFF81F4E1) : Colors.grey,
                        onSaved: (e) => password = e,
                        validator: (e) {
                          if (e.isEmpty) {
                            return "Tolong masukkan pasword anda";
                          }
                        },
                      ),
                      RoundedButton(
                        text: "LOGIN",
                        press: () {
                          check();
                        },
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Register()));
                        },
                        child: Text(
                          "Create a new account, in here",
                          textAlign: TextAlign.center,
                          style:
                              TextStyle(decoration: TextDecoration.underline),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        break;
      case LoginStatus.signIn:
        return Home();
        break;
    }
  }
}
