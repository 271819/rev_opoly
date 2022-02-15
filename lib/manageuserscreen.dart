import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rev_opoly/user.dart';
import 'package:http/http.dart' as http;

class ManageUserScreen extends StatefulWidget {
  final User user;

  const ManageUserScreen({Key key, this.user}) : super(key: key);
  @override
  _ManageUserScreenState createState() => _ManageUserScreenState();
}

class _ManageUserScreenState extends State<ManageUserScreen> {
  double screenHeight, screenWidth;
  List userlist;
  String _titlecenter = "Loading...";
  TextEditingController srccontroller = new TextEditingController();
  ProgressDialog pr;
  String name = "";
  @override
  void initState() {
    super.initState();
    _loaduser(name);
  }

  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text('Manage User Information'),
            backgroundColor: Colors.black,
          )),
      body: Center(
        child: Container(
            child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: TextFormField(
                controller: srccontroller,
                decoration: InputDecoration(
                  hintText: "Search User",
                  suffixIcon: IconButton(
                    onPressed: () => _loaduser(srccontroller.text.toString()),
                    icon: Icon(Icons.search),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
            ),
            userlist == null
                ? Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                    child: Center(
                        child: GridView.count(
                      crossAxisCount: 1,
                      childAspectRatio: (screenWidth / screenHeight) / 0.35,
                      children: List.generate(userlist.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(8),
                            child: Card(
                              color: Colors.lightGreenAccent[400],
                              elevation: 12,
                              child: InkWell(
                                  // onTap: () => _loadFoodDetail(index),
                                  child: Column(
                                children: [
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 20, 20, 0),
                                      child: Text(
                                          userlist[index]['name'].toUpperCase(),
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      child: Text(
                                          "Email: " +
                                              userlist[index]['user_email'],
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      child: Text(
                                          "Phone: " + userlist[index]['phone'],
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      child: Text(
                                          "Score: " + userlist[index]['score'],
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))),
                                  Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20, 10, 20, 0),
                                      child: Text(
                                          "Money: " + userlist[index]['money'],
                                          style: TextStyle(
                                            fontSize: 18,
                                          ))),
                                  SizedBox(height: 15),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {},
                                  ),
                                ],
                              )),
                            ));
                      }),
                    )),
                  ),
          ],
        )),
      ),
    );
  }

  _loaduser(String name) {
    http.post(
        Uri.parse("https://javathree99.com/s271819/revopoly/php/load_user.php"),
        body: {
          'name': name,
        }).then((response) {
      if (response.body == "nodata") {
        _titlecenter = "Sorry no user";
        Fluttertoast.showToast(
            msg: "No User Found",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 23.0);
        return;
      } else {
        var jsondata = json.decode(response.body);
        userlist = jsondata["user"];
        setState(() {});
        print(userlist);
      }
    });
  }
}
