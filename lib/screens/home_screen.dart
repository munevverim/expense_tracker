import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_chart.dart';
import 'add_expense_dialog.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final expenseProvider = Provider.of<ExpenseProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Expense Tracker')),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: expenseProvider.loadExpenses(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (expenseProvider.expenses.isEmpty) {
                  return Center(child: Text('No expenses added yet.'));
                } else {
                  return ListView.builder(
                    itemCount: expenseProvider.expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenseProvider.expenses[index];
                      return ListTile(
                        title: Text(expense.title),
                        subtitle: Text('\$${expense.amount.toStringAsFixed(2)} - ${expense.date.toLocal().toString().split(' ')[0]}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            expenseProvider.deleteExpense(expense.id!);
                          },
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AddExpenseDialog();
                  },
                );
              },
              child: Text('Add Expense'),
            ),
          ),
          // Grafik gösterimi
          Expanded(
            child: ExpenseChart(expenses: expenseProvider.expenses),
          ),
        ],
      ),
    );
  }
}
