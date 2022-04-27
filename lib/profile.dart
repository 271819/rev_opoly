import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rev_opoly/loginscreen.dart';
import 'package:rev_opoly/user.dart';
import 'package:flutter/services.dart';

class Profile extends StatefulWidget {
  final User user;

  const Profile({Key key, this.user}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  double screenHeight, screenWidth;
  File _image;
  String pathAsset = "assets/images/profile.png";
  bool _isEnable = false;
  bool _isEnablePhone = false;
  ProgressDialog pr;
  static String statusImg="no";
  TextEditingController nameController = new TextEditingController();
  TextEditingController phoneController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    nameController.text = widget.user.name;
    phoneController.text = widget.user.matric;
    // CachedNetworkImage.evictFromCache("https://javathree99.com/s271819/revopoly/images/profile/${widget.user.email}.png");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    // ignore: missing_required_param
    pr = ProgressDialog(context);
    pr.style(
      message: 'Updating...',
      borderRadius: 5.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
    );
    return Scaffold(
      body: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/sky.jpg"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.9), BlendMode.dstATop)),
          ),
          child: SingleChildScrollView(
            child: Column(children: [
              AppBar(
                title: Text('PROFILE',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    )), // You can add title here
                leading: new IconButton(
                  icon: new Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                backgroundColor: Colors.blue
                    .withOpacity(0.3), //You can make this transparent
                elevation: 0.0, //No shadow
              ),
              Container(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 30, 30, 20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () => {_onUploadPic()},
                              child: Container(
                                height: screenHeight/3.35,//220,
                                width: screenWidth/1.5,//260, 
                                // decoration: BoxDecoration(
                                //   image: DecorationImage(
                                //     image: _image == null
                                //         ? AssetImage(pathAsset)
                                //         : FileImage(_image),

                                //     fit: BoxFit.cover,
                                //   ),
                                //   border: Border.all(
                                //     width: 4.0,
                                //     color: Colors.black,
                                //   ),
                                //   // borderRadius: BorderRadius.circular(20.0),
                                // ),


                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: widget.user.imgstatus == "no"
                                      ? Image.asset(
                                          "assets/images/profile.png",
                                          fit: BoxFit.fitWidth,
                                        )
                                      // : Image.network("https://javathree99.com/s271819/revopoly/images/profile/${widget.user.email}.png",fit:BoxFit.fitWidth)
                                      : CachedNetworkImage(
                                          imageUrl:
                                              "https://javathree99.com/s271819/revopoly/images/profile/${widget.user.email}.png",
                                          fit: BoxFit.fill,
                                        ),
                                ),
                              )),
                          SizedBox(height: 30),
                          Divider(
                            color: Colors.black,
                            height: 20,
                            thickness: 5,
                          ),
                          SizedBox(height: screenHeight/24.5), //30
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Name: ",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Container(
                                  width: 150,
                                  child: TextField(
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: nameController,
                                    enabled: _isEnable,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        _isEnable = true;
                                      });
                                    })
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight/73.7), //10
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Matrix No: ",
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    )),
                                Container(
                                  width: 90,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                    controller: phoneController,
                                    enabled: _isEnablePhone,
                                  ),
                                ),
                                IconButton(
                                    icon: Icon(Icons.edit),
                                    onPressed: () {
                                      setState(() {
                                        _isEnablePhone = true;
                                      });
                                    }),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight/36.85), //20
                          Text("Email:  " + widget.user.email,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: screenHeight/18.4), //40
                          MaterialButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            minWidth: screenWidth/1.96,//200
                            height: screenHeight/14.74, //50
                            color: Colors.blueAccent,
                            child: Text(
                              "Update Information",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: _saveChange,
                          ),
                        ],
                      ),
                    )),
              ),
            ]),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.exit_to_app),
        backgroundColor: Colors.black,
        onPressed: _onlogout,
      ),
    );
  }

  Future _onUploadPic() async {
    
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
        source: ImageSource.camera, maxHeight: 800, maxWidth: 800);

    setState(() {
      if (pickedFile != null) {
        statusImg ="yes";
        _image = File(pickedFile.path);
      } else {
        print("No image selected");
      }
    });
  }

  void _saveChange() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
            Radius.circular(20),
          )),
          title: Text("Update Information ?", style: TextStyle(fontSize: 25)),
          content: Text("Are you sure?"),
          actions: [
            TextButton(
              child: Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                _updateInformation();
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

  Future<void> _updateInformation() async {
     if(statusImg=="no" || _image==null){
        Fluttertoast.showToast(
            msg: "Please click image to choose your profile picture",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 23.0);
    }else{
    pr = ProgressDialog(context,
        type: ProgressDialogType.Normal, isDismissible: true, showLogs: true);
    await pr.show();
    String base64Image = base64Encode(_image.readAsBytesSync());
    String name = nameController.text.toString();
    String matric = phoneController.text.toString();
    print(name);
    print(matric);
   
    http.post(
        Uri.parse(
            "https://javathree99.com/s271819/revopoly/php/update_profile.php"),
        body: {
          "name": name,
          "matric": matric,
          "email": widget.user.email,
          "encoded_string": base64Image
        }).then((response) {
      print(response.body);
      if (response.body == "success") {
        CachedNetworkImage.evictFromCache(
            "https://javathree99.com/s271819/revopoly/images/profile/${widget.user.email}.png");
        Fluttertoast.showToast(
            msg: "Successfully update your Profile !!! ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 3,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 23.0);

        setState(() {
          widget.user.name = nameController.text.toString();
          widget.user.matric = phoneController.text.toString();
          widget.user.imgstatus = "yes";
          
        });
        pr.hide().then((isHidden) {
          print(isHidden);
        });
        
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromRGBO(191, 30, 46, 50),
            textColor: Colors.white,
            fontSize: 23.0);
        pr.hide().then((isHidden) {
          print(isHidden);
        });
      }
    });
    }
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
