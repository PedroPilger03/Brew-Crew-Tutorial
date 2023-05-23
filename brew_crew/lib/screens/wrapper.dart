import 'package:brew_crew/models/coffee_user.dart';
import 'package:brew_crew/screens/authentificate/authentificate.dart';
import 'package:brew_crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    
    final cofferUser = Provider.of<CoffeeUser?>(context);
    
    // Return either Home or Authentificate Widget
    if (cofferUser == null){
      return Authentificate();
    } else {
      return Home();
    }
    
  }
}