import 'package:brew_crew/screens/authentificate/register.dart';
import 'package:brew_crew/screens/authentificate/sign_in.dart';
import 'package:flutter/material.dart';

class Authentificate extends StatefulWidget {
  const Authentificate({super.key});

  @override
  State<Authentificate> createState() => _AuthentificateState();
}

class _AuthentificateState extends State<Authentificate> {

  bool showSignIn = true;
  void toggleView() {
    setState(() {
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}