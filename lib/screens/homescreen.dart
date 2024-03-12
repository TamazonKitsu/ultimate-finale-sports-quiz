import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/accountsystem/register.dart';
import 'package:finalprojectsportsquiz/accountsystem/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register/Login"),
        backgroundColor: Colors.green,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("assets/images/SQ_logoV1.png"),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add,
                  color: Colors.white,),
                  label: Text("สร้างบัญชีผู้ใช้",
                  style: TextStyle(fontSize: 20.0,
                  color: Colors.white)),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context){
                          return RegisterScreen();
                      })
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: Icon(Icons.login,
                  color: Colors.white),
                  label: Text("เข้าสู่ระบบ",
                  style: TextStyle(fontSize: 20.0,
                  color: Colors.white)),
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context){
                          return LoginScreen();
                      })
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
