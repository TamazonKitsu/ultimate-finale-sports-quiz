import 'package:finalprojectsportsquiz/screens/homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:finalprojectsportsquiz/userdata/profile.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:firebase_core/firebase_core.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

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
              appBar: AppBar(title: Text("สร้างบัญชีผูู้ใช้"),
                backgroundColor: Colors.lightBlueAccent,
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
                              RequiredValidator(errorText: "Please enter your email!"),
                              EmailValidator(errorText: "Please enter your email in correct format!")
                            ]),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (String? email){
                              profile.email = email!;
                            },
                          ),
                          SizedBox(height: 15),
                          Text("Password",style: TextStyle(fontSize: 20.0)),
                          TextFormField(
                            validator: RequiredValidator(errorText: "Please enter your password!"),
                            obscureText: true,
                            onSaved: (String? password){
                              profile.password = password!;
                            },
                          ),
                          SizedBox(height: 30.0),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              child: Text("ลงทะเบียน",style: TextStyle(fontSize: 20.0,
                              color: Colors.white)),
                              onPressed: () async{
                                if(formKey.currentState!.validate()){
                                  formKey.currentState?.save();
                                  try {
                                    await FirebaseAuth.instance.createUserWithEmailAndPassword(
                                        email: profile.email,
                                        password: profile.password
                                    ).then((value) {
                                      formKey.currentState?.reset();
                                      Fluttertoast.showToast(
                                          msg: "สร้างบัญชีผู้ใช้สำเร็จ",
                                          gravity: ToastGravity.TOP
                                      );
                                      Navigator.pushReplacement(context,
                                          MaterialPageRoute(builder: (context){
                                            return HomeScreen();
                                          }));
                                    });
                                  }on FirebaseAuthException catch(e){
                                    String message;
                                    if(e.code == 'email-already-in-use'){
                                        message = 'This E-mail is already in use!';
                                    }
                                    else if(e.code == 'weak-password'){
                                        message = 'The Password Must Be Longer Than 6!';
                                    }
                                    else{
                                      message = e.message.toString();
                                    }
                                    Fluttertoast.showToast(
                                        msg: message,
                                        gravity: ToastGravity.CENTER
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlueAccent
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
