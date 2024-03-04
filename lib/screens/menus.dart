import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 100.0),
              child: Text('Quiz', style: TextStyle(fontSize: 45.0)),
            ),
              MaterialButton(
              height: 40.0,
              color: Colors.blue,
              child: Text("PLAY!",
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white
                ),),
              onPressed: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context){
                      return MainScreen();
                    })
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
