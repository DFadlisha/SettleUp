import 'package:flutter/material.dart';

import 'home.dart';

class SplitCalculationPage extends StatefulWidget {
  const SplitCalculationPage({super.key});

  @override
  SplitCalculationPageState createState() => SplitCalculationPageState();
}

class SplitCalculationPageState extends State<SplitCalculationPage> {
  List<ExpenseSplit> expenses = [
    ExpenseSplit(
      title: "Groceries",
      amount: 120.50,
      paidBy: "John Doe",
      splitBetween: ["John Doe", "Sarah Wilson", "Mike Chen"],
      date: DateTime.now().subtract(Duration(days: 1)),
      category: "Food",
      icon: Icons.shopping_cart,
      color: Color(0xFFFF9F43),
    ),
    ExpenseSplit(
      title: "Rent",
      amount: 1800.00,
      paidBy: "Sarah Wilson",
      splitBetween: ["John Doe", "Sarah Wilson", "Mike Chen"],
      date: DateTime.now().subtract(Duration(days: 3)),
      category: "Housing",
      icon: Icons.home,
      color: Color(0xFF8B4513),
    ),
    ExpenseSplit(
      title: "Dinner Out",
      amount: 85.75,
      paidBy: "Mike Chen",
      splitBetween: ["John Doe", "Sarah Wilson"],
      date: DateTime.now().subtract(Duration(days: 2)),
      category: "Food",
      icon: Icons.restaurant,
      color: Color(0xFFE91E63),
    ),
  ];

  String selectedSplitMethod = "Equal";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9F43),
        elevation: 0,
        title: Text(
          'Split Calculator',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
  icon: const Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
      (route) => false,
    );
  },
),
      ),
      body: Column(
        children: [
          // Header section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFF9F43),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Expenses',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${_getTotalAmount().toStringAsFixed(2)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16),
                // Split method selector
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedSplitMethod,
                      dropdownColor: Colors.white,
                      items:
                          ["Equal", "Percentage", "Custom"]
                              .map(
                                (method) => DropdownMenuItem(
                                  value: method,
                                  child: Text(
                                    method,
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              )
                              .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedSplitMethod = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Expenses list
          Expanded(
            child: Container(
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  final splitAmount =
                      expense.amount / expense.splitBetween.length;

                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Color(0xFFE9ECEF)),
                    ),
                    child: ExpansionTile(
                      leading: CircleAvatar(
                        backgroundColor: expense.color,
                        child: Icon(expense.icon, color: Colors.white),
                      ),
                      title: Text(
                        expense.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paid by ${expense.paidBy}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '\$${expense.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Split Details:',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(height: 8),
                              ...expense.splitBetween.map(
                                (person) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        person,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                      Text(
                                        '\$${splitAmount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              person == expense.paidBy
                                                  ? Colors.green[600]
                                                  : Colors.red[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Split between ${expense.splitBetween.length} people',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  Text(
                                    _formatDate(expense.date),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF9F43),
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _showAddExpenseDialog(),
      ),
    );
  }

  double _getTotalAmount() {
    return expenses.fold(0.0, (sum, expense) => sum + expense.amount);
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _showAddExpenseDialog() {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController amountController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Add New Expense'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Expense Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    border: OutlineInputBorder(),
                    prefixText: '\$',
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (titleController.text.isNotEmpty &&
                      amountController.text.isNotEmpty) {
                    setState(() {
                      expenses.add(
                        ExpenseSplit(
                          title: titleController.text,
                          amount: double.parse(amountController.text),
                          paidBy: "John Doe", // Default payer
                          splitBetween: [
                            "John Doe",
                            "Sarah Wilson",
                            "Mike Chen",
                          ],
                          date: DateTime.now(),
                          category: "Other",
                          icon: Icons.receipt,
                          color: Color(0xFFFF9F43),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFFF9F43),
                ),
                child: Text('Add'),
              ),
            ],
          ),
    );
  }
}

class ExpenseSplit {
  final String title;
  final double amount;
  final String paidBy;
  final List<String> splitBetween;
  final DateTime date;
  final String category;
  final IconData icon;
  final Color color;

  ExpenseSplit({
    required this.title,
    required this.amount,
    required this.paidBy,
    required this.splitBetween,
    required this.date,
    required this.category,
    required this.icon,
    required this.color,
  });
}
