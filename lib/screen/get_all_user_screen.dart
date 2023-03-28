import 'package:dio_api_real/screen/user_by_id.dart';
import 'package:dio_api_real/utils/url_utils.dart';
import 'package:flutter/material.dart';

import '../models/get_all_user_model.dart';
import '../services/network.dart';
import 'get_single_profile.dart';

class GetUser extends StatefulWidget {
  const GetUser({Key? key}) : super(key: key);

  @override
  State<GetUser> createState() => _GetUserState();
}

class _GetUserState extends State<GetUser> {
  List<AllUserResult> allUsers = [];

  @override
  void initState() {
    getAllUsers();
    // getRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Get UserList"),


      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.chevron_right),
          onPressed: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SingleProfile()),
        );
      }),
      body: allUsers.isEmpty ? const Center(child: CircularProgressIndicator()) :
            ListView.builder(
              itemCount: allUsers.length,
              itemBuilder: (con, index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) =>UserById(id:allUsers[index].id,))).then((value) {
                      if(value == true){
                        getAllUsers();
                      }
                    });
                  },
                  title: textUsers(allUsers[index].firstName),
                  subtitle: textUsers(allUsers[index].email),
                  trailing: textUsers(
                      allUsers[index].phoneNumber.toString()),
                  leading: GestureDetector(
                    onTap: () {
                      deleteUser(allUsers[index].id);
                    },
                      child: const Icon(Icons.delete)),
                  
                );
              },
            ),
      );
  }

  Text textUsers(String txt) =>
      Text(
        txt,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      );

  // getRequest() async {
  //   String url ="https://react.tutorialstaging.tech/api/v1/user/users";
  //   //String urlc = "https://reqres.in/api/users/2";
  //   final response = await Dio().get(url);
  //    print(response);
  //   // var responseData = json.decode(response.data.toString());
  //   // print(responseData);
  //   var decodedJson = AllUsersDetailsModel.fromJson(response.data);
  //   print("Response Get URl 1111111= ${response.statusCode}");
  //
  //   List<AllUserResult> users = [];
  //   users.addAll(decodedJson.result);
  //   // for (User  sUser in decodedJson.data??[]) {
  //   //   // User user =
  //   //   // User(
  //   //   //   id: sUser.id,
  //   //   //   firstName: sUser.firstName,
  //   //   //   lastName: sUser.lastName,
  //   //   //    email: sUser.email,
  //   //   //   avatar: sUser.avatar
  //   //   // );
  //   //   // print(user);
  //   //   users.add(sUser);
  //   //   /*UserListModel(
  //   //       data: sUser["data"],
  //   //       page: sUser["page"],
  //   //       perPage: sUser["perPage"],
  //   //       support: sUser["support"],
  //   //       total: sUser["total"],
  //   //       totalPages: sUser["totalPages"]);*/
  //   //
  //   //
  //   //   /*  List<User> users = [];
  //   // for (var singleUser in response.data) {
  //   //   User user = User(
  //   //       id: singleUser["id"],
  //   //       userId: singleUser["userId"],
  //   //       title: singleUser["title"],
  //   //       body: singleUser["body"]);
  //   //   users.add(user);*/
  //   //   /* User user = User(
  //   //       id: singleUser["id"],
  //   //       userId: singleUser["userId"],
  //   //       title: singleUser["title"],
  //   //       body: singleUser["body"]);
  //   //   users.add(user);*/
  //   // }
  //   // print(users);
  //   return users;
  // }
  Future<void> getAllUsers() async {
    // Map<String, dynamic> body =

    var response = await net.getWithDio(url: UrlUtils.getUser );
    print(response);
    if (response != null) {
      AllUsersDetailsModel details = AllUsersDetailsModel.fromJson(response);

      allUsers = details.result;
      setState(() {

      });
    } else {}
  }
Future<void> deleteUser(String id)async {
    var response = await net.deleteWithDio(url: "${UrlUtils.userBYId}/$id");
    print(response);
    if(response != null){
    getAllUsers();
    }
      setState(() {

      });
    }
}
