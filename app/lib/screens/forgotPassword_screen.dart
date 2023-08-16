import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class forgotPasswordScreen extends StatefulWidget {
  @override
  State<forgotPasswordScreen> createState() => _forgotPasswordScreenState();
}

class _forgotPasswordScreenState extends State<forgotPasswordScreen> {
  String email = '';
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[600],
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(top: 80, bottom: 80),
            color: Colors.blue[600],
            child: Center(child:
            Text(
              'Enter Your Email Adress below and check your inbox',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30,
              ),
            )),
          ),
          Expanded(child:Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Column(children: [
                SizedBox(height: 20,),
                Text('Login', style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[600],
                ),),
                TextField( onChanged: (value) {
                  email = value;
                },
                  decoration: InputDecoration(
                    label:Text('Email', style: TextStyle(
                      color: Colors.blue[600],
                    ),),
                  ),
                ),
                SizedBox(height:30),
                SizedBox(
                  height: 60,
                  width: 500,
                  child:ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape:  RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          backgroundColor: Colors.blue[600]),
                      child: Text('Send Reset Link'),
                      onPressed: () async {
                        await _auth.sendPasswordResetEmail(email: email);
                        Navigator.pushNamed(context, '/loginScreen');
                      }
                  ),
                ),
                SizedBox(height: 20,),
                Text('The app will automatically navigate to the login screen after it sends the password reset link to your email, that is provided you have a registered account,'),
              ],),
            ),
          ),
          ),
        ],
      ),
    );
  }
}
