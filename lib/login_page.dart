import 'package:flutter/material.dart';

import 'auth.dart';

class LoginPage extends StatefulWidget {
  
   LoginPage({this.auth,this.onSignIn});
  final BaseAuth auth;
  final VoidCallback onSignIn;
  
  
  @override
  _LoginPageState createState() => _LoginPageState();
}

enum FormType {
  login,
  register,
}
final formKey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  String _email;
  String _password;
  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Login Demo"),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInput() + buildSubmitButtons()),
        ),
      ),
    );
  }

  List<Widget> buildInput() {
    return [
      TextFormField(
        onSaved: (value) => _email = value,
        validator: (value) => value.isEmpty ? "Email Can't be Empty" : null,
        decoration: InputDecoration(labelText: 'Email'),
      ),
      TextFormField(
        onSaved: (value) => _password = value,
        validator: (value) => value.isEmpty ? "Password Can't be Empty" : null,
        decoration: InputDecoration(labelText: 'Password'),
      ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text('Login',style: TextStyle(fontSize: 20.0),
          ),
        ),
        FlatButton(
          onPressed: moveToRegister,
          child: Text( "Create an Account",style: TextStyle(fontSize: 14.0,
            ),
          ),
        )
      ];
    } else {
      return [
        RaisedButton(
          onPressed: validateAndSubmit,
          child: Text(
            'Create an account',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
        FlatButton(
          onPressed: moveToLogin,
          child: Text( "Have an Account? Login",style: TextStyle(fontSize: 14.0,
            ),
          ),
        )
      ];
    }
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        if(_formType == FormType.login){
          String userId =await widget.auth.signInWithEmailAndPassword(_email, _password);
        // FirebaseUser user = await FirebaseAuth.instance
        //     .signInWithEmailAndPassword(email: _email, password: _password);
        print('SignIn: $userId');
        }
        else{
          String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          // FirebaseUser user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email,password: _password);
        print('Registed User: $userId');
        }
        widget.onSignIn();
      } catch (e) {
        print("Error: $e");
      }
    }
  }

  void moveToRegister() {
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });
  }

  void moveToLogin() {
    setState(() {
      _formType = FormType.login;
    });
  }
}
