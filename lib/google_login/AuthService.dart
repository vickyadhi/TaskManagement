import 'package:clockify_clone/DashBoardScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  late String verificationId;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool otpVisibility = false;
  User? user;
  String verificationID = "";
  final phoneNumber = TextEditingController();
  final otpController = TextEditingController();
  late String otp, authStatus = "";

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password,
      BuildContext context) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message.toString())));
    } catch (e) {
      print(e);
    }
  }

  googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication gAuth = await gUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );
    UserCredential userCredential = await
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DashBoardScreen()));
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }



  signOut() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }



  void loginWithPhone() async {
    _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneNumber.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await _auth.signInWithCredential(credential).then((value) {
          print("Logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
  void verifyOTP(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID, smsCode: otpController.text);

    await auth.signInWithCredential(credential).then(
          (value) {
            user = FirebaseAuth.instance.currentUser;
      },
    ).whenComplete(
          () {
        if (user != null) {
          Fluttertoast.showToast(
            msg: "Logged in successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 16.0,
          );
          Navigator.pushReplacement(context,
            MaterialPageRoute(
              builder: (context) =>  DashBoardScreen(),
            ),
          );
        } else {
          Fluttertoast.showToast(
            msg: "Failed to logged in",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      },
    );
  }
}

