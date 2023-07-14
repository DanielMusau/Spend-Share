import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<List<Map<String, dynamic>>> fetchExpenses() async {
    try {
      const url = '/expenses';

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

      Response response = await getHttpClient().get(url);
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.toString());
        final List<dynamic> expenseData = jsonData['data'];

        final expenses = expenseData.cast<Map<String, dynamic>>();
        return expenses;
      } else {
        return [];
        // showDialog(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: const Text('Error'),
        //     content: const Text('Failed to fetch expenses. Please try again.'),
        //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
      }
    } catch (error) {
      return [];
      // showDialog(
      //   context: context,
      //   builder: (_) => AlertDialog(
      //     title: const Text('Error'),
      //     content: Text('An error occurred: $error'),
      //     actions: [
        //       TextButton(
        //         onPressed: () {
        //           Navigator.pop(context);
        //         },
        //         child: const Text('OK'),
        //       ),
        //     ],
        //   ),
        // );
    }
  }

  Future<String> getUser(String userId) async {
  final url = '/users/$userId';

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

  Response response = await getHttpClient().get(url);
  if (response.statusCode == 200) {
    final jsonData = json.decode(response.toString());
    final name = jsonData['name'];
    return name;
  } else {
    return 'Unknown User';
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Expenses:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchExpenses(),
              initialData: const [],
              builder: (context, snapshot) {
                final expenses = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      final amount = expense['amount'];
                      final name = expense['name'];
                      final userId = expense['user_id'];
                      final user = userId.toString();


                      return ListTile(
                        title: Text(name),
                        subtitle: Text(
                            'You owe ${getUser(user)} this $amount of money'),
                      );
                    },
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the create_group_screen
                  Navigator.pushNamed(context, '/create-group');
                },
                child: const Text('Create Group'),
              ),
        ],
      ),
    );
  }
}