import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class CreateGroupScreen extends StatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  _CreateGroupScreenState createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  final TextEditingController _nameController = TextEditingController();

  CreateGroupScreen() {
    // Initialize the text controllers
    _nameController.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Get the user from the database
                final name = _nameController.text;
                const url = '/groups';

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
                  },
                );

                // Check the response status code
                if (response.statusCode == 201) {
                  // Group Creation successful
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text('Success'),
                      content: const Text('Group Created successfully!'),
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
                      content: const Text('Group Creation failed. Please try again.'),
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
