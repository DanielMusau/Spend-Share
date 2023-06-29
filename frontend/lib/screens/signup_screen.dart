import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignupScreen extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();  
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Your Name'),
            ),
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
                signup(context);
              },
              child: Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }

  void signup(BuildContext context) async {
    final name = _nameController.text;
    final email = _emailController.text;
    final password = _passwordController.text;

    final url = 'http://localhost:4000/api/users';
    final response = await http.post(Uri.parse(url), body: {
      'name': name,
      'email': email,
      'password': password,
    });

    if (response.statusCode == 201) {
      // Signup successful, display a success message or navigate to another screen
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Success'),
          content: Text('Signup successful!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/login');
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else {
      // Signup failed, display an error message
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Signup failed. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
