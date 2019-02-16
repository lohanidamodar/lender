import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lender/blocs/auth_bloc_provider.dart';
import 'package:lender/ui/pages/add.dart';
import 'package:lender/ui/pages/home.dart';
import 'package:lender/ui/pages/login.dart';

void main() => runApp(Lender());

class Lender extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthBlocProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Lender',
        theme: ThemeData(
          primarySwatch: Colors.pink,
              buttonTheme: ButtonThemeData(
                textTheme: ButtonTextTheme.primary,
                buttonColor: Colors.pink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))
              ),
              fontFamily: "Raleway",
        ),
        home: MainScreen(),
        routes: {
          'add': (_)=> AddPage(),
          'login': (_) => LoginPage()
        },
      ),
    );
  }
}



class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() {
    return _MainScreenState();
  }
}

class _MainScreenState extends State<MainScreen> {
  AuthBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = AuthBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _handleCurrentScreen();
  }

  Widget _handleCurrentScreen() {
    return StreamBuilder(
      stream: _bloc.userStream,
      builder: (BuildContext context, AsyncSnapshot<FirebaseUser> snapshot) {
        if (snapshot.hasData) {
          FirebaseUser user = snapshot.data;
          return user != null ? HomePage() : LoginPage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}