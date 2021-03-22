import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';

class NavigatorScreen extends StatelessWidget {
  final ListModel item;

  NavigatorScreen({Key key, @required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (item != null) ...[
              Text(
                item.name,
                style: Theme.of(context).textTheme.headline6,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
