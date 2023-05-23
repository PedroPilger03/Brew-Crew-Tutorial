import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

import '../../shared/constants.dart';
import '../../shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function? toggleView;
  SignIn({ this.toggleView });

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
   final _formKey = GlobalKey<FormState>();
   bool loading = false;

   //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Sign in into Brew Crew'),
        actions: [
          TextButton.icon(
            onPressed: () {
              widget.toggleView!();
            }, 
            icon: Icon(Icons.person),
            label: Text('Register'))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Email',
                ),
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: textInputDecoration.copyWith(
                  hintText: 'Password',
                ),
                validator: (val) => val!.length < 6
                    ? 'Enter an password with more than 6 digits'
                    : null,
                obscureText: true,
                onChanged: (val) {
                  setState(() {
                    password = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                ),
                onPressed: () async{
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        loading = true;
                      });
                      dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if (result == null) {
                     setState(() {
                        error = 'COULD NOT SIGN IN WITH THOSE CREDENTIALS';
                        loading = false;
                      });
                    };
                  };
                },
                child: const Text(
                  'Sign in',
                  style: TextStyle(
                    color: Colors.white,
                  ),
              ))
            ],
          )
          ),
        ),
      );
  }
}
