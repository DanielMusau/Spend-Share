import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  signupScreen() {
    // Initialize the text controllers
    _nameController.text = '';
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Your Name'),
            ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () async {
                // Signup the user
                final name = _nameController.text;
                final email = _emailController.text;
                final password = _passwordController.text;
                const url = '/users';

                Dio getHttpClient() {
                  final dio = Dio(
                    BaseOptions(
                      baseUrl: 'https://expensesharingapp-production.up.railway.app/api',
                      contentType: 'application/json',
                      connectTimeout: const Duration(seconds: 60),
                      receiveTimeout: const Duration(seconds: 60),
                      headers: <String, dynamic>{
                        'Accept': 'application/json',
                      },
                    ),
                  );

                  dio.interceptors.add(
                    InterceptorsWrapper(
                      onRequest: (options, handler) {
                        return handler.next(options);
                      },
                    ),
                  );
                  return dio;
                }

                Response response = await getHttpClient().post(
                  url,
                  data: {
                    'name': name,
                    'email': email,
                    'password': password,
                  },
                );
                if (response.statusCode == 201) {
                  // Signup successful, display a success message or navigate to another screen
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Signup successful!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Signup failed, display an error message
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Signup failed. Please try again.'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Signup'),
            ),
          ],
        ),
      ),
    );
  }
}
