// import 'package:flutter/material.dart';
// import 'package:flutter_new_app/ADMIN/removecomplaint.dart';
// import 'package:flutter_new_app/ADMIN/removeevent.dart';
// import 'package:flutter_new_app/Staffs/COMPLAINTS/presentation/pages/add_status.dart';
// import 'package:flutter_new_app/Staffs/Events/presentation/pages/add_note.dart';
// import 'package:flutter_new_app/Staffs/Events/presentation/pages/home.dart';
//
// import '../email_signup.dart';
// import 'adminpage.dart';
//
// class AdminComplaintEdit extends StatelessWidget {
//   const AdminComplaintEdit({Key key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Route route = MaterialPageRoute(builder: (c)=> AdminPage());
//                 Navigator.pushReplacement (context, route);
//               },
//               icon: Icon(Icons.arrow_back)
//           ),
//         ),
//         body:
//         Container(
//             margin: EdgeInsets.only(left: 5.0,right: 5.0),
//             child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 children: <Widget> [
//                   Container(
//                     margin: EdgeInsets.all(5),
//                     width: double.infinity,
//                     child: TextButton(
//                       child: Text("Remove Complaint"),
//                       style: TextButton.styleFrom(
//                           alignment: Alignment.center,
//                           primary: Colors.white,
//                           backgroundColor: Color(0xfff38181),
//                           textStyle: TextStyle(
//                             color: Colors.black,
//                             fontSize: 30,
//                           )
//                       ),
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(
//                             builder: (context) => RemoveComplaint()));
//                       },
//                     ),
//                   ),
//                 ]
//             )
//         )
//     );
//   }
// }
