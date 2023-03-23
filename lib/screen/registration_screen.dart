import 'dart:convert';

import 'package:dio_api_real/models/registration_model.dart';
import 'package:dio_api_real/screen/login_screen.dart';
import 'package:dio_api_real/services/network.dart';
import 'package:dio_api_real/utils/url_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController =
      TextEditingController();
  TextEditingController emailController =
      TextEditingController();
  TextEditingController phoneNumberController =
      TextEditingController();
  TextEditingController passwordController =
      TextEditingController();
  TextEditingController countryController =
      TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController companyController =
      TextEditingController();

  static bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("API"),
        ),
        body: _isLoading
            ? Center(
              child: const CupertinoActivityIndicator(
                  radius: 15.0,
                ),
            )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    customTextFormField("firstname", nameController),
                    customTextFormField("lastName", lastNameController),
                    customTextFormField("Email", emailController),
                    customTextFormField("PhoneNumber", phoneNumberController,
                        inputType: TextInputType.number),
                    customTextFormField("Password", passwordController),
                    customTextFormField("Country", countryController),
                    customTextFormField("State", stateController),
                    customTextFormField("Company", companyController),
                    buildElevatedButton(),
                    ElevatedButton(onPressed: (){

                      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                    }, child: Text("Login Screen>"))
                  ],
                ),
              ));
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          signUpu();
        },
        child: const Text("Enter"));
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
            if (controller == emailController &&
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

  Future<void> signUpu() async {
    try {
      setState(() {
        _isLoading = true;
      });


      Map<String,dynamic> body = {
        "firstName": nameController.text,
        "lastName": lastNameController.text,
        "email": emailController.text,
        "phoneNumber": phoneNumberController.text,
        "password": passwordController.text,
        "country": countryController.text,
        "state": stateController.text,
        "company": companyController.text,
      };

      dynamic response =
          await net.postWithDio(url: UrlUtils.register, body: body);

      if (response != null) {
        RegistrationRecModel regDetails = RegistrationRecModel(result: LoginRec());

        regDetails = RegistrationRecModel.fromJson(response);

        if (kDebugMode) {
          print(regDetails.toJson());
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
