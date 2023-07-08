import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreateGroupScreen extends StatelessWidget {
  final TextEditingController _groupNameController = TextEditingController();

  CreateGroupScreen({super.key});

  void createGroup(BuildContext context) async {
    final String groupName = _groupNameController.text;

    // Prepare the request body
    Map<String, dynamic> requestBody = {
      'name': groupName,
    };

    // Send a POST request to create a new group
    try {
      const url = 'http://localhost:4000/api/groups';
      final response = await http.post(
        Uri.parse(url),
        body: requestBody,
      );

      if (response.statusCode == 200) {
        // Group created successfully, show a success message
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Group Created'),
              content: const Text('The group has been created successfully.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        // Show an error message if the request fails
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Failed to create the group. Please try again.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Handle any exceptions that occur during the request
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('An error occurred. Please try again later.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
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
        title: const Text('Create Group'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: const InputDecoration(labelText: 'Group Name'),
            ),
            ElevatedButton(
              onPressed: () {
                createGroup(context);
              },
              child: const Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
