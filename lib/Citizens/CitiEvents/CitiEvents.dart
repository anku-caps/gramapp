import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Staffs/Events/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/Events/data/model/note.dart';
import 'package:flutter_new_app/Staffs/Events/presentation/pages/note_details.dart';

class CitiContacts extends StatefulWidget {
  @override
  _CitiContactsState createState() => _CitiContactsState();
}

class _CitiContactsState extends State<CitiContacts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff38181),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 200.0,
                floating: false,
                pinned: true,
                iconTheme: IconThemeData(color: Colors.black),
                backgroundColor: Color(0xffffffff),
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Event List",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                        )),
                    background: Image.asset(
                      "assets/images/o2.png",
                      fit: BoxFit.cover,
                    )),
              ),
            ];
          },
          body: StreamBuilder(
            stream: FirestoreService().getNotes(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
              if (snapshot.hasError || !snapshot.hasData)
                return Center(child: CircularProgressIndicator());
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  Note note = snapshot.data[index];
                  return Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                        note.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(note.description),
                      leading: Text(note.date),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[],
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
        ));
  }
}
