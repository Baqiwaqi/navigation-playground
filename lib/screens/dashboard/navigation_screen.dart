import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/main_menu_model.dart';

class NavigationScreen extends StatelessWidget {
  NavigationScreen({
    Key key, 
    @required this.item,

  }) : super(key: key);

  final MainMenuModel item; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(),
      body: Row(
        children: [
          //check if item has subItems
          if (item.subMenu != null) 
          Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 60.0,
                  child: DrawerHeader(
                    child: Text(
                      item.name,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    addSemanticIndexes: true,
                    shrinkWrap: true,
                    itemCount: item.subMenu.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: item.subMenu[index].icon,
                        title: Text(item.subMenu[index].name),
                        onTap: () {},
                      );
                    }),
                    
              ],
            ),
          ),
           
          Padding(
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
        ],
      ),
    );
  }
}
