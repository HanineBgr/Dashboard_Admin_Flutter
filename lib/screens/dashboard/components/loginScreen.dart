import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:admin/screens/main/main_screen.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
    final String username = usernameController.text;
    final String password = passwordController.text;

    final Uri loginUri = Uri.parse('http://localhost:5000/api/user/loginadmin');

    try {
      final response = await http.post(
        loginUri,
        body: json.encode({
          'username': username,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

        if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        print('Admin login successful: $responseData');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>MainScreen()),
    );
  
      } else {
        print('Admin login failed with status code: ${response.statusCode}');
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Login Error'),
              content: Text('Admin login failed. Please check your credentials.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error occurred: $error');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Error occurred: $error'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Login'),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Card(
            elevation: 8,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  LoginInputField(
                    labelText: 'Admin name',
                    placeholder: 'Enter your name',
                    controller: usernameController,
                  ),
                  LoginInputField(
                    labelText: 'Password',
                    placeholder: 'Enter your password',
                    isPassword: true,
                    controller: passwordController,
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        loginUser(context);
                      },
                      child: Text('Login'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LoginInputField extends StatelessWidget {
  final String labelText;
  final String placeholder;
  final bool isPassword;
  final TextEditingController? controller;

  const LoginInputField({
    required this.labelText,
    required this.placeholder,
    this.isPassword = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: placeholder,
          border: OutlineInputBorder(),
        ),
        obscureText: isPassword,
      ),
    );
  }
}
