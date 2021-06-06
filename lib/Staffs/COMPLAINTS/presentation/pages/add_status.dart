import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/data/model/Status.dart';
import 'package:flutter_new_app/Staffs/Events/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';
import 'package:flutter_new_app/notificationhelper.dart';

class AddStatusPage extends StatefulWidget {
  final Status st;

  const AddStatusPage({Key key, this.st}) : super(key: key);
  @override
  _AddStatusPageState createState() => _AddStatusPageState();
}

class _AddStatusPageState extends State<AddStatusPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _cidController;
  TextEditingController _complaintController;
  TextEditingController _mobileController;
  // ignore: non_constant_identifier_names
  TextEditingController _add_statusController;
  // ignore: non_constant_identifier_names
  FocusNode _complaintNode, _mobileNode, _add_statusNode;
  String dropdownValue = 'Completed';

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _cidController =
        TextEditingController(text: isEditMote ? widget.st.CID : '');
    _complaintController =
        TextEditingController(text: isEditMote ? widget.st.complaint : '');
    _complaintNode = FocusNode();
    _mobileController =
        TextEditingController(text: isEditMote ? widget.st.mobile : '');
    _mobileNode = FocusNode();
    _add_statusController =
        TextEditingController(text: isEditMote ? widget.st.add_status : '');
    _add_statusNode = FocusNode();

    final settingsAndroid = AndroidInitializationSettings('mipmap/ic_launcher');
    final settingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) =>
            onSelectNotification(payload));

    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS));
    notifications.initialize(
        InitializationSettings(android: settingsAndroid, iOS: settingsIOS),
        onSelectNotification: onSelectNotification);
  }

  // ignore: missing_return
  Future onSelectNotification(String payload) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Notfication"),
              content: Text("This is notification"),
            ));
  }

  get isEditMote => widget.st != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMote ? 'Edit Status' : 'Add Status'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                textInputAction: TextInputAction.next,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_complaintNode);
                },
                controller: _cidController,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Id cannot be empty";
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Complaint Id",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _complaintNode,
                controller: _complaintController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: "complaint subject",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField(
                focusNode: _mobileNode,
                controller: _mobileController,
                maxLines: 1,
                decoration: InputDecoration(
                  labelText: "Mobile",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10.0),
              DropdownButton<String>(
                value: dropdownValue,
                onChanged: (String newValue) {
                  setState(() {
                    dropdownValue = newValue;
                  });
                },
                items: <String>['Completed', 'Pending', 'Rejected']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20.0),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                child: Text(isEditMote ? "Update" : "Save"),
                onPressed: () async {
                  showOngoingNotification(notifications,
                      title: 'Complaint Status',
                      body:
                          'A new complaint status has been added by the staff.');
                  if (_key.currentState.validate()) {
                    try {
                      if (isEditMote) {
                        Status st = Status(
                          complaint: _complaintController.text,
                          CID: _cidController.text,
                          mobile: _mobileController.text,
                          add_status: dropdownValue,
                          id: widget.st.id,
                        );
                        await FirestoreService2().updateStatus(st);
                      } else {
                        Status st = Status(
                            complaint: _complaintController.text,
                            CID: _cidController.text,
                            mobile: _mobileController.text,
                            add_status: dropdownValue);

                        await FirestoreService2().addStatus(st);
                      }
                      Navigator.pop(context);
                    } catch (e) {
                      print(e);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
