import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';
import 'package:finalprojectsportsquiz/appbar_clipper.dart';

class Menus extends StatefulWidget {
  const Menus({super.key});

  @override
  State<Menus> createState() => _MenusState();
}

class _MenusState extends State<Menus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          flexibleSpace: ClipPath(
            clipper: AppbarCustomClipper(),
            child: Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.blueAccent,
                    Colors.purpleAccent,
                  ],
                ),
              ),
              child: Center(
                child: Text("QUIZ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50.0,
                  ),),
              ),
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top:190.0),
              child: Center(
                child: MaterialButton(
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
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
