import 'package:dio_api_real/screen/get_all_user_screen.dart';
import 'package:dio_api_real/screen/login_screen.dart';
import 'package:dio_api_real/services/network.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CheckDetail(),
    );
  }
}

class CheckDetail extends StatefulWidget {
  const CheckDetail({Key? key}) : super(key: key);

  @override
  State<CheckDetail> createState() => _CheckDetailState();
}

class _CheckDetailState extends State<CheckDetail> {
  @override
  void initState() {
    getStringValuesSF();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: const CircularProgressIndicator()));
  }


  void getStringValuesSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString('token') ?? "";
    if (stringValue.isNotEmpty) {
      net.setApiKeyAndToken(token: stringValue);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => GetUser()),
          (Route<dynamic> route) => false);
    } else {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Login()),
          (Route<dynamic> route) => false);
    }
  }
}
