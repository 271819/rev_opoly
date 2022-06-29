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
                    Colors.black.withOpacity(0.94), BlendMode.dstATop),
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
                            "REV-OPOLY ON THE GO is a single-player game in the area of the emerging technology revolution. The player is represented by the game piece in black and the bot is in red. "+"To play the game, the player needs to click on the dices to roll them. \n\n" +
                            "When the player’s game piece lands on the specific space based on the number of moves shown on the dice,  the player needs to answer the question that appears, which is related to the specific space. " +
                            "If the player answers correctly, the player can buy the technology of the space they landed on.\n\n"+

                            "After the player’s turn is the bot’s. The bot’s game piece will land on the specific space based on the number of moves shown on the dice. The player needs to answer the question correctly to prevent the technology from being bought by the bot. "+
                            "The player needs to pay the rent to the bot if the player lands on the technology space bought by the bot and vice versa. "+
                            "To end the game, the player (player or bot) who bought the most technologies is the winner.\n\n"+
                            
                            "The player can click on the name at the upper part of the screen to view a list of technology that the player bought.  "+
                            "The player can click on the back button (arrow) to end or save the game"),
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
              backgroundColor:Colors.lightGreenAccent,
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
