import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../models/expense.dart';

class ExpenseChart extends StatelessWidget {
  final List<Expense> expenses;

  ExpenseChart({required this.expenses});

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Expenses by Category'),
      legend: Legend(isVisible: true),
      series: <CircularSeries>[
        PieSeries<Expense, String>(
          dataSource: expenses,
          xValueMapper: (Expense data, _) => data.title,
          yValueMapper: (Expense data, _) => data.amount,
          dataLabelSettings: DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
