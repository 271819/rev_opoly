import 'package:flutter/material.dart';
import 'package:rev_opoly/PictureDetails.dart';

class PictureCategory extends StatefulWidget {
  @override
  _PictureCategoryState createState() => _PictureCategoryState();
}

class _PictureCategoryState extends State<PictureCategory> {
  double screenHeight, screenWidth;

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: AppBar(
            title: Text('Manage Picture'),
            backgroundColor: Colors.black,
          )),
      body: Center(
          child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: (screenWidth / screenHeight) / 1.21,
              children: [
            Column(
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: InkWell(
                        onTap:()=>_dyk(),
                          child: Image.asset('assets/images/1000.png',
                              scale: 0.99)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: InkWell(
                        onTap:()=>_chance(),
                          child: Image.asset('assets/images/2000.png',
                              scale: 0.5)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: InkWell(
                        onTap:()=>_technology(),
                          child: Image.asset('assets/images/3000.png',
                              scale: 0.5)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black)),
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: InkWell(
                        onTap:()=>_ir_question(),
                          child: Image.asset('assets/images/4000.png',
                              scale: 0.5)),
                    ),
                    SizedBox(height: 15),
                  ],
                ),
              ],
            ),
          ])),
    );
  }

  _dyk() {
    String name = "did_you_know";
    Navigator.push(context,
                      MaterialPageRoute(builder: (content) => PictureDetails(name)));
  }

  _chance() {
     String name = "chance";
    Navigator.push(context,
                      MaterialPageRoute(builder: (content) => PictureDetails(name)));
  }

  _technology() {
     String name = "technology";
    Navigator.push(context,
                      MaterialPageRoute(builder: (content) => PictureDetails(name)));
  }

  _ir_question() {
     String name = "ir_question";
    Navigator.push(context,
                      MaterialPageRoute(builder: (content) => PictureDetails(name)));
  }
}
