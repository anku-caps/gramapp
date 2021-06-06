import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/data/firestore_service.dart';
import 'package:flutter_new_app/Staffs/COMPLAINTS/data/model/Status.dart';

class ViewStatusPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.black),
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text("Complaint status",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      )),
                  background: Image.network(
                    "https://res.cloudinary.com/dok0wwyum/image/upload/v1622703321/undraw_Reviewed_docs_re_9lmr_xjhkkl.png",
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: StreamBuilder(
          stream: FirestoreService2().getStatus(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Status>> snapshot) {
            if (snapshot.hasError || !snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Status st = snapshot.data[index];
                return ListTile(
                  title: Text(
                    st.complaint,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(st.CID),
                      Text(st.mobile),
                    ],
                  ),
                  leading: Text(
                    st.add_status,
                    style: TextStyle(
                        color: Color(0xff95e1d3), fontWeight: FontWeight.bold),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
