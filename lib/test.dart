// import 'package:flutter/material.dart';

// class Test extends StatefulWidget {
//   @override
//   _TestState createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Material App Bar'),
//       ),
//       body: Center(
//           child: Column(
//         children: [
//           Draggable<String>(
//             // Data is the value this Draggable stores.
//             // data: _color,
//             child: Container(
//               height: 120.0,
//               width: 120.0,
//               child: Center(
//                 child: Image.asset('assets/images/chance.png'),
//               ),
//             ),
//             feedback: Container(
//               height: 120.0,
//               width: 120.0,
//               child: Center(
//                 child: Image.asset('assets/images/profile.png'),
//               ),
//             ),
//             //New
//             childWhenDragging: Container(
//                 // height: 120.0,
//                 // width: 120.0,
//                 // child: Center(
//                 //   child: Image.asset('assets/images/revopoly.png'),
//                 // ),
//                 ),
//           ),
//           DragTarget<String>(
//             builder: (
//               BuildContext context,
//               List<dynamic> accepted,
//               List<dynamic> rejected, 
//             ) {
//               return Container(
//                 height: 300,
//                 width: 300,
//                 child: Center(
//                   child: Image.asset(_isDropped
//                       ? 'assets/images/revopoly.png'
//                       : 'assets/images/revopolyy.png'),
//                 ),
//               );
//             },
//             onWillAccept: (data) {
//               return data == 'red';
//             },
//             onAccept: (data) {
//               setState(() {
//                 showSnackBarGlobal(context, 'Dropped successfully!');
//                 _isDropped = true;
//               });
//             },
//           ),
//         ],
//       )),
//     );
//   }
// }
