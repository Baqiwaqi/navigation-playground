import 'package:flutter/material.dart';
//models
import 'package:user_roles/models/listtile_model.dart';
//dashboard
import 'package:user_roles/screens/dashboard/navigation_screen.dart';

class NavigationPage extends Page {
  NavigationPage({
    @required this.item
    }) : super(key: ValueKey(item));

  final ListModel item;

  // If you prefer, you can also extend Page to customize the behavior. 
  // For example, this page adds a custom transition animation
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, animation2) {
        final tween = Tween (begin: Offset(0.0, 1.0), end: Offset.zero);
        final curveTween = CurveTween(curve: Curves.bounceInOut);
        return SlideTransition(
          position: animation.drive(curveTween).drive(tween),
          child: NavigationScreen(
            key: ValueKey(item),
            item: item,
          ),
        );
      }
    );
  }
  
}