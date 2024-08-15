import 'package:flutter/material.dart';
import '../db/db_helper.dart';
import '../models/expense.dart';

class ExpenseProvider with ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  Future<void> addExpense(Expense expense) async {
    await DBHelper().insertExpense(expense);
    await loadExpenses();
  }

  Future<void> loadExpenses() async {
    _expenses = await DBHelper().getExpenses();
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await DBHelper().deleteExpense(id);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await DBHelper().updateExpense(expense);
    await loadExpenses();
  }
}
