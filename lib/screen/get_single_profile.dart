import 'package:flutter/material.dart';

import '../models/get_all_user_model.dart';
import '../models/get_single_profile.dart';
import '../services/network.dart';
import '../utils/url_utils.dart';
import 'edit_profile.dart';

class SingleProfile extends StatefulWidget {
  const SingleProfile({Key? key}) : super(key: key);

  @override
  State<SingleProfile> createState() => _SingleProfileState();
}

class _SingleProfileState extends State<SingleProfile> {
  AllUserResult singleProfile = AllUserResult(profileImg: ProfileImg());

  @override
  void initState() {
    getAllUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Profile"),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(singleProfile)));
            }, icon: Icon(Icons.edit))
          ],
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.chevron_right),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SingleProfile()),
              );
            }),
        body: singleProfile.id.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Container(
          height: double.infinity,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                buildText(singleProfile.firstName),
                buildText(singleProfile.lastName),
                buildText(singleProfile.email),
                buildText(singleProfile.phoneNumber.toString()),
                buildText(singleProfile.country),
                buildText(singleProfile.state),
                buildText(singleProfile.company),
              ],
            ),
          ),
        ));
  }

  Text buildText(String txt) => Text(txt,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),);

  Future<void> getAllUsers() async {
    // Map<String, dynamic> body =

    var response = await net.getWithDio(url: UrlUtils.getProfile);
    print(response);
    if (response != null) {
      GetSingleUser details = GetSingleUser.fromJson(response);

      singleProfile = details.result;
      setState(() {});
    } else {}
  }
}
