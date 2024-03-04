import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/screens/quiz1.dart';
import 'package:finalprojectsportsquiz/screens/quiz2.dart';
import 'package:finalprojectsportsquiz/screens/quiz3.dart';
import 'package:finalprojectsportsquiz/screens/quiz4.dart';
import 'package:finalprojectsportsquiz/screens/quiz5.dart';
import 'package:finalprojectsportsquiz/screens/homescreen.dart';

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
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("assets/images/43.jpg"),
            ),
            accountName: Text('Sports Quiz'),
            accountEmail: Text(auth.currentUser!.email.toString()),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/RW_Cutscene2.png"),
                    fit: BoxFit.cover,
                )
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: const Text('หน้าหลัก'),
            subtitle: Text('หน้าเมนูการใช้งาน'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.account_circle),
            title: const Text('ผู้ใช้งาน'),
            subtitle: Text('ผู้ใช้งานบัญชี'),
            trailing:  Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: const Text('ออกจากโปรแกรม'),
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
      body: Container(
          margin: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
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
                height: 50.0,
                color: Colors.grey,
                onPressed: startQuiz5,
                child: Text("Badminton",
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

