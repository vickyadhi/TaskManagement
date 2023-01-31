import 'package:clockify_clone/google_login/AuthService.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';



class GoogleSignin extends StatefulWidget {
  const GoogleSignin({Key? key}) : super(key: key);

  @override
  State<GoogleSignin> createState() => _GoogleSigninState();
}

class _GoogleSigninState extends State<GoogleSignin> {
  bool otpVisibility = false;
  final _phoneController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();
  final GoogleSignin _googleSignIn = GoogleSignin();


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        padding: EdgeInsets.all(32),
    child: Form(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Image.asset("assets/images/welcome.png")
          ],
        ),


        TextFormField(
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide(color: Colors.grey)
              ),
              filled: true,
              fillColor: Colors.grey[100],
              hintText: "Phone Number"

          ),
          controller: _phoneController,
        ),
        SizedBox(height: 160,),
        ElevatedButton(
          onPressed: () {
            if (otpVisibility) {
              AuthService().verifyOTP(context);
            } else {
              AuthService().loginWithPhone();
            }
          },
          child: const Center(
            child: Text('Get Otp'),
          ),
        ),


        SizedBox(height: 16,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
        Image(image: AssetImage('assets/images/or.png'))
          ],
        ),

      ],
    )
    )
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 50,
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          onPressed: () => AuthService().googleSignIn(context),
          child: const Center(
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }
}
