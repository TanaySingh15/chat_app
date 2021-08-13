import 'dart:io';

import 'package:chat_app/pickers/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this._isLoading);
  final void Function(String email, String password, String username,
      bool isLogin, File image) submitFn;
  bool _isLoading;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  //var _isLogin = true;
  String _userEmail = '';
  String _userName = '';
  String _userPassword = '';
  bool _isLogin = true;
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus(); //closes the keyboard

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an Image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      // Send Data to firebase
      widget.submitFn(
          _userEmail, _userPassword, _userName, _isLogin, _userImageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    validator: (value) {
                      if (value.isEmpty && !value.contains('@'))
                        return "Please Enter a valid email";
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('Username'),
                      validator: (value) {
                        if (value.isEmpty && value.length < 4)
                          return "Please Enter a valid email";
                        return null;
                      },
                      decoration: InputDecoration(
                        labelText: 'Username',
                      ),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('Password'),
                    validator: (value) {
                      if (value.isEmpty && value.length < 7)
                        return "Please Enter a valid password";
                      return null;
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    RaisedButton(
                      onPressed: _trySubmit,
                      child: Text(_isLogin ? "Login" : 'SignUp'),
                    ),
                  SizedBox(
                    height: 12,
                  ),
                  if (widget._isLoading) CircularProgressIndicator(),
                  if (!widget._isLoading)
                    FlatButton(
                      textColor: Theme.of(context).accentColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                      child: Text(_isLogin
                          ? "Create New Account"
                          : 'I already Have an account'),
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
