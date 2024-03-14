import 'package:finalprojectsportsquiz/screens/menus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:finalprojectsportsquiz/userdata/profile.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  UserProfile profile = UserProfile(email: '',password: '');
  final Future<FirebaseApp> firebase = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: firebase,
        builder: (context,snapshot){
          if(snapshot.hasError){
            return Scaffold(
              appBar: AppBar(
                title: Text("Error"),
              ),
              body: Center(
                child: Text("${snapshot.error}"),
              ),
            );
          }
          if(snapshot.connectionState == ConnectionState.done){
            return Scaffold(
              appBar: AppBar(title: Text("เข้าสู่ระบบ"),
                backgroundColor: Colors.green,
              ),
              body: Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("E-mail",style: TextStyle(fontSize: 20.0)),
                          TextFormField(
                            validator: MultiValidator([
                              RequiredValidator(errorText: "โปรดกรอกอีเมลของคุณ!"),
                              EmailValidator(errorText: "โปรดกรอกอีเมลของคุณให้ถูกต้อง!")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email){
                              profile.email = email!;
                            },
                          ),
                          SizedBox(height: 15),
                          Text("Password",style: TextStyle(fontSize: 20.0)),
                          TextFormField(
                            validator: RequiredValidator(errorText: "โปรดกรอกรหัสผ่านของคุณ!"),
                            obscureText: true,
                            onSaved: (String? password){
                              profile.password = password!;
                            },
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("ลงชื่อเข้าใช้",style: TextStyle(fontSize: 20.0,
                              color: Colors.white)),
                              onPressed: () async{
                                if(formKey.currentState!.validate()){
                                  formKey.currentState?.save();
                                  try {
                                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password).then((value){
                                          formKey.currentState?.reset();
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (context){
                                                return Menus();
                                              }));
                                    });
                                  }on FirebaseAuthException {
                                    Fluttertoast.showToast(
                                        msg: "โปรดกรอกข้อมูลของคุณให้ถูกต้อง",
                                        gravity: ToastGravity.CENTER
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
