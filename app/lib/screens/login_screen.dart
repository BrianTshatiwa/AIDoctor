import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  String errorText = '';
  String  email = '';
  String password = '';

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
                'Hello, Welcome back to AIDoctor!',
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
                TextField( onChanged: (value){
                  password = value;
                },
                  obscuringCharacter: '*',
                  obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Password', style: TextStyle(
                      color: Colors.blue[600],
                    ),)
                  ),
                ),
                SizedBox(height: 40,),
                SizedBox(
                  height: 60,
                  width: 500,
                    child:ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    backgroundColor: Colors.blue[600]),
                  child: Text('Login'),
                  onPressed: () async {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if (user != null){
                        Navigator.pushNamed(context, '/homeScreen');
                      }
                    }
                    catch(e){
                      Text("error: $e");
                    }
                  }
                  ),
                ),
                TextButton(
                  onPressed: (){
                    Navigator.pushNamed(context, '/forgotPasswordScreen');
                  },
                  child: Text('Forgot Password? Click here'),
                ),
                SizedBox(height: 20,),
                Text(errorText),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 50,),
                    Text("Don't have an account?"),
                    TextButton(
                      child: Text('Sign Up'),
                      onPressed: () {
                        Navigator.pushNamed(context, '/registrationScreen');
                      }
                    )
                  ],
                ),
                SizedBox(height: 100,),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Text('2023 \u00a9 Kutlwano Tshatiwa'),
                ),
                ],),
            ),
            ),
          ),
        ],
      ),
    );
  }
}