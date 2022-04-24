import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rev_opoly/gamescreen.dart';
import 'package:rev_opoly/loginscreen.dart';
import 'package:rev_opoly/profile.dart';
import 'package:rev_opoly/user.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, this.user}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
     
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
          body: Container(
            constraints: BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(1), BlendMode.dstATop),
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 30, 10, 20),
                    child:
                        Image.asset('assets/images/revopoly1.png', scale: 0.5),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: 5)),
                    minWidth: 240,
                    height: 55,
                    // color: Colors.black,
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: _start,
                  ),
                  SizedBox(height: 35),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: 5)),
                    minWidth: 240,
                    height: 55,
                    // color: Colors.black,
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: _profile,
                  ),
                  SizedBox(height: 35),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: 5)),
                    minWidth: 240,
                    height: 55,
                    // color: Colors.black,
                    child: Text(
                      "Help",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    onPressed: _help,
                  ),
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.exit_to_app),
            backgroundColor: Colors.red,
            onPressed: _logout,
          )),
    );
  }

  void _help() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Rules of the Game", style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,)),
            content: Text(
                "Innn this game, players are going to click on the dices to roll the dices. \n" +
                    "Players need to answer the question when the character move to the specify picture." +
                    "Players can bought the technology when they answer correctly.\n\n"+
                    "After player moved, followed by bot turn. Player need to answer the question correctly to prevent the technology bought by the bot"+
                    "Player need to pay the rent to the bot if the technology is bought by the bot and vice versa"+
                    "The person who bought the most technology is the winner."),
            actions: [
              TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _start() {
      Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (content) => GameScreen(user: widget.user)));
  }
  void _logout() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Log Out Your Account?"),
            content: Text("Are you sure?"),
            actions: [
              TextButton(
                child: Text("Yes"),
                onPressed: () {
                  Fluttertoast.showToast(
                      msg: "Your Account has been logout",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Color.fromRGBO(191, 30, 46, 50),
                      textColor: Colors.white,
                      fontSize: 23.0);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (content) => LoginScreen()));
                },
              ),
              TextButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _profile() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => Profile(user: widget.user)));
  }
}
