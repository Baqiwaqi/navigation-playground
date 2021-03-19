import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersInformation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print(snapshot.error);
          return Text('Something went wrong: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 10.0),
          child: new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              final email = document.data()['email'];
              final username = document.data()['username'];
              final userRole = document.data()['role'];

              return new ListTile(
                onTap: () {},
                leading: new CircleAvatar(),
                title: new Row(
                  children: [
                    new Text(username),
                    SizedBox(width: 8.0),
                    new Text(email),
                    SizedBox(width: 8.0),
                  ],
                ),
                subtitle: new Text('Role : $userRole'),
                trailing: Icon(Icons.more_horiz),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
