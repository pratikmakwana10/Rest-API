

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/forgot_password_model.dart';
import '../services/network.dart';
import '../utils/url_utils.dart';
import 'get_all_user_screen.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _isLoading = false;
  final TextEditingController _email = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        // leading: BackButton(),
      ),
      body: Column(
        children: [
          customTextFormField("email",_email),

          ElevatedButton(onPressed: (){
            forgotPassword();

          }, child: const Text("Forgot password")),
          ElevatedButton(onPressed: (){

            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => GetUser()),
                    (Route<dynamic> route) => false);
          }, child: const Text("Reset Password Screen >"))
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
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade700, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400, width: 1.5),
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
            ),
          ),
        ));
  }
  Future<void> forgotPassword() async {
    try {
      setState(() {
        _isLoading = true;
      });


      Map<String,dynamic> body = {
        "email": _email.text,
      };

      dynamic response =
      await net.postWithDio(url: UrlUtils.forgot, body: body);

      if (response != null) {
        ForgotPasswordModel fpDetails = ForgotPasswordModel();

        fpDetails = ForgotPasswordModel.fromJson(response);

        if (kDebugMode) {
          print(fpDetails.toJson());
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
