import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_new_app/Staffs/Events/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';
import 'package:flutter_new_app/notificationhelper.dart';

class AddEventPage extends StatefulWidget {
  final Note note;

  const AddEventPage({Key key, this.note}) : super(key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  GlobalKey<FormState> _key = GlobalKey<FormState>();
  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _dateController;
  FocusNode _descriptionNode, _dateNode;

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final notifications = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _titleController =
        TextEditingController(text: isEditMote ? widget.note.title : '');
    _descriptionController =
        TextEditingController(text: isEditMote ? widget.note.description : '');
    _descriptionNode = FocusNode();
    _dateController =
        TextEditingController(text: isEditMote ? widget.note.date : '');
    _dateNode = FocusNode();
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

  get isEditMote => widget.note != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff38181),
        title: Text(isEditMote ? 'Edit Note' : 'Add Note'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  textInputAction: TextInputAction.next,
                  onEditingComplete: () {
                    FocusScope.of(context).requestFocus(_descriptionNode);
                  },
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty)
                      return "Title cannot be empty";
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: "title",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  focusNode: _descriptionNode,
                  controller: _descriptionController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    labelText: "description",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10.0),
                TextFormField(
                  focusNode: _dateNode,
                  controller: _dateController,
                  maxLines: 1,
                  decoration: InputDecoration(hintText: 'Pick your Date'),
                  onTap: () async {
                    var date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2100));
                    _dateController.text = date.toString().substring(0, 10);
                  },
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.only(left: 148.0),
                  child: RaisedButton(
                    color: Color(0xfff38181),
                    textColor: Colors.white,
                    child: Text(isEditMote ? "Update" : "Save"),
                    onPressed: () async {
                      showOngoingNotification(notifications,
                          title: 'Event',
                          body: 'New Event has been posted . Checkout please.');
                      if (_key.currentState.validate()) {
                        try {
                          if (isEditMote) {
                            Note note = Note(
                              description: _descriptionController.text,
                              title: _titleController.text,
                              date: _dateController.text,
                              id: widget.note.id,
                            );
                            await FirestoreService().updateEvent(note);
                          } else {
                            Note note = Note(
                                description: _descriptionController.text,
                                title: _titleController.text,
                                date: _dateController.text);
                            await FirestoreService().addEvent(note);
                          }
                          Navigator.pop(context);
                        } catch (e) {
                          print(e);
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
