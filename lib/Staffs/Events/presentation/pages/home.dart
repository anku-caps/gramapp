import 'package:flutter/material.dart';
import 'package:flutter_new_app/Staffs/Events/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';
import 'package:flutter_new_app/Staffs/Events/presentation/pages/add_note.dart';
import 'package:flutter_new_app/Staffs/Events/presentation/pages/note_details.dart';

class Home1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: AppBar(
        backgroundColor: Color(0xfff38181),
        title: Text('Events'),
      ),
      body: StreamBuilder(
        stream: FirestoreService().getNotes(),
        builder: (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
          if (snapshot.hasError || !snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              Note note = snapshot.data[index];
              return Card(
                elevation: 10,
                child: ListTile(
                  focusColor: Color(0xffeaffd0),
                  title: Text(
                    note.title,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    note.description,
                    style: TextStyle(fontSize: 0),
                  ),
                  leading: Text(note.date),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      IconButton(
                        color: Colors.blue,
                        icon: Icon(Icons.edit),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEventPage(note: note),
                            )),
                      ),
                      IconButton(
                        color: Colors.red,
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteEvent(context, note.id),
                      ),
                    ],
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EventDetailsPage(
                        note: note,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddEventPage()));
        },
      ),
    );
  }

  void _deleteEvent(BuildContext context, String id) async {
    if (await _showConfirmationDialog(context)) {
      try {
        await FirestoreService().deleteEvent(id);
      } catch (e) {
        print(e);
      }
    }
  }

  Future<bool> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
              content: Text("Are you sure you want to delete?"),
              actions: <Widget>[
                FlatButton(
                  textColor: Colors.red,
                  child: Text("Delete"),
                  onPressed: () => Navigator.pop(context, true),
                ),
                FlatButton(
                  textColor: Colors.black,
                  child: Text("No"),
                  onPressed: () => Navigator.pop(context, false),
                ),
              ],
            ));
  }
}
