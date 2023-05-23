import 'package:brew_crew/models/coffee_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create Coffee User based on FirebaseUser
  CoffeeUser? _coffeeUserFromFirebaseUser(User user) {
      return user != null ? CoffeeUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CoffeeUser?> get user {
    return _auth.authStateChanges()
    .map((User? user) => _coffeeUserFromFirebaseUser(user!));
  }

  //Sign in anonimusly
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _coffeeUserFromFirebaseUser(user!);
    }catch (e)
    {
      print(e.toString());
      return null;
    }
  } 

  //register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;

      //create new document for the user with uid
      await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);

      return _coffeeUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign in with email& password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _coffeeUserFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }

}