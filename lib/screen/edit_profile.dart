import 'dart:io';

import 'package:dio_api_real/screen/user_by_id.dart';
import 'package:dio_api_real/utils/url_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio_api_real/services/network.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../models/get_all_user_model.dart';
import '../models/get_single_profile.dart';
import '../models/registration_model.dart';

class EditProfile extends StatefulWidget {
  AllUserResult singleProfile;

  EditProfile(
    this.singleProfile, {
    Key? key,
  }) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool _isLoading = false;
  File pImage = File("");

  Future<void> editProfile() async {
    try {
      setState(() {
        _isLoading = true;
      });

      Map<String, dynamic> body = {
        "firstName": nameCon.text,
        "lastName": lastNameCon.text,
        "phoneNumber": phoneNUmberCon.text,
        "country": countryCon.text,
        "state": stateCon.text,
        "company": companyCon.text,
      };

      dynamic response = await net.putWithDio(
          url: "${UrlUtils.userBYId}/${widget.singleProfile.id}", body: body);
      // url: "${UrlUtils.userBYId}/${widget.id}"

      if (response != null) {
        RegistrationRecModel regDetails =
            RegistrationRecModel(result: LoginRec());

        regDetails = RegistrationRecModel.fromJson(response);

        if (regDetails.success) {
          Navigator.pop(context, true);
        }

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

  TextEditingController nameCon = TextEditingController();
  TextEditingController lastNameCon = TextEditingController();
  TextEditingController countryCon = TextEditingController();
  TextEditingController stateCon = TextEditingController();
  TextEditingController companyCon = TextEditingController();
  TextEditingController emailCon = TextEditingController();
  TextEditingController phoneNUmberCon = TextEditingController();

  @override
  void initState() {
    super.initState();
    autoFill();
  }

  void autoFill() {
    nameCon.text = widget.singleProfile.firstName;
    lastNameCon.text = widget.singleProfile.lastName;
    countryCon.text = widget.singleProfile.country;
    stateCon.text = widget.singleProfile.state;
    companyCon.text = widget.singleProfile.company;
    emailCon.text = widget.singleProfile.email;
    phoneNUmberCon.text = widget.singleProfile.phoneNumber.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: checkImage(),
              onTap: () async {
                final ImagePicker _picker = ImagePicker();
                // Pick an image
                final XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                pImage = File(image!.path);
                if(pImage.path.isNotEmpty){
                  uploadImage();
                }
                setState(() {});
              },
            ),
            customTextFormField("Name", nameCon, true),
            customTextFormField("Last Name", lastNameCon, true),
            customTextFormField("Email", emailCon, false),
            customTextFormField("PhoneNumber", phoneNUmberCon, true),
            customTextFormField("Country", countryCon, true),
            customTextFormField("State", stateCon, true),
            customTextFormField("Company", companyCon, true),
            ElevatedButton(
                onPressed: () {
                  editProfile();
                },
                child: const Text("Edit"))
          ],
        ),
      ),
    );
  }

  Padding customTextFormField(
      String hintText, TextEditingController controller, bool enb,
      {TextInputType inputType = TextInputType.text}) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextFormField(
          enabled: enb,
          keyboardType: inputType,
          controller: controller,
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

  Widget checkImage() {
    if (pImage.path.isNotEmpty) {
      return CircleAvatar(
        radius: 40,
        child: Image.file(pImage, fit: BoxFit.fill),
      );
    } else if (widget.singleProfile.profileImg.url.isNotEmpty) {
      return CircleAvatar(
        radius: 40,
        child: Image.network(widget.singleProfile.profileImg.url,
            fit: BoxFit.fill),
      );
    } else {
      return CircleAvatar(
        radius: 40,
      );
    }
  }
  Future<void> uploadImage() async {
    String fileName = pImage.path.split('/').last;
   dio.  FormData formData = dio.FormData.fromMap({
      "profile":
      await dio.MultipartFile.fromFile(pImage.path, filename:fileName),
    });
      net.postWithDioWithFormData(url: "${UrlUtils.editProfile}/${widget.singleProfile.id}", formData: formData);
  }
}
