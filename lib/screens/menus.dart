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
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(30.0)),
            Text("Quiz", style: TextStyle(fontSize: 50.0)),
            SizedBox(height: 200.0),
            MaterialButton(
              color: Colors.red,
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context){
                      return MainScreen();
                    })
                );
              },
              child: Text("PLAY!",
                style: TextStyle(
                    fontSize: 50.0,
                    color: Colors.white
                ),),
            )
          ],
        ),
      ),
    );
  }
}
