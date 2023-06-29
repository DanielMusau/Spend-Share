import 'package:flutter/material.dart';

class CreateGroupScreen extends StatelessWidget {
  final TextEditingController _groupNameController = TextEditingController();

  void createGroup(BuildContext context) {
    // Implement the logic to create a new group here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Group'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _groupNameController,
              decoration: InputDecoration(labelText: 'Group Name'),
            ),
            ElevatedButton(
              onPressed: () {
                createGroup(context);
              },
              child: Text('Create Group'),
            ),
          ],
        ),
      ),
    );
  }
}
