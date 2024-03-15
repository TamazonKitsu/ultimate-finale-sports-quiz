import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';
import 'package:finalprojectsportsquiz/appbar_clipper.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class Menus extends StatelessWidget {
  const Menus({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
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
                child: Text(
                  "QUIZ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 65.0,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/decorations/menusdeco.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.red,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MainScreen()),
                    );
                  },
                  child: GradientText("PLAY!",
                    style: TextStyle(
                      fontSize: 70.0,
                    ),
                    gradientType: GradientType.linear,
                    colors: [
                      Color(0xff00a1ff),
                      Color(0xff00ff8f),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}