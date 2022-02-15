import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rev_opoly/user.dart';

class PictureDetails extends StatefulWidget {
  const PictureDetails(String picture);
  @override
  _PictureDetailsState createState() => _PictureDetailsState();
}

class _PictureDetailsState extends State<PictureDetails> {
  String name;
  double screenHeight, screenWidth;
  List productlist;
  String _titlecenter = "Loading card...";
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Material App Bar'),
      ),
      body: Center(
        child: Container(
            child: Column(
          children: [
            productlist == null
                ? Flexible(child: Center(child: Text(_titlecenter)))
                : Flexible(
                    child: Center(
                        child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: (screenWidth / screenHeight) / 1.06,
                      children: List.generate(productlist.length, (index) {
                        return Padding(
                            padding: EdgeInsets.all(7),
                            child: Card(
                              elevation: 10,
                              child: InkWell(
                                  // onTap: () => _loadFoodDetail(index),
                                  child: Column(
                                children: [
                                  // Container(
                                  //   margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  //   height: screenHeight / 4.1,
                                  //   width: screenWidth / 1.2,
                                  //   child: CachedNetworkImage(
                                  //     imageUrl:
                                  //         "https://crimsonwebs.com/s271819/organadora/images/products/${productlist[index]['prid']}.jpg",
                                  //   ),
                                  // ),

                                  Text("hello"),
                                  SizedBox(height: 15),
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
}
