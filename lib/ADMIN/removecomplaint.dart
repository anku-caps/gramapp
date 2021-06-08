// import 'package:flutter/material.dart';
// import 'package:flutter_new_app/Staffs/COMPLAINTS/data/firestore_service.dart';
// import 'package:flutter_new_app/Staffs/COMPLAINTS/data/model/Status.dart';
// import 'package:flutter_new_app/Staffs/COMPLAINTS/presentation/pages/add_status.dart';
//
// class RemoveComplaint extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xffffffff),
//       appBar: AppBar(
//         backgroundColor: Color(0xfff38181),
//         title: Text('Complaint Status'),
//       ),
//       body: StreamBuilder(
//         stream: FirestoreService2().getStatus(),
//         builder: (BuildContext context, AsyncSnapshot<List<Status>> snapshot) {
//           if (snapshot.hasError || !snapshot.hasData)
//             return Center(child: CircularProgressIndicator());
//           return ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (BuildContext context, int index) {
//               Status st = snapshot.data[index];
//               return ListTile(
//                 title: Text(
//                   st.complaint,
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                 ),
//                 subtitle: Column(
//                   children: [
//                     Text(st.CID),
//                     Text(
//                       st.mobile,
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 leading: Text(
//                   st.add_status,
//                   style: TextStyle(color: Colors.green),
//                 ),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     IconButton(
//                       color: Colors.red,
//                       icon: Icon(Icons.delete),
//                       onPressed: () => _deleteEvent(context, st.id),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   void _deleteEvent(BuildContext context, String id) async {
//     if (await _showConfirmationDialog(context)) {
//       try {
//         await FirestoreService2().deleteStatus(id);
//       } catch (e) {
//         print(e);
//       }
//     }
//   }
//
//   Future<bool> _showConfirmationDialog(BuildContext context) async {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (context) => AlertDialog(
//           content: Text("Are you sure you want to delete?"),
//           actions: <Widget>[
//             FlatButton(
//               textColor: Colors.red,
//               child: Text("Delete"),
//               onPressed: () => Navigator.pop(context, true),
//             ),
//             FlatButton(
//               textColor: Colors.black,
//               child: Text("No"),
//               onPressed: () => Navigator.pop(context, false),
//             ),
//           ],
//         ));
//   }
// }
