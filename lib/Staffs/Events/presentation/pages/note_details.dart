import 'package:flutter/material.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';

class EventDetailsPage extends StatelessWidget {
  final Note note;

  const EventDetailsPage({Key key, @required this.note}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xfff38181),
        title: Text('Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Event Name: '),
            Text(
              note.title,
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.bold, fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text('Event Description: '),
            Text(
              note.description,
              style: TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 20.0),
            Text('Event Date: '),
            Text(
              note.date,
              style: TextStyle(fontSize: 26.0),
            ),
          ],
        ),
      ),
    );
  }
}
