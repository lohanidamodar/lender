import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';
import 'package:lender/ui/widgets/outline_button_widget.dart';
import 'package:lender/ui/widgets/raised_button_widget.dart';
import 'package:lender/ui/widgets/text_field_widget.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return new _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _formData = {
    "email":"",
    "password":""
  };
  bool _inProgress = false;

  _showErrorDialog({String message = "Both username and password fields are required."}) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error logging in"),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text("Ok"),
              onPressed: (){
                Navigator.pop(context);
              },
            )
          ],
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(40.0),
          child: Column(
            children: <Widget>[
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 30,),
                    Text("Lender".toUpperCase(), style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 40.0
                      ),
                      textAlign: TextAlign.center,
                    ),
                    StreamBuilder(
                      stream: AuthBlocProvider.of(context).showProgress,
                      builder: (BuildContext context, AsyncSnapshot<bool> snapshot){
                        if(snapshot.hasData && snapshot.data) {
                          return CircularProgressIndicator();
                        }else{
                          return SizedBox(height: 20.0,);
                        }
                      },
                    ),
                    SizedBox(height: 10,),
                    _buildGoogleLogin(),
                    SizedBox(height: 30,),
                    SizedBox(width: double.infinity, child: Text("Or use your email address", textAlign: TextAlign.left,)),
                    SizedBox(height: 10,),
                    PBTextField(
                      leadingIcon: Icons.alternate_email,
                      hintText: "Email",
                      onSaved: (value)=>_formData["email"]=value,
                    ),
                    SizedBox(height: 10.0,),
                    PBTextField(
                      leadingIcon: Icons.vpn_key,
                      hintText: "Password",
                      onSaved: (value)=>_formData["password"]=value,
                      obscureText: true,              ),
                    SizedBox(height: 5.0,),
                    Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: (){},
                        child: Text("Forgot password?", textAlign: TextAlign.right, style: TextStyle(
                          color: Colors.black54
                        ),),
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    SizedBox(
                      width: double.infinity,
                      child: PBRaisedButton(
                        child: Text("Log in".toUpperCase()),
                        onPressed: _inProgress ? null : () => _handleLogin(context),
                      ),
                    ),
                    
                    SizedBox(height: 40.0,),
                    Text("Don't have an account?"),
                    SizedBox(height: 10.0,),
                    SizedBox(
                      width: double.infinity,
                      child: PBOutlineButton(
                        child: Text("Sign up".toUpperCase(), style: TextStyle(
                          fontWeight: FontWeight.bold
                        )),
                        onPressed: ()=>Navigator.pushNamed(context, 'signup'),),
                    )

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleLogin() {
    return Container(
      width: double.infinity,
      child: PBRaisedButton(
        child: Text(" Continue with Google"),
        onPressed: _inProgress ? null : () => _handleSocialLogin('google'),
      ),
    );
  }

  _handleLogin(BuildContext context) async {
      AuthBlocProvider.of(context).changeShowProgress(true);
      AuthBlocProvider.of(context).userStream.listen((FirebaseUser user){

      },onError: (error){
        _showErrorDialog(message: error.toString());
      });
      _formKey.currentState.save();
      if(_formData['email'].isEmpty || _formData['password'].isEmpty){
        _showErrorDialog();
      }else{
        await AuthBlocProvider.of(context).signinWithEmailPassword(_formData['email'], _formData['password']);
      }
      AuthBlocProvider.of(context).changeShowProgress(false);
  }

  _handleSocialLogin(String provider) async {
    AuthBlocProvider.of(context).changeShowProgress(true);
    try {
      await AuthBlocProvider.of(context).signInWithGoogle();
    }catch(error){
      print(error);
    }
    AuthBlocProvider.of(context).changeShowProgress(false);
  }

}