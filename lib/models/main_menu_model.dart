
import 'package:flutter/material.dart';
import 'package:user_roles/models/sub_menu_model.dart';

class MainMenuModel {
  final Icon icon;
  final String name;
  final List<String> role;
  final List<SubMenuModel> subMenu;
  

  MainMenuModel({
    this.icon,
    this.name,
    this.role,
    this.subMenu,
  });
}