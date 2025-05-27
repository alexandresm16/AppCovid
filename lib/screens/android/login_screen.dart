import 'package:aula/screens/android/dashbord.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('Tela de Login'),
      ),
      body: Container(
        color: Colors.green,
        padding: EdgeInsets.symmetric(vertical: 50.0),
        width: double.infinity,
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => Dashbord()
              ));

            },
          style: ButtonStyle(elevation: MaterialStateProperty.all(8)),
          child: Text(
          'Login',
          style: TextStyle(
            color: Colors.amber,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),);
  }
}
