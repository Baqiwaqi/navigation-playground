import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({
    Key key, 
    @required this.item
    }) : super(key: key);

  final ListModel item;
  
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
