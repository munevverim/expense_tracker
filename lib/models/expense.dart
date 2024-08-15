import 'package:flutter/material.dart';

class Expense {
  final int? id;
  final String title;
  final double amount;
  final DateTime date;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.date,
  });

  // Harcamayı Map yapısına dönüştür (SQLite için gerekli)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'amount': amount,
      'date': date.toIso8601String(),
    };
  }

  // Map yapısını Expense modeline dönüştür
  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      title: map['title'],
      amount: map['amount'],
      date: DateTime.parse(map['date']),
    );
  }
}
