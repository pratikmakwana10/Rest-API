import 'package:dio_api_real/screen/forgot_password_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/login_model.dart';
import '../models/registration_model.dart';
import '../services/network.dart';
import '../utils/url_utils.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

addStringToSF(String token) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
  } on Exception catch (e) {
    print(e.toString());
  }
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        // leading: BackButton(),
      ),
      body: Column(
        children: [
          customTextFormField("email", _email),
          customTextFormField("password", _password),
          ElevatedButton(
              onPressed: () {
                login().then((value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  backgroundColor: Colors.blueGrey,
                  content: Text(
                    "User Logged In",
                    style: TextStyle(
                        fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                  duration: Duration(seconds: 1),
                )
                ));

               /* Future.delayed(Duration(seconds: 3)).then((value) =>
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.blueGrey,
                      content: Text(
                        "User Logged In",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      duration: Duration(seconds: 1),
                    )));*/
              },
              child: Text("Login")),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ForgotPassword()));
            },
            child: Text("Forgot Password"),
          ),
        ],
      ),
    );
  }

  Padding customTextFormField(String hintText, TextEditingController controller,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          keyboardType: inputType,
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            if (controller == _email &&
                !RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
              return "Please enter valid email";
            }
            return null;
          },
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ));
  }

  Future<void> login() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> body = {
        "email": _email.text,
        "password": _password.text,
      };

      dynamic response = await net.postWithDio(url: UrlUtils.login, body: body);

      if (response != null) {
        LoginRecordModel loginDetails =
            LoginRecordModel(result: Result(user: User()));

        loginDetails = LoginRecordModel.fromJson(response);

        net.setApiKeyAndToken(token: loginDetails.result.token);
        addStringToSF(loginDetails.result.token);

        if (kDebugMode) {
          print(loginDetails.toJson());
        }
      } else {}

      setState(() {
        _isLoading = false;
      });
    } on Exception catch (e) {
      print(e.toString());
      setState(() {
        _isLoading = false;
      });
    }
  }
}
