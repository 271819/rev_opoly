import 'package:flutter/material.dart';
import 'package:rev_opoly/picturecategory.dart';

import 'loginscreen.dart';
import 'manageuserscreen.dart';


class AdminScreen extends StatefulWidget {
  @override
  _AdminScreenState createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Page',
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Image.asset('assets/images/revopoly1.png', scale: 0.6)),

                SizedBox(height: 90),
                 MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minWidth: 240,
                      height: 85,
                      color: Colors.black,
                      child: Text(
                        "Manage User",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      onPressed: _manageuser,
                    ),

                 SizedBox(height: 50),
                 MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      minWidth: 240,
                      height: 85,
                      color: Colors.black,
                      child: Text(
                        "Manage Picture",
                        style: TextStyle(fontSize: 28, color: Colors.white),
                      ),
                      onPressed: _managepicture,
                    ),
                    SizedBox(height: 70),
              ],
            )
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        backgroundColor: Colors.black,
        onPressed: _onlogout,
      ),
      ),
    );
  }

  void _manageuser() {
    Navigator.push(context,
             MaterialPageRoute(builder: (content) => ManageUserScreen()));
  }

  void _managepicture() {
    Navigator.push(context,
             MaterialPageRoute(builder: (content) => PictureCategory()));
  }

  void _onlogout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Log out the account?"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (content) => LoginScreen()));
                },
              ),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }
}