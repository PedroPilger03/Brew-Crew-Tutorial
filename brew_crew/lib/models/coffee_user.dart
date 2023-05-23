import 'package:flutter/material.dart';

class CoffeeUser {

  final String? uid;

  CoffeeUser({this.uid});

}

class CoffeeUserData {

  final String? uid;
  final String? name;
  final String? sugars;
  final int? strenght;

  CoffeeUserData({ required this.uid, required this.name, required this.sugars, required this.strenght});

}