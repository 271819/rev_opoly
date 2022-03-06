import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rev_opoly/homescreen.dart';
import 'package:rev_opoly/user.dart';

class GameScreen extends StatefulWidget {
  final User user;
  static int x, y, totalstep, totaldice, totalup = 0, totalleft = 0;
  static int left = 310, right = 670;
  static double boxwidth = 63, boxheight = 47;
  static double botboxwidth = 63, botboxheight = 47;
  static bool playerturn = true;
  static bool botturn = false;
  const GameScreen({Key key, this.user}) : super(key: key);
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

  void dice() {
    if (playerturn == true) {
      setState(() {
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
        }
        playerturn = false;
        botturn = true;
      });
      // if(totalstep==1 || totalstep==3 || totalstep==6|| totalstep==8){
      // irquestion(totalstep);
      // }else if(totalstep==2 || totalstep ==12){
      //   didyouknow(totalstep);
      // }else if(totalstep==4 || totalstep==23){
      //  inventor(totalstep);
      // }else if(totalstep==5){

      // }else if(totalstep==7 || totalstep==17 || totalstep==28){
      //   chance(totalstep);
      // }
      inventor(totalstep);
    } else {
      setState(() {
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
    }
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
                            width: 90,
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
                              width: 120,
                              child: Text(
                                  "Name: " + widget.user.name.toUpperCase(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Container(
                              width: 260,
                              child: Text("Email: " + widget.user.email,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ))),
                          Container(
                              width: 120,
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
                sleep(Duration(seconds: 3));
                dice();
                print(totaldice);
                print(totalstep);
                print(bottotaldice);
                print(bottotalstep);
              }),
        )
      ]),
    );
  }

  void irquestion(int totalstep) {
    TextEditingController _iranswer = new TextEditingController();
    int image = Random().nextInt(15) + 1;
    int updatemoney;
    double ir;
    int i;
    if (image < 10) {
      i = 100;
    } else {
      i = 10;
    }
    // if(totalstep==1){
    //   updatemoney = -1100;
    // }else if(totalstep ==3){
    //   updatemoney = -1200;
    // }else if(totalstep==6){
    //   updatemoney = -1300;
    // }else if(totalstep==8){
    //   updatemoney = -1400;
    // }
    if (totalstep == 1) {
      ir = 1.0;
    } else if (totalstep == 3) {
      ir = 2.0;
    } else if (totalstep == 6) {
      ir = 3.0;
    } else if (totalstep == 8) {
      ir = 4.0;
    }
    // updatemoney=-1100;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("This Question is for ir ?" + ir.toString(),
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
                _irAnswer(_iranswer.text.toString(), image, updatemoney, ir);
              },
            ),
            TextButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }

  void _irAnswer(String answer, int image, int updatemoney, double ir) {
    bool trueanswer = true;
    bool falseanswer = false;
    print(answer);
    print(image);
    print(updatemoney);
    if (ir == 1.0) {
      if (image == 1 || image ==2 || image ==3 || image ==4 || image ==5) {
        if (answer.contains("transition in the manufacturing processes") ||answer.contains("transition in manufacturing processes")||answer.contains("transition in the manufacturing processes from manual to machine production") || answer.contains("manufacturing processes from manual to machine production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is IR 1.0 is the transition in the manufacturing processes from manual to machine production",
              falseanswer, updatemoney);
        }
      } else if (image == 6||image == 7||image == 8) {
        if (answer.contains("impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.") || answer.contains("impacts the cotton-spinning and weaving mills industry.")||answer.contains("allow it to grow from small organisations to large organisations ")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is it impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.",
              falseanswer, updatemoney);
        }
      } else if (image == 9||image == 10||image == 11) {
        if (answer.contains("steam engine")||answer.contains("spinning jenny")|| answer.contains("weaving loom")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is steam engine, spinning jenny and weaving loom",
              falseanswer, updatemoney);
        }
      } else if (image == 12||image == 13) {
        if (answer.contains("increase productivity")||answer.contains("production efficiency")|| answer.contains("scale in goods mass production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is increase productivity, production efficiency and scale in goods mass production",
              falseanswer, updatemoney);
        }
      } else if (image == 14 ||image == 15) {
        if (answer.contains(" agriculture inductry")||answer.contains("textile industry")||answer.contains("agriculture industry and textile industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer are the agriculture industry and textile industry",
              falseanswer, updatemoney);
        }
      } else if (image == 16) {
        if (answer.contains("creates economic growth where many migrates to cities as it offers more job opportunities to improves the standard of living") || answer.contains("improve the standard of living")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is it creates economic growth where many migrates to cities as it offers more job opportunities to improves the standard of living",
              falseanswer, updatemoney);
        }
      }
    }else if (ir == 2.0) {
      if (image == 1 || image ==2 || image ==3 || image ==4 || image ==5) {
        if (answer.contains("development of electrical machines and assembly line production") ||answer.contains("development of electrical machines")||answer.contains("assembly line production")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is IR 2.0 is the development of electrical machines and assembly line production",
              falseanswer, updatemoney);
        }
      } else if (image == 6||image == 7||image == 8) {
        if (answer.contains("enhances the efficiency in improving the quality and mass production processes compared to the water and steam-based machines that are resource hungry.")||answer.contains("improving the quality and mass production processes compared to the water")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is it impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.",
              falseanswer, updatemoney);
        }
      } else if (image == 9||image == 10||image == 11) {
        if (answer.contains("assembly line")||answer.contains("internal combustion engine")||answer.contains("electric powered machines")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is assembly line, internal combustion engine, electric powered machines",
              falseanswer, updatemoney);
        }
      } else if (image == 12||image == 13) {
        if (answer.contains("more efficient in cost")||answer.contains("effort and maintenance")||answer.contains("effort")||answer.contains("maintenance")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is more efficient in cost, effort and maintenance",
              falseanswer, updatemoney);
        }
      } else if (image == 14 ||image == 15) {
        if (answer.contains("telegraph industry") || answer.contains("automotive industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer are the telegraph industry and automotive industry",
              falseanswer, updatemoney);
        }
      } else if (image == 16) {
        if (answer.contains("cost")||answer.contains("effort")||answer.contains("maintenance")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is Electrical machines are more efficient in cost, effort and maintenance ",
              falseanswer, updatemoney);
        }
      }
    }else if (ir == 3.0) {
      if (image == 1 || image ==2 || image ==3 || image ==4 || image ==5) {
        if (answer.contains("development and expansion of the computer and microprocessor") ||answer.contains("expansion of computer and microprocessor")||answer.contains("computer and microprocessor")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is IR 3.0 is the development and expansion of the computer and microprocessor",
              falseanswer, updatemoney);
        }
      } else if (image == 6||image == 7||image == 8) {
        if (answer.contains("advances in the invention and manufacturing of transistors and integrated circuits to automate machines") || answer.contains("manufacturing of transistors and integrated circuit to automate machines") || answer.contains("integrated circuits to automate machines")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is The advances in the invention and manufacturing of transistors and integrated circuits to automate machines.",
              falseanswer, updatemoney);
        }
      } else if (image == 9||image == 10||image == 11) {
        if (answer.contains("electronics")||answer.contains("telecommunications")||answer.contains("software systems")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is electronics, telecommunications and software systems",
              falseanswer, updatemoney);
        }
      } else if (image == 12||image == 13) {
        if (answer.contains("automate the entire production process")||answer.contains("automate the production process")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is Computers can automate the entire production process",
              falseanswer, updatemoney);
        }
      } else if (image == 14 ||image == 15) {
        if (answer.contains("manufacturing industry") || answer.contains("production industry")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer are the manufacturing industry and production industry",
              falseanswer, updatemoney);
        }
      } else if (image == 16) {
        if (answer.contains("creates economic growth where more job opportunities are available")||answer.contains("shows reliace on science and technology")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is It creates economic growth where more job opportunities are available. It also shows reliance on science and technology",
              falseanswer, updatemoney);
        }
      }
    }
    else if (ir == 4.0) {
      if (image == 1 || image ==2 || image ==3 || image ==4 || image ==5) {
        if (answer.contains("interconnectivity") ||answer.contains("automation")||answer.contains("machine learning") || answer.contains("real-time data")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is IR 4.0 focuses on interconnectivity, automation, machine learning and real-time data",
              falseanswer, updatemoney);
        }
      } else if (image == 6||image == 7||image == 8) {
        if (answer.contains("highly efficient management as interconnected machines.") || answer.contains("impacts the cotton-spinning and weaving mills industry.")||answer.contains("allow it to grow from small organisations to large organisations ")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is it impacts the cotton-spinning and weaving mills inductry, allowing it to grow from small businesses to large organisations serving a high number of demands due to the use of steam engines for power to replace manual work.",
              falseanswer, updatemoney);
        }
      } else if (image == 9||image == 10||image == 11) {
        if (answer.contains("hello")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is ",
              falseanswer, updatemoney);
        }
      } else if (image == 12||image == 13) {
        if (answer.contains("hello")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is ",
              falseanswer, updatemoney);
        }
      } else if (image == 14 ||image == 15) {
        if (answer.contains("hello")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is ",
              falseanswer, updatemoney);
        }
      } else if (image == 16) {
        if (answer.contains("hello")) {
          _irmessage("Congratulation. Your answer is correct", trueanswer,
              updatemoney);
        } else {
          _irmessage("Sorry. You are wrong. The correct answer is ",
              falseanswer, updatemoney);
        }
      }
    }
  }

  void _irmessage(String ans, bool noanswer, int updatemoney) {
    print("until here");
    setState(
      () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Do you know the answer?",
                    style: TextStyle(fontSize: 22)),
                content: new Container(
                  height: 300,
                  width: 450,
                  child: Column(
                    children: [
                      Container(
                        child: Text(ans),
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
    if (noanswer == true) {
      _updatescore();
      _updatemoney(updatemoney);
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

  void chance(int totalstep) {
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
                  chancemessage(image);
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

  void chancemessage(int image) {
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
  }

  void inventor(int totalstep) {
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
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                  // chancemessage(image);
                }),
          ],
        );
      },
    );
  }
}
