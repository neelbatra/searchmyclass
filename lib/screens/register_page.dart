import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:search_my_class/constants.dart';
import 'package:search_my_class/screens/home_page.dart';
import 'package:search_my_class/screens/login_page.dart';
import 'package:search_my_class/widgets/custom_btn.dart';
import 'package:search_my_class/widgets/custom_input.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //build an alert dialog to show some error
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Error"),
          content: Container(
            child: Text(error),
          ),
          actions: [
            FlatButton(
              child: Text("Close Dialog"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  //create a new user account
  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to the loading state
    setState(() {
      _registerFormLoading = true;
    });
    //run the create account method
    String _createAccountFeedback = await _createAccount();
    //if the string is not null , we got an error while crete account
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      //set the form to the regular state(not loading)
      setState(() {
        _registerFormLoading = false;
      });
    } else {
      //the string was nulll , user is logged in and sent to homepage.
      Navigator.pop(context);
    }
  }

  // default form adding state
  bool _registerFormLoading = false;

  //form input field values
  String _registerEmail = "";
  String _registerPassword = "";

  //focus node for the input
  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 40.0,
                ),

                child: Text(" SEARCH MY CLASS ", style: Constants.boldHeading),
                decoration: BoxDecoration(

                    color: Color(0xFF69B6DE),
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(color: Colors.black, width: 2.0)
                ),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "\t Your E-Mail...",
                    onChanged: (value) {
                      _registerEmail = value;
                    },
                    onSubmitted: (value) {
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: "\t Your Password...",
                    onChanged: (value) {
                      _registerPassword = value;
                    },
                    focusNode: _passwordFocusNode,
                    isPasswordField: true,
                    onSubmitted: (value) {
                      _submitForm();
                    },
                  ),
                  CustomBtn(
                    text: "CREATE NEW ACCOUNT",
                    onPressed: () {
                      _submitForm();
                      //open the alert dialog
                      //_alertDialogBuilder();
                      /*setState(() {
                        _registerformlaoding = true;
                      });*/
                      print("Clicked on the create new account button");
                    },
                    isLoading: _registerFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: "BACK TO LOGIN",
                  onPressed: () {
                    print("navigation button to login page");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  outlineBtn: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
