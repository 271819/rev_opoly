import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
                  SizedBox(height: screenHeight/24.57), //30
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: 5)),
                    minWidth: screenWidth/1.63, //240
                      height: screenHeight/13.4, //55
                    // color: Colors.black,
                    child: Text(
                      "Start",
                      style: TextStyle(fontSize: screenHeight/24.56, color: Colors.white), //30
                    ),
                    onPressed: _start,
                  ),
                  SizedBox(height: screenHeight/21.05), //35
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: 5)),
                    minWidth: screenWidth/1.63, //240
                      height: screenHeight/13.4, //55
                    // color: Colors.black,
                    child: Text(
                      "Profile",
                      style: TextStyle(fontSize: screenHeight/24.56, color: Colors.white),//30
                    ),
                    onPressed: _profile,
                  ),
                  SizedBox(height: screenHeight/21.05), //35
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35),
                        side: BorderSide(color: Colors.red, width: screenWidth/78.4)),
                    minWidth: screenWidth/1.63, //240
                      height: screenHeight/13.4, //55
                    // color: Colors.black,
                    child: Text(
                      "Help",
                      style: TextStyle(fontSize: screenHeight/24.56, color: Colors.white),//30
                    ),
                    onPressed: _help,
                  ),
                  SizedBox(height: screenHeight/21.05), //35
                ],
              ),
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.exit_to_app),
            backgroundColor: Colors.red,
            onPressed: _logout,
          ),
    );
  }

  void _help() {
    double screenHeight = MediaQuery.of(context).size.height;
     showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                 shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
                title: Text("Rules of the Game", style: TextStyle(fontSize: 30)),
                content: new Container(
                    height: screenHeight / 1.9, //300
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Text(
                            "Player is the black colour and Bot is the red colour. "+"In this game, players are going to click on the dices to roll the dices. \n\n" +
                            "Players need to answer the question when the character move to the specify picture. " +
                            "Players can bought the technology when they answer correctly.\n\n"+
                            "After player moved, followed by bot turn. Player need to answer the question correctly to prevent the technology bought by the bot. "+
                            "Player need to pay the rent to the bot if the technology is bought by the bot and vice versa. "+
                            "The person who bought the most technology is the winner.\n\n"+"User can click on the name at the upper part of the game to view the technology that they had bought. "+
                            "User also can click on back button to give up the game or save the game"),
                          ),
                        ],
                      ),
                    )),
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
