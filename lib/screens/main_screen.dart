import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/screens/quiz1.dart';
import 'package:finalprojectsportsquiz/screens/quiz2.dart';
import 'package:finalprojectsportsquiz/screens/quiz3.dart';
import 'package:finalprojectsportsquiz/screens/quiz4.dart';
import 'package:finalprojectsportsquiz/screens/quiz5.dart';
import 'package:finalprojectsportsquiz/screens/homescreen.dart';
import 'package:finalprojectsportsquiz/screens/menus.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget myDrawer = Drawer(
      backgroundColor: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 64,
              ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle,
              color: Colors.white),
            title: const Text('ผู้ใช้งาน',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
            subtitle: Text(auth.currentUser!.email.toString(),
              style: TextStyle(color: Colors.white, fontSize: 14.0)),
          ),
          ListTile(
            leading: Icon(Icons.home,
              color: Colors.white,),
            title: const Text('หน้าหลัก',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context){
                    return Menus();
                  })
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app,
              color: Colors.white),
            title: const Text('ออกจากระบบ',
              style: TextStyle(color: Colors.white, fontSize: 18.0)),
            trailing: Icon(Icons.keyboard_arrow_right,
                color: Colors.white),
            onTap: () {
              auth.signOut().then((value) {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) {
              return HomeScreen();
                }));
              });
            },
          ),
        ],
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Sports Quiz'),
        backgroundColor: Colors.blue,
      ),
      drawer: myDrawer,
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                minWidth: 300,
                height: 50.0,
                color: Colors.blue,
                onPressed: startQuiz1,
                child: Text("Football",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 300,
                height: 50.0,
                color: Colors.lightGreen,
                onPressed: startQuiz2,
                child: Text("Basketball",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 300,
                height: 50.0,
                color: Colors.orangeAccent,
                onPressed: startQuiz3,
                child: Text("Volleyball",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 300,
                height: 50.0,
                color: Colors.red,
                onPressed: startQuiz4,
                child: Text("Baseball",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),),
              ),
              SizedBox(height: 20),
              MaterialButton(
                minWidth: 300,
                height: 50.0,
                color: Colors.grey,
                onPressed: startQuiz5,
                child: Text("American Football",
                  style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white
                  ),),
              )
            ],
          )
      ),
    );
  }

  void startQuiz1() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Quiz1()));
    });
  }

  void startQuiz2() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Quiz2()));
    });
  }

  void startQuiz3() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Quiz3()));
    });
  }

  void startQuiz4() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Quiz4()));
    });
  }

  void startQuiz5() {
    setState(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const Quiz5()));
    });
  }
}

