import 'package:brew_crew/models/coffee_user.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  const SettingsForm({super.key});

  @override
  State<SettingsForm> createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  // from values
  String? _currentName;
  String? _currentSugars;
  int? _currentStrenght;

  @override
  Widget build(BuildContext context) {
    final cofferUser = Provider.of<CoffeeUser?>(context);

    return StreamBuilder<CoffeeUserData>(
        stream: DatabaseService(uid: cofferUser!.uid).userData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {

            CoffeeUserData? coffeeUserData = snapshot.data;
            return Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Update your brew settings.',
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: coffeeUserData!.name,
                    decoration: textInputDecoration,
                    validator: (val) =>
                        val!.isEmpty ? 'Please enter a name' : null,
                    onChanged: (val) => setState(() => _currentName = val),
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: textInputDecoration,
                    value: _currentSugars ?? coffeeUserData.sugars,
                    items: sugars.map((sugar) {
                      return DropdownMenuItem(
                        value: sugar,
                        child: Text('$sugar sugars'),
                      );
                    }).toList(),
                    onChanged: (val) => setState(() => _currentSugars = val),
                  ),
                  Slider(
                    value: (_currentStrenght ?? coffeeUserData.strenght)!.toDouble(),
                    activeColor: Colors.brown[_currentStrenght ?? coffeeUserData.strenght!],
                    inactiveColor: Colors.brown[_currentStrenght ?? coffeeUserData.strenght!],
                    min: 100,
                    max: 900,
                    divisions: 8,
                    onChanged: (val) =>
                        setState(() => _currentStrenght = val.round()),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink[400],
                    ),
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await DatabaseService(uid: cofferUser.uid).updateUserData(
                          _currentSugars ?? coffeeUserData.sugars!,
                          _currentName ?? coffeeUserData.name!,
                          _currentStrenght ?? coffeeUserData.strenght!
                        );
                        Navigator.pop(context);
                      }
                    },
                  )
                ],
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}
