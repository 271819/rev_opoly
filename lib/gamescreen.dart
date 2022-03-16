import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rev_opoly/bot.dart';
import 'package:rev_opoly/homescreen.dart';
import 'package:rev_opoly/user.dart';

class GameScreen extends StatefulWidget {
  final User user;
  final Bot bot;
  static int x, y, totalstep, totaldice, totalup = 0, totalleft = 0;
  static int left = 310, right = 670;
  static double boxwidth = 63, boxheight = 47;
  static double botboxwidth = 63, botboxheight = 47;
  static bool playerturn = true;
  static bool botturn = false;
  const GameScreen({Key key, this.user,this.bot}) : super(key: key);
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int leftdice_no = 1;
  int rightdice_no = 1;
  bool playerturn = true;
  bool botturn = false;
  int totalup = 0, totalleft = 0, totaldice = 0, totalstep = 0;
  int bottotalup = 0, bottotalleft = 0, bottotaldice = 0, bottotalstep = 0;
  double boxwidth = 63, boxheight = 47;
  double botboxwidth = 63, botboxheight = 47;
  bool whoturn = true;
  int botscore=0;
  List<String> botdetails = new List<String>();
  void dice() {
    if (playerturn == true) {
      setState(() {
        whoturn = true;
        leftdice_no = Random().nextInt(6) + 1;
        rightdice_no = Random().nextInt(6) + 1;
        int x = leftdice_no;
        int y = rightdice_no;
        totaldice = x + y;
        totalstep = totalstep + x + y;
        if (totalstep <= 10) {
          totalup = 0;
          totalleft = totalstep;
        } else if (totalstep > 10 && totalstep <= 15) {
          totalup = totalstep - 10;
          totalleft = 10;
        } else if (totalstep == 25) {
          totalup = 0;
          totalstep = 10;
          totalleft = 10;
        } else if (totalstep > 15 && totalstep <= 25) {
          totalup = 5;
          totalleft = 25 - totalstep;
        } else if (totalstep > 25 && totalstep <= 30) {
          totalleft = 0;
          totalup = 30 - totalstep;
        } else {
          totalstep = totalstep - 30;
          totalleft = totalstep;
          totalup = 0;
          _updatemoney(2000);
        }
        playerturn = false;
        botturn = true;
      });
      if (totalstep == 1 ||
          totalstep == 3 ||
          totalstep == 6 ||
          totalstep == 8 ||
          totalstep == 9) {
        // sleep(Duration(seconds: 5));

        irquestion(totalstep, whoturn);
      } else if (totalstep == 2 || totalstep == 12) {
        didyouknow(totalstep);
      } else if (totalstep == 4) {
        inventor3(totalstep, whoturn);
      } else if (totalstep == 23) {
        inventor23(totalstep, whoturn);
      } else if (totalstep == 5 ||
          totalstep == 11 ||
          totalstep == 13 ||
          totalstep == 14 ||
          totalstep == 16 ||
          totalstep == 18 ||
          totalstep == 19 ||
          totalstep == 20 ||
          totalstep == 21 ||
          totalstep == 22 ||
          totalstep == 24 ||
          totalstep == 26 ||
          totalstep == 27 ||
          totalstep == 29) 
          {technologyquestion(totalstep, whoturn);
      } else if (totalstep == 7 || totalstep == 17 || totalstep == 28) {
        chance(totalstep, whoturn);
      }
    } else {
      setState(() {
        whoturn = false;
        leftdice_no = Random().nextInt(6) + 1;
        rightdice_no = Random().nextInt(6) + 1;
        int x = leftdice_no;
        int y = rightdice_no;
        bottotaldice = x + y;
        bottotalstep = bottotalstep + x + y;
        if (bottotalstep <= 10) {
          bottotalup = 0;
          bottotalleft = bottotalstep;
        } else if (bottotalstep > 10 && bottotalstep <= 15) {
          bottotalup = bottotalstep - 10;
          bottotalleft = 10;
        } else if (bottotalstep == 25) {
          bottotalup = 0;
          bottotalstep = 10;
          bottotalleft = 10;
        } else if (bottotalstep > 15 && bottotalstep <= 25) {
          bottotalup = 5;
          bottotalleft = 25 - bottotalstep;
        } else if (bottotalstep > 25 && bottotalstep <= 30) {
          bottotalleft = 0;
          bottotalup = 30 - bottotalstep;
        } else {
          bottotalstep = bottotalstep - 30;
          bottotalleft = bottotalstep;
          bottotalup = 0;
        }
        playerturn = true;
        botturn = false;
      });
      if (bottotalstep == 1 ||
          bottotalstep == 3 ||
          bottotalstep == 6 ||
          bottotalstep == 8 ||
          bottotalstep == 9) {
        // sleep(Duration(seconds: 5));

        irquestion(bottotalstep, whoturn);
      } else if (bottotalstep == 2 || bottotalstep == 12) {
        didyouknow(bottotalstep);
      } else if (bottotalstep == 4) {
        inventor3(bottotalstep, whoturn);
      } else if (bottotalstep == 23) {
        inventor23(bottotalstep, whoturn);
      } else if (bottotalstep == 5 ||
          bottotalstep == 11 ||
          bottotalstep == 13 ||
          bottotalstep == 14 ||
          bottotalstep == 16 ||
          bottotalstep == 18 ||
          bottotalstep == 19 ||
          bottotalstep == 20 ||
          bottotalstep == 21 ||
          bottotalstep == 22 ||
          bottotalstep == 24 ||
          bottotalstep == 26 ||
          bottotalstep == 27 ||
          bottotalstep == 29) {
        technologyquestion(bottotalstep, whoturn);
      } else if (bottotalstep == 7 ||
          bottotalstep == 17 ||
          bottotalstep == 28) {
        chance(bottotalstep, whoturn);
      }
    }
  }
  @override
  void initState() {
    _loadbotscore();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          child: SingleChildScrollView(
            child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/revopolyy.jpg"),
                      fit: BoxFit.fill,
                      colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.7), BlendMode.dstATop)),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    Container(
                      child: Row(
                        children: [
                          Container(
                            width: 80,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: IconButton(
                                icon: Icon(
                                  Icons.arrow_back,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (content) =>
                                              HomeScreen(user: widget.user)));
                                  SystemChrome.setPreferredOrientations([
                                    DeviceOrientation.portraitUp,
                                    DeviceOrientation.portraitUp
                                  ]);
                                },
                              ),
                            ),
                          ),
                          Container(
                              width: 80,
                              child: Text(widget.user.name.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          InkWell(
                              child: Row(
                                children: [
                                  Container(
                                      width: 85,
                                      child: Text("Score: " + widget.user.score,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  Container(
                                      width: 120,
                                      child: Text("Money: " + widget.user.money,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ],
                              ),
                              onTap: () {}),
                          Container(
                              width: 70,
                              child: Text("VS",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    fontSize: 20,
                                  ))),
                          InkWell(
                              child: Row(
                                children: [
                                  
                                  Container(
                                      width: 85,
                                      child: Text("Bot",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  Container(
                                      width: 90,
                                      child: Text("Score: ",
                                      // + botdetails[index]['score'],
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))),
                                  Container(
                                      width: 120,
                                      child: Text("Money: " + widget.user.money,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ))),
                                ],
                              ),
                              onTap: () {}),
                        ],
                      ),
                    ),
                    Container(
                        child: Row(
                      children: [
                        Container(
                          height: 70,
                          width: 82,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/digital.JPG'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/images/cyberSecurity.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/chance.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/ar.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/bigData.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/smartcity.JPG'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/iotcity.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/iotRetail.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/inventor.JPG'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 63,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/iotHealth.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          height: 70,
                          width: 86,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/back.JPG'),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ],
                    )),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/iotGrid.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/systemIntegration.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/iotHome.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/additiveManufacturing.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/didyouknoww.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 47,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/chancee.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 46,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/cloudComputing.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 46,
                            width: 82,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/iotAgri.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 71,
                            width: 85,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/stone.JPG'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/future.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ir4.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/chance.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ir3.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/smartwear.JPG'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/inventor3.JPG'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ir2.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/didyouknow.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 63,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/ir1.png'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Container(
                            height: 70,
                            width: 83,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/Go.JPG'),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          ),
        ),
        Positioned(
          top: 310 - (totalup) * boxheight,
          left: 680 - (totalleft) * boxwidth,
          child: Container(
            height: 50,
            width: 30,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/player.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        Positioned(
            top: 310 - (bottotalup) * boxheight,
            left: 670 - (bottotalleft) * boxwidth,
            child: Container(
              height: 50,
              width: 30,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bot.png'),
                  fit: BoxFit.fill,
                ),
              ),
            )),
        Positioned(
          top: 190,
          left: 300,
          child: InkWell(
              child: Row(
                children: [
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/dice$leftdice_no.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:
                            AssetImage('assets/images/dice$rightdice_no.jpg'),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () {
                dice();
                print("black turn " + totaldice.toString());
                print("black turn " + totalstep.toString());
                print("red turn " + bottotaldice.toString());
                print("red turn " + bottotalstep.toString());
              }),
        )
      ]),
    );
  }

  void irquestion(int totalstep, bool whoturn) {
    TextEditingController _iranswer = new TextEditingController();
    int image = Random().nextInt(15) + 1;
    int updatemoney;
    String text;
    int i;
    if (image < 10) {
      i = 100;
    } else {
      i = 10;
    }

    if (totalstep == 1) {
      updatemoney = -1100;
      text = "IR 1.0";
    } else if (totalstep == 3) {
      updatemoney = -1200;
      text = "IR 2.0";
    } else if (totalstep == 6) {
      updatemoney = -1300;
      text = "IR 3.0";
    } else if (totalstep == 8) {
      updatemoney = -1400;
      text = "IR 4.0";
    } else if (totalstep == 9) {
      updatemoney = -1000;
      text = "Future Trends";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("This Question is for " + text,
              style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 340,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://javathree99.com/s271819/revopoly/images/ir_question/$i${image}.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextField(
                    controller: _iranswer,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Answer",
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                print(_iranswer.text);
                Navigator.of(context).pop();
                _irAnswer(_iranswer.text.toString(), image, updatemoney, text,
                    whoturn);
              },
            ),
            TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _updatemoney(-100);
                }),
          ],
        );
      },
    );
  }

  void _irAnswer( String answer, int image, int updatemoney, String text, bool whoturn) {
    bool trueanswer = true;
    bool falseanswer = false;
    print(answer);
    print(image);
    print(updatemoney);
    if (text == "IR 1.0") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("transition in the manufacturing processes") ||
            answer.contains("transition in manufacturing processes") ||
            answer.contains(
                "transition in the manufacturing processes from manual to machine production") ||
            answer.contains(
                "manufacturing processes from manual to machine production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is IR 1.0 is the transition in the manufacturing processes from manual to machine production",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 6 || image == 7 || image == 8) {
        if (answer.contains(
                "impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.") ||
            answer.contains(
                "impacts the cotton-spinning and weaving mills industry.") ||
            answer.contains(
                "allow it to grow from small organisations to large organisations ")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is it impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 9 || image == 10 || image == 11) {
        if (answer.contains("steam engine") ||
            answer.contains("spinning jenny") ||
            answer.contains("weaving loom")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is steam engine, spinning jenny and weaving loom",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 12 || image == 13) {
        if (answer.contains("increase productivity") ||
            answer.contains("production efficiency") ||
            answer.contains("scale in goods mass production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer, updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is increase productivity, production efficiency and scale in goods mass production",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 14 || image == 15) {
        if (answer.contains(" agriculture inductry") ||
            answer.contains("textile industry") ||
            answer.contains("agriculture industry and textile industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer are the agriculture industry and textile industry",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 16) {
        if (answer.contains(
                "creates economic growth where many migrates to cities as it offers more job opportunities to improves the standard of living") ||
            answer.contains("improve the standard of living")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is it creates economic growth where many migrates to cities as it offers more job opportunities to improves the standard of living",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      }
    } else if (text == "IR 2.0") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "development of electrical machines and assembly line production") ||
            answer.contains("development of electrical machines") ||
            answer.contains("assembly line production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is IR 2.0 is the development of electrical machines and assembly line production",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 6 || image == 7 || image == 8) {
        if (answer.contains(
                "enhances the efficiency in improving the quality and mass production processes compared to the water and steam-based machines that are resource hungry.") ||
            answer.contains(
                "improving the quality and mass production processes compared to the water")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer, updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is it impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 9 || image == 10 || image == 11) {
        if (answer.contains("assembly line") ||
            answer.contains("internal combustion engine") ||
            answer.contains("electric powered machines")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is assembly line, internal combustion engine, electric powered machines",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 12 || image == 13) {
        if (answer.contains("more efficient in cost") ||
            answer.contains("effort and maintenance") ||
            answer.contains("effort") ||
            answer.contains("maintenance")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is more efficient in cost, effort and maintenance",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 14 || image == 15) {
        if (answer.contains("telegraph industry") ||
            answer.contains("automotive industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer are the telegraph industry and automotive industry",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 16) {
        if (answer.contains("cost") ||
            answer.contains("effort") ||
            answer.contains("maintenance")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Electrical machines are more efficient in cost, effort and maintenance ",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      }
    } else if (text == "IR 3.0") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("development and expansion of the computer and microprocessor") ||
            answer.contains("expansion of computer and microprocessor") ||
            answer.contains("computer and microprocessor")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is IR 3.0 is the development and expansion of the computer and microprocessor",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 6 || image == 7 || image == 8) {
        if (answer.contains("advances in the invention and manufacturing of transistors and integrated circuits to automate machines") ||
            answer.contains("manufacturing of transistors and integrated circuit to automate machines") ||
            answer.contains("integrated circuits to automate machines")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is The advances in the invention and manufacturing of transistors and integrated circuits to automate machines.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 9 || image == 10 || image == 11) {
        if (answer.contains("electronics") ||
            answer.contains("telecommunications") ||
            answer.contains("software systems")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is electronics, telecommunications and software systems",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 12 || image == 13) {
        if (answer.contains("automate the entire production process") ||
            answer.contains("automate the production process")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Computers can automate the entire production process",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 14 || image == 15) {
        if (answer.contains("manufacturing industry") ||
            answer.contains("production industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer are the manufacturing industry and production industry",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 16) {
        if (answer.contains(
                "creates economic growth where more job opportunities are available") ||
            answer.contains("shows reliace on science and technology")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is It creates economic growth where more job opportunities are available. It also shows reliance on science and technology",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      }
    } else if (text == "IR 4.0") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("interconnectivity") ||
            answer.contains("automation") ||
            answer.contains("machine learning") ||
            answer.contains("real-time data")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is IR 4.0 focuses on interconnectivity, automation, machine learning and real-time data",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 6 || image == 7 || image == 8) {
        if (answer.contains(
                "highly efficient management as interconnected machines.") ||
            answer.contains("can virtually self-manage") ||
            answer.contains("the use of other technologies")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is It shows highly efficient management as interconnected machines can virtually self-manage with the use of other technologies.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 9 || image == 10 || image == 11) {
        if (answer.contains("internet of things") ||
            answer.contains("cloud technology") ||
            answer.contains("artificial intelligence")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Internet of Things, cloud technnology and artificial intelligence",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 12 || image == 13) {
        if (answer.contains("process can be completely virtually visualised") ||
            answer.contains("monitored") ||
            answer.contains("managed from a remote location")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is The process can be completely virtually visualised, monitored and managed from a remote location",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 14 || image == 15) {
        if (answer.contains("manufacturing industry") ||
            answer.contains("production industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is The manufacturing industry and production industry",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 16) {
        if (answer.contains(
                "create economic growth where more job opportunities are available") ||
            answer.contains("shows reliance on science and technology")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is It creates economic growth where more job opportunities are available. It also shows reliance on science and technology.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      }
    } else if (text == "Future Thrends") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "technological transformation to change the way devices and technologies interact") ||
            answer
                .contains("change the way devices and technologies interact")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Technological transformation to change the way devices and technologies interact",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 6 || image == 7 || image == 8) {
        if (answer.contains(
                "technologies advances in terms of their components, innovations and applications") ||
            answer.contains("components") ||
            answer.contains("innovations") ||
            answer.contains("applications")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Technologies advances in terms of their components, innovations and application",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 9 || image == 10 || image == 11) {
        if (answer.contains("extended reality") ||
            answer.contains("quantum computing") ||
            answer.contains("distributed ledger technology") ||
            answer.contains("artificial intelligence")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is Extended reality, quantum computing, distributed ledger technology and artificial intelligence",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 12 || image == 13) {
        if (answer.contains(
                "basis for the development of the innovation strategy to increase efficiency and productivity") ||
            answer.contains(
                "innovation strategy to increase efficiency and productivity")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is The basis for the development of the innovation strategy to increase efficiency and productivity",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 14 || image == 15) {
        if (answer.contains("manufacturing industry") ||
            answer.contains("production industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is The manufacturing industry and production industry",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      } else if (image == 16) {
        if (answer.contains(
                "create economic growth where more job opportunities are available") ||
            answer.contains("shows reliance on science and technology")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney, whoturn, text);
        } else {
          _irmessage(
              "Sorry. You are wrong. The correct answer is It creates economic growth where more job opportunities are available. It also shows reliance on science and technology.",
              falseanswer,
              updatemoney,
              whoturn,
              text);
        }
      }
    }
  }

  void _irmessage( String ans, bool noanswer, int updatemoney, bool whoturn, String text) {
    print("until here");
    String title;
    if (noanswer == true) {
      title = "Congratulation!!!";
    } else {
      title = "Oh.. Unfortunately";
    }
    setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title, style: TextStyle(fontSize: 22)),
                content: new Container(
                  height: 300,
                  width: 450,
                  child: Column(
                    children: [
                      Container(
                        child: Text(ans, style: TextStyle(fontSize: 15)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      },
    );
    if (whoturn == true) {
      //player turn
      if (noanswer == true) {
        //true answer
        _updatescore();
        _updatemoney(updatemoney);
        _updatetechnology(whoturn, text);
      } else {
        //false answer
        _updatemoney(-100);
      }
    } else {
      //bot turn
      if (noanswer == true) {
        //player answer correctly
        _updatescore();
        _updatemoney(updatemoney);
        _updatebotmoney(-100);
        _updatetechnology(whoturn, text);
      } else {
        _updatemoney(-100);
        _updatebotmoney(updatemoney);
        _updatetechnology(whoturn, text);
      }
    }
  }

  void _updatescore() {
    int score = int.parse(widget.user.score);
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/update_score.php"),
        body: {
          "email": widget.user.email,
          "score": widget.user.score,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        setState(() {
          score++;
          widget.user.score = score.toString();
        });
      }
    });
  }

  void didyouknow(int totalstep) {
    int image = Random().nextInt(15) + 1;
    int i;
    if (image < 10) {
      i = 100;
    } else {
      i = 10;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Did you know ?", style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 340,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://javathree99.com/s271819/revopoly/images/did_you_know/$i${image}.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void chance(int totalstep, bool whoturn) {
    int image = Random().nextInt(15) + 1;
    int i;
    if (image < 10) {
      i = 100;
    } else {
      i = 10;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Chance", style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 340,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://javathree99.com/s271819/revopoly/images/chance/$i${image}.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  chancemessage(image, whoturn);
                }),
          ],
        );
      },
    );
  }

  void _updatemoney(int updatemoney) {
    print(updatemoney);
    int currentmoney = int.parse(widget.user.money);
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/update_money.php"),
        body: {
          "email": widget.user.email,
          "money": widget.user.money,
          "updatemoney": updatemoney.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        int updated = updatemoney + currentmoney;
        setState(() {
          widget.user.money = updated.toString();
        });
      }
    });
  }

  void _updatebotmoney(int updatebotmoney) {
    print(updatebotmoney);
    // int currentmoney = int.parse(widget.user.money);
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/update_botmoney.php"),
        body: {
          "email": widget.user.email,
          "money": widget.user.money,
          "updatemoney": updatebotmoney.toString(),
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        // int updated = updatebotmoney + currentmoney;
        setState(() {
          // widget.user.money = updated.toString();
        });
      }
    });
  }

  void chancemessage(int image, bool whoturn) {
    if (whoturn == true) {
      if (image == 1 || image == 2 || image == 3) {
        _updatemoney(0);
      } else if (image == 4 || image == 5 || image == 6) {
        _updatemoney(-500);
      } else if (image == 7) {
        _updatemoney(-300);
      } else if (image == 8) {
        _updatemoney(200);
      } else if (image == 9) {
        _updatemoney(-200);
      } else if (image == 10 || image == 14) {
        _updatemoney(500);
      } else if (image == 11) {
        _updatemoney(1000);
      } else if (image == 12) {
        _updatemoney(-800);
      } else if (image == 13) {
        _updatemoney(-1000);
      } else if (image == 15) {
        _updatemoney(1500);
      } else if (image == 16) {
        _updatemoney(-400);
      }
    } else {
      if (image == 1 || image == 2 || image == 3) {
        _updatebotmoney(0);
      } else if (image == 4 || image == 5 || image == 6) {
        _updatebotmoney(-500);
      } else if (image == 7) {
        _updatebotmoney(-300);
      } else if (image == 8) {
        _updatebotmoney(200);
      } else if (image == 9) {
        _updatebotmoney(-200);
      } else if (image == 10 || image == 14) {
        _updatebotmoney(500);
      } else if (image == 11) {
        _updatebotmoney(1000);
      } else if (image == 12) {
        _updatebotmoney(-800);
      } else if (image == 13) {
        _updatebotmoney(-1000);
      } else if (image == 15) {
        _updatebotmoney(1500);
      } else if (image == 16) {
        _updatebotmoney(-400);
      }
    }
  }

  void inventor3(int totalstep, bool whoturn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Chance", style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 340,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/inventor3.JPG'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (whoturn == true) {
                    _updatemoney(-2000);
                  } else {
                    _updatebotmoney(-2000);
                  }
                }),
          ],
        );
      },
    );
  }

  void inventor23(int totalstep, bool whoturn) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Your Chance", style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: Column(
              children: [
                Container(
                  height: 160,
                  width: 340,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/inventor.JPG'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  if (whoturn == true) {
                    _updatemoney(-2000);
                  } else {
                    _updatebotmoney(-2000);
                  }
                }),
          ],
        );
      },
    );
  }

  void technologyquestion(int totalstep, bool whoturn) {
    TextEditingController _iranswer = new TextEditingController();
    int image = Random().nextInt(15) + 1;
    int updatemoney;
    String technology;
    int i;
    if (image < 10) {
      i = 100;
    } else {
      i = 10;
    }

    if (totalstep == 5) {
      technology = "Smart Wearable";
      updatemoney = -3000;
    } else if (totalstep == 11) {
      technology = "Cloud Computing";
      updatemoney = -1380;
    } else if (totalstep == 13) {
      technology = "IoT in Smart Home";
      updatemoney = -1340;
    } else if (totalstep == 14) {
      technology = "IoT in Smart Grid";
      updatemoney = -1500;
    } else if (totalstep == 16) {
      technology = "Cyber Security";
      updatemoney = -1500;
    } else if (totalstep == 18) {
      technology = "Augmented Reality";
      updatemoney = -1260;
    } else if (totalstep == 19) {
      technology = "Big Data";
      updatemoney = -1440;
    } else if (totalstep == 20) {
      technology = "Smart City";
      updatemoney = -3000;
    } else if (totalstep == 21) {
      technology = "IoT in Smart City";
      updatemoney = -1200;
    } else if (totalstep == 22) {
      technology = "IoT in Retail Market";
      updatemoney = -1020;
    } else if (totalstep == 24) {
      technology = "IoT in Health Care";
      updatemoney = -1580;
    } else if (totalstep == 26) {
      technology = "System Integration";
      updatemoney = -1660;
    } else if (totalstep == 27) {
      technology = "Additive Manufacturing";
      updatemoney = -1700;
    } else if (totalstep == 29) {
      technology = "IoT in Agriculture";
      updatemoney = -1240;
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("This Question is for " + technology.toString(),
              style: TextStyle(fontSize: 22)),
          content: new Container(
            height: 300,
            width: 450,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 100,
                    width: 340,
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://javathree99.com/s271819/revopoly/images/technology/$i${image}.png",
                      fit: BoxFit.fill,
                    ),
                  ),
                  TextField(
                    controller: _iranswer,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Answer",
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              child: Text("Submit"),
              onPressed: () {
                print(_iranswer.text);
                Navigator.of(context).pop();
                _technologyAnswer(_iranswer.text.toString(), image, updatemoney,
                    technology, whoturn);
              },
            ),
            TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                  _updatemoney(-100);
                }),
          ],
        );
      },
    );
  }
  
  void _technologyAnswer(String answer, int image, int updatemoney,String technology, bool whourn) {
    bool trueanswer = true;
    bool falseanswer = false;
    print(answer);
    print(image);
    print(updatemoney);
    if (technology == "Smart Wearable" || technology == "IoT in Health Care") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer
                .contains("an electronic device connected to other devices") ||
            answer.contains(
                "an electronic device generally connected to other devices via wireless protocols") ||
            answer.contains(
                "an electronic device connected to other devices by using wireless protocols")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is an electronic device generally connected to other devices via wireless protocols",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("smartwatch") ||
            answer.contains("fitness tracker")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is smartwatch and fitness tracker",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains(
                "the trend to stay connected, detect, analyse and transmit information concerning the wearer") ||
            answer.contains("transmit informatiion concerning the wearer") ||
            answer.contains("analyse information concerning the wearer")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is The trend to stay connected, detect, analyse and transmit information concerning the wearer",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("short battery life") ||
            answer.contains("inaccurate measured data") ||
            answer.contains("privacy and security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is The challenges are the cost, short battery life, inaccurate measured data, privacy and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Smart Home" ||
        technology == "IoT in Smart Home") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "a system that can remotely control connected home appliances") ||
            answer.contains("remotely control connected home appliances")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is a system that can remotely control connected home appliances",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("smart fridge") ||
            answer.contains("smart washing machine") ||
            answer.contains("smart light bulbs")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is smart fridge, smart washing machine and smart light bulbs",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains(
                "allows home devices to be managed from one place which is convenient") ||
            answer.contains("allows home devices to be managed")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is It allows home devices to be managed from one place which is convenient",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("Internet reliance") ||
            answer.contains("complex setup and configuration") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is The challenges are the cost, Internet reliance, complex setup and configuration and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Smart City" ||
        technology == "IoT in Smart City") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("an urban area that uses connected electronic internet of things to collect data") ||
            answer.contains(
                "uses connected electronic internet of things to collect data") ||
            answer.contains(
                "an urban area that uses connected electronic Internet of Things to collect data")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is an urban area that uses connected electronic Internet of Things to collect data",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("smart parking") ||
            answer.contains("smart traffic control system") ||
            answer.contains("smart air quality sensors")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is smart parking, smart traffic control systems and smart air quality sensors",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("improves urban planning and the environment") ||
            answer.contains("improves the environment")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it improves urban planning and the environment",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("privacy and security") ||
            answer.contains("privacy") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is the cost, privacy and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "IoT in Smart Grid") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "two-way intercharge of electricity and information between power utilities and consumers") ||
            answer.contains(
                "information between power utilities and consumers")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the two-way intercharge of electricity and information between power utilities and consumers",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("smart meters") ||
            answer.contains("smart power generation") ||
            answer.contains("smart appliances")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is smart meters, smart power generation and smart appliances",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("enables real-time surveillance") ||
            answer
                .contains("efficient management of energy supply and demand")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it enables real-time surveillance and efficient management of energy supply and demand",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("internet reliance") ||
            answer.contains("network congestion during emergency situations") ||
            answer.contains("security of smart devices") ||
            answer.contains("cost to install smart devices")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is the challenges are in terms of Internet reliance, network congestion during emergency situations, security of smart devices and cost to install smart devices",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "IoT in Retail Market") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("use of technologies to enhance store operation") ||
            answer
                .contains("improve the shopping experience of the customer") ||
            answer.contains("accelerate inventory management")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the use of technologies to enhance store operation, improve the shopping experience of the customers and accelerate inventory management",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("smart payment system") ||
            answer.contains("smart labels") ||
            answer.contains("intelligent vending machines")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is smart payment system, smart labels and intelligent vending machines",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("leads to a decentralised") ||
            answer.contains("transparent") ||
            answer.contains("optimised sales process for retailers")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it leads to a decentralised, transparent and optimised sales process for retailers",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("privacy") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is the cost, privacy and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "IoT in Agriculture") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "use of technologies that includes the internet of things, sensors, drones and robots on the farm") ||
            answer.contains("inernets of things, sensors, drones and robots")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the use of technologies that includes the Internet of Things, sensors, drones and robots on the farm",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("agricultural drones") ||
            answer.contains("smart climate monitoring") ||
            answer.contains("smart greenhouse automation") ||
            answer.contains("smart crop management")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is agricultural drones, smart climate monitoring, smart greenhouse automation and smart crop management",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("makes every espect of farming more reliable") ||
            answer.contains("predictable") ||
            answer.contains("sustainable")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it makes every aspect of farming more reliable, predictable and sustainable",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("in the connectivity in rural areas") ||
            answer.contains("big data monitoring") ||
            answer.contains(
                "learning curve with the concept of smart farming and security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are in the connectivity in rural areas, big data monitoring, learning curve with the concept of smart farming and security.",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Cloud Computing") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "on-demand availability of computer system resources over the internet") ||
            answer.contains("on-demand availability of computer system")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the on-demand availability of computer system resources over the Internet",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("file storage") ||
            answer.contains("sharing system") ||
            answer.contains("online software") ||
            answer.contains("online operating system")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is file storage and sharing system, online software and online operating system",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("faster retrievals of applications data") ||
            answer.contains(
                "more accurate retrievals of applications and data") ||
            answer.contains(
                "enables faster and more accurate retrievals of applications and data")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it enables faster and more accurate retrievals of applications and data",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("internet reliance") ||
            answer.contains("storage capacity") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are the cost, Internet reliance, storage capacity and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Cyber Security") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "protection of computer systems and networks against security threats") ||
            answer.contains(
                "protection of computer system against security threats")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the protection of computer systems and netwoks against security threats",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("encryption") ||
            answer.contains("authentication") ||
            answer.contains("authorisation")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are encryption, authentication and authorisation",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("protects the system from unwanted threats in the digital environment") ||
            answer.contains(
                "protects the system from unwanted attacks in the digital environment") ||
            answer.contains(
                "protects the system from unwanted threats and attacks in the digital environment")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it protects the system from unwanted threats and attacks in the digital environment",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("setup and configuration") ||
            answer.contains("require frequent updates")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are the cost, setup and configuration and require frequent updates",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Augmented Reality") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "the rendering of virtual objects to the real-world environment") ||
            answer.contains(
                "rendering of virtual objects to the real-world environment")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the rendering of virtual objects to the real-world environment",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("Nintendo's Pokemon Go")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is Nintendo's Pokemon Go",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains(
            "creates unique digital experience that blend the diigital and physical worlds")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it creates creates unique digital experience that blend the diigital and physical worlds",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("privacy") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is the challenges are the cost, privacy and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Big Data") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("a collection of a large volume of data")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is a collection of a large volumn of data",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("google search index") ||
            answer.contains("facebook user profiles database") ||
            answer.contains("netflix user data")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is Google search index, Facebook user profiles database and Netflix user data",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("collects massive data") ||
            answer.contains("stores massive data") ||
            answer.contains("analyses massive data") ||
            answer.contains("collects, stores and analyses massive data")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it collects, stores and analyses massive data",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("require data scientists and big data experts") ||
            answer.contains("data quality issues") ||
            answer.contains("security")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are the cost, require data scientists and big data experts, data quality issues and security",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "System Integration") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains(
                "the process of linking different systems or components to one large system") ||
            answer.contains(
                "the process of linking different system to one large system")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the process of linking different systems or components to one large system",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("connecting administration") ||
            answer.contains("data collection") ||
            answer.contains("processing payments into one single system")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are connecting administration, data collection and processing payments into one single system",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains(
            "creates a coordinated system with joined database and data sources")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it creates a coordinated system with joined database and data sources",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("security") ||
            answer.contains("complex upgrading")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are the cost, security and complex upgrading",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    } else if (technology == "Additive Manufacturing") {
      if (image == 1 || image == 2 || image == 3 || image == 4 || image == 5) {
        if (answer.contains("industrial production name for 3D printing")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is " +
                  technology +
                  " is the industrial production name for 3D printing",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 6 || image == 7) {
        if (answer.contains("3D printing")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is 3D printing",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 8 || image == 9 || image == 10 || image == 11) {
        if (answer.contains("print multiple movable parts as a single piece") ||
            answer.contains(
                "print multiple movable parts as a single piece to save time and cost")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer is it can print multiple movable parts as a single piece to save time and cost",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 12 || image == 13 || image == 14 || image == 15) {
        if (answer.contains("cost") ||
            answer.contains("slow build rate") ||
            answer.contains("limited component size and volume") ||
            answer.contains("requires post-processing")) {
          _technologymessage("Congratulation. Your answer is correct",
              trueanswer, updatemoney, technology, whoturn);
        } else {
          _technologymessage(
              "Sorry. You are wrong. The correct answer are the cost, slow build rates, limited component size and volume, and requires post-processing",
              falseanswer,
              updatemoney,
              technology,
              whoturn);
        }
      } else if (image == 16) {
        _technologymessage("Your opinion is correct", trueanswer, updatemoney,
            technology, whoturn);
      }
    }
  }

  void _technologymessage(String ans, bool noanswer, int updatemoney,String technology, bool whoturn) {
    String title;
    if (noanswer == true) {
      title = "Congratulation!!!";
    } else {
      title = "Oh.. Unfortunately";
    }
    setState(
      () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title, style: TextStyle(fontSize: 22)),
                content: new Container(
                  height: 300,
                  width: 450,
                  child: Column(
                    children: [
                      Container(
                        child: Text(ans, style: TextStyle(fontSize: 25)),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      }),
                ],
              );
            });
      },
    );

    if (whoturn == true) {
      //player turn
      if (noanswer == true) {
        //answer correctly
        _updatescore();
        _updatemoney(updatemoney);
        _updatetechnology(whoturn, technology);
      } else {
        _updatemoney(-100);
      }
    } else {
      //bot turn
      if (noanswer == true) {
        //player answer correctly
        whoturn = true;
        _updatescore();
        _updatemoney(updatemoney);
        _updatebotmoney(-100);
        _updatetechnology(whoturn, technology);
      } else {
        _updatemoney(-100);
        _updatebotmoney(updatemoney);
        _updatetechnology(whoturn, technology);
      }
    }
  }

  void _updatetechnology(bool whoturn, String technology) {
    print(technology);
    String status;
    if (whoturn == true) {
      status = "player";
    } else {
      status = "bot";
    }
    print(status);
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/update_technology.php"),
        body: {
          "email": widget.user.email,
          "technology": technology,
          "status": status,
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        setState(() {});
      }
    });
  }

void _loadbotscore() {
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/load_botscore.php"),
        body: {
          "email": widget.user.email,
        }).then((response) {
      if (response.body == "nodata") {
        return;
      }else {
        var jsondata = json.decode(response.body);
        botdetails = jsondata["botdetails"];
        print(response.body);
      
      setState(() {
        
      });
      }
    });
  }


}