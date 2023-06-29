import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/config/api_config.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(BuildContext context) async {
    final url = '${APIConfig.baseUrl}/login';
    final response = await http.post(Uri.parse(url), body: {
      'email': _emailController.text,
      'password': _passwordController.text,
    });

    if (response.statusCode == 200) {
      // Login successful, save user session and navigate to the dashboard screen
      final token = response.body; // Assuming the API returns a token
      // Save the token to shared preferences for future use
      // ...
      Navigator.pushNamed(context, '/dashboard');
    } else {
      // Handle login error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Error'),
            content: Text('Failed to login. Please try again.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
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
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                login(context);
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

