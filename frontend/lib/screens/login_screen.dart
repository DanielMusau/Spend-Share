import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginScreen() {
    // Initialize the text controllers
    _emailController.text = '';
    _passwordController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
                // Get the user from the database
                final email = _emailController.text;
                final password = _passwordController.text;
                const url = '/login';

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
                    'user': {
                      'email': email,
                      'password': password,
                    },
                  },
                );

                // Check the response status code
                if (response.statusCode == 200) {
                  // Login successful
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Login successful!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, '/dashboard');
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else {
                  // Login failed
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Login failed. Please try again.'),
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
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
