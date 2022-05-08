import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PictureDetails extends StatefulWidget {
  String name;
  PictureDetails(String picture) {
    this.name = picture;
  }

  @override
  _PictureDetailsState createState() => _PictureDetailsState();
}

class _PictureDetailsState extends State<PictureDetails> {
  String name;
  double screenHeight, screenWidth;
  List cardlist;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(65.0),
          child: AppBar(
            title: Text(widget.name.toUpperCase()),
            backgroundColor: Colors.black,
          )),
      body: Center(
          child: GridView.count(
              crossAxisCount: 1,
              childAspectRatio: (screenWidth / screenHeight) / 0.31,
              children: [
            for (int i = 1001; i <= 1016; i++)
              Padding(
                  padding: EdgeInsets.all(7),
                  child: Card(
                    elevation: 10,
                    child: InkWell(
                        onTap: () => _deleteimage(i),
                        child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                          height: screenHeight / 4.1,
                          width: screenWidth / 1.2,
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://hubbuddies.com/271819/revopoly/images/${widget.name}/${i}.png",
                          ),
                        ), 
                         
                        // IconButton(
                        //   icon: const Icon(Icons.delete),
                        //   color: Colors.red,
                        //   onPressed: () {
                        //     _deleteimage(1000+i);
                        //   },
                        // ),
                      ],
                    )),
                  )),
          ])),
    );
  }

  void _deleteimage(int i) {

  }
}
