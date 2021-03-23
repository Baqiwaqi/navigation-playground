import 'package:flutter/material.dart';
import 'package:user_roles/models/main_menu_model.dart';

class SubMenuModel extends MainMenuModel{
  final Icon icon;
  final String name;
  final List<String> role;

  SubMenuModel({
    this.icon,
    this.name,
    this.role,
  });
}