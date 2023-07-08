import 'package:flutter/material.dart';

class CreateExpenseScreen extends StatelessWidget {
  final TextEditingController _expenseNameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  CreateExpenseScreen({super.key});

  void createExpense(BuildContext context) {
    // Implement the logic to create a new expense here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _expenseNameController,
              decoration: const InputDecoration(labelText: 'Expense Name'),
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            ElevatedButton(
              onPressed: () {
                createExpense(context);
              },
              child: const Text('Create Expense'),
            ),
          ],
        ),
      ),
    );
  }
}
