import 'package:flutter/material.dart';
import '../models/get_all_user_model.dart';
import '../models/get_single_profile.dart';
import '../services/network.dart';
import '../utils/url_utils.dart';
import 'edit_profile.dart';

class UserById extends StatefulWidget {
  final String id;

  const UserById({Key? key, required this.id}) : super(key: key);

  @override
  State<UserById> createState() => _UserByIdState();
}

class _UserByIdState extends State<UserById> {
  AllUserResult singleProfile = AllUserResult(profileImg: ProfileImg());
  bool canPop = false;

  @override
  void initState() {
    userById();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async{

        Navigator.pop(context,canPop);

          return false;}
     ,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("User By ID"),
          actions: [
            IconButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>EditProfile(singleProfile))).then((value) {
                if(value != null){
                  canPop = true;
                userById();
                }
              });
            }, icon: Icon(Icons.edit))
          ],
          ),

          body: singleProfile.id.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 100,),
                    buildText("Name",singleProfile.firstName),
                    buildText("Last Name",singleProfile.lastName),
                    buildText("Email",singleProfile.email),
                    buildText("Number",singleProfile.phoneNumber.toString()),
                    buildText("Country",singleProfile.country),
                    buildText("State",singleProfile.state),
                    buildText("Company",singleProfile.company),
                  ],
                ),
              )),
    );
  }

  Widget buildText(String info,String txt) => Padding(
    padding:  const EdgeInsets.symmetric(vertical: 5.0),
    child: Text(
      "$info : $txt",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
  );

  Future<void> userById() async {
    // Map<String, dynamic> body =

    var response =
        await net.getWithDio(url: "${UrlUtils.userBYId}/${widget.id}");
    //print(response);
    if (response != null) {
      GetSingleUser details = GetSingleUser.fromJson(response);
      singleProfile = details.result;
     /* if(response != null){
        Navigator.pop(context,);
      }*/
      setState(() {});
    } else {}
  }
}
