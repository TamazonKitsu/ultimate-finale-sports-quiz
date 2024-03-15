import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:finalprojectsportsquiz/accountsystem/register.dart';
import 'package:finalprojectsportsquiz/accountsystem/login.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff45e3ff),
                  Color(0xffb338d5),
                ],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 70.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: 450,
                    height: 450,
                    child: Image.asset("assets/images/SQ_logoV1.png", fit: BoxFit.contain)),
                  SizedBox(
                    width: 210,
                    height: kMinInteractiveDimension,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        gradient: LinearGradient(
                          colors: [Color(0xffd4145a), Color(0xfffbb03b)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                      ),
                      child: ElevatedButton.icon(
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        label: Text("สร้างบัญชีผู้ใช้",
                            style: TextStyle(fontSize: 20.0, color: Colors.white)),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return RegisterScreen();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.0),
                  SizedBox(
                    width: 210.0,
                    height: kMinInteractiveDimension,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.0),
                        color: Colors.white,
                      ),
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.login, color: Color(0xffd4145a)),
                        label: GradientText("เข้าสู่ระบบ",
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                          gradientType: GradientType.linear,
                          colors: [
                            Color(0xffd4145a),
                            Color(0xfffbb03b),
                          ],
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return LoginScreen();
                            }),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
