import 'package:flutter/material.dart';

class CreateExpenseScreen extends StatelessWidget {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void createExpense(BuildContext context) {
    // Implement the logic to create a new expense here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Expense'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _expenseNameController,
              decoration: InputDecoration(labelText: 'Expense Name'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                createExpense(context);
              },
              child: Text('Create Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
