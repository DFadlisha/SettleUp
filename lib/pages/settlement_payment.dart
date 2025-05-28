import 'package:flutter/material.dart';

import 'home.dart';

class SettlementPaymentPage extends StatefulWidget {
  const SettlementPaymentPage({super.key});

  @override
  SettlementPaymentPageState createState() => SettlementPaymentPageState();
}
class SettlementPaymentPageState extends State<SettlementPaymentPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  List<PaymentTransaction> transactions = [
    PaymentTransaction(
      id: "TXN001",
      from: "Sarah Wilson",
      to: "John Doe",
      amount: 40.25,
      reason: "Groceries settlement",
      date: DateTime.now().subtract(Duration(hours: 2)),
      status: PaymentStatus.completed,
      method: "Bank Transfer",
    ),
    PaymentTransaction(
      id: "TXN002",
      from: "Mike Chen",
      to: "Sarah Wilson",
      amount: 600.00,
      reason: "Rent payment",
      date: DateTime.now().subtract(Duration(days: 1)),
      status: PaymentStatus.pending,
      method: "Cash",
    ),
    PaymentTransaction(
      id: "TXN003",
      from: "John Doe",
      to: "Mike Chen",
      amount: 42.88,
      reason: "Dinner settlement",
      date: DateTime.now().subtract(Duration(days: 2)),
      status: PaymentStatus.failed,
      method: "Digital Wallet",
    ),
    PaymentTransaction(
      id: "TXN004",
      from: "Sarah Wilson",
      to: "Mike Chen",
      amount: 42.88,
      reason: "Dinner settlement",
      date: DateTime.now().subtract(Duration(days: 3)),
      status: PaymentStatus.completed,
      method: "Bank Transfer",
    ),
  ];

  List<SettlementSuggestion> suggestions = [
    SettlementSuggestion(
      from: "John Doe",
      to: "Sarah Wilson",
      amount: 559.75,
      reason: "Net settlement (Rent - Groceries)",
      priority: SettlementPriority.high,
    ),
    SettlementSuggestion(
      from: "Mike Chen",
      to: "John Doe",
      amount: 40.25,
      reason: "Groceries settlement",
      priority: SettlementPriority.medium,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final completedTransactions = transactions.where((t) => t.status == PaymentStatus.completed).toList();
    final pendingTransactions = transactions.where((t) => t.status == PaymentStatus.pending).toList();
    final totalSettled = completedTransactions.fold(0.0, (sum, t) => sum + t.amount);

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9F43),
        elevation: 0,
        title: Text(
          'Settlements',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
  icon: Icon(Icons.arrow_back, color: Colors.black),
  onPressed: () {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomePage()), // Use your actual home page widget
      (Route<dynamic> route) => false,
    );
  },
),

        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.black54,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Suggestions'),
            Tab(text: 'Transactions'),
            Tab(text: 'History'),
          ],
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildSummaryCard(
                  "Total Settled",
                  "\$${totalSettled.toStringAsFixed(2)}",
                  Colors.white,
                  Colors.green[600]!,
                  Icons.check_circle,
                ),
                _buildSummaryCard(
                  "Pending",
                  "${pendingTransactions.length}",
                  Colors.white,
                  Colors.orange[600]!,
                  Icons.schedule,
                ),
                _buildSummaryCard(
                  "This Month",
                  "${completedTransactions.length}",
                  Colors.white,
                  Colors.blue[600]!,
                  Icons.trending_up,
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Suggestions tab
                _buildSuggestionsTab(),
                // Transactions tab
                _buildTransactionsTab(transactions),
                // History tab
                _buildTransactionsTab(completedTransactions),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFF9F43),
        child: Icon(Icons.payment, color: Colors.white),
        onPressed: () => _showRecordPaymentDialog(),
      ),
    );
  }

  Widget _buildSummaryCard(String title, String value, Color bgColor, Color textColor, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Icon(icon, color: textColor, size: 20),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 10,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSuggestionsTab() {
    return Container(
      margin: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Smart Settlement Suggestions',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListView.builder(
                padding: EdgeInsets.all(16),
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 16),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(suggestion.priority).withAlpha((0.1 * 255).toInt()),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getPriorityColor(suggestion.priority).withAlpha((0.3 * 255).toInt()),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getPriorityColor(suggestion.priority),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                suggestion.priority.toString().split('.').last.toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Spacer(),
                            Text(
                              '\$${suggestion.amount.toStringAsFixed(2)}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          '${suggestion.from} → ${suggestion.to}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          suggestion.reason,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _recordSettlement(suggestion),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Color(0xFFFF9F43),
                                ),
                                child: Text('Record Payment'),
                              ),
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => _sendReminder(suggestion),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFF9F43),
                                ),
                                child: Text('Send Reminder'),
                              ),
                            ),
                          ],
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
    );
  }

  Widget _buildTransactionsTab(List<PaymentTransaction> transactionList) {
    if (transactionList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.receipt_long,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              'No transactions found',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: transactionList.length,
        itemBuilder: (context, index) {
          final transaction = transactionList[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Color(0xFFE9ECEF)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: _getStatusColor(transaction.status),
                  radius: 20,
                  child: Icon(
                    _getStatusIcon(transaction.status),
                    color: Colors.white,
                    size: 16,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${transaction.from} → ${transaction.to}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        transaction.reason,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            transaction.method,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                          Text(
                            ' • ${_formatDateTime(transaction.date)}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${transaction.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: _getStatusColor(transaction.status).withAlpha((0.1 * 255).toInt()),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        transaction.status.toString().split('.').last,
                        style: TextStyle(
                          color: _getStatusColor(transaction.status),
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Color _getPriorityColor(SettlementPriority priority) {
    switch (priority) {
      case SettlementPriority.high:
        return Colors.red;
      case SettlementPriority.medium:
        return Colors.orange;
      case SettlementPriority.low:
        return Colors.blue;
    }
  }

  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return Colors.green;
      case PaymentStatus.pending:
        return Colors.orange;
      case PaymentStatus.failed:
        return Colors.red;
    }
  }

  IconData _getStatusIcon(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.completed:
        return Icons.check;
      case PaymentStatus.pending:
        return Icons.schedule;
      case PaymentStatus.failed:
        return Icons.error;
    }
  }

  String _formatDateTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }

  void _recordSettlement(SettlementSuggestion suggestion) {
    setState(() {
      transactions.insert(0, PaymentTransaction(
        id: "TXN${DateTime.now().millisecondsSinceEpoch}",
        from: suggestion.from,
        to: suggestion.to,
        amount: suggestion.amount,
        reason: suggestion.reason,
        date: DateTime.now(),
        status: PaymentStatus.completed,
        method: "Manual Entry",
      ));
      suggestions.remove(suggestion);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Settlement recorded successfully'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _sendReminder(SettlementSuggestion suggestion) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reminder sent to ${suggestion.from}'),
        backgroundColor: Color(0xFFFF9F43),
      ),
    );
  }

  void _showRecordPaymentDialog() {
    final TextEditingController amountController = TextEditingController();
    String selectedFrom = "John Doe";
    String selectedTo = "Sarah Wilson";
    String selectedMethod = "Bank Transfer";
    
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: Text('Record Payment'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: selectedFrom,
                decoration: InputDecoration(labelText: 'From'),
                items: ["John Doe", "Sarah Wilson", "Mike Chen"]
                    .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                    .toList(),
                onChanged: (value) => setState(() => selectedFrom = value!),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedTo,
                decoration: InputDecoration(labelText: 'To'),
                items: ["John Doe", "Sarah Wilson", "Mike Chen"]
                    .map((name) => DropdownMenuItem(value: name, child: Text(name)))
                    .toList(),
                onChanged: (value) => setState(() => selectedTo = value!),
              ),
              SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  prefixText: '\$',
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedMethod,
                decoration: InputDecoration(labelText: 'Payment Method'),
                items: ["Bank Transfer", "Cash", "Digital Wallet"]
                    .map((method) => DropdownMenuItem(value: method, child: Text(method)))
                    .toList(),
                onChanged: (value) => setState(() => selectedMethod = value!),
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
                if (amountController.text.isNotEmpty && selectedFrom != selectedTo) {
                  this.setState(() {
                    transactions.insert(0, PaymentTransaction(
                      id: "TXN${DateTime.now().millisecondsSinceEpoch}",
                      from: selectedFrom,
                      to: selectedTo,
                      amount: double.parse(amountController.text),
                      reason: "Manual settlement",
                      date: DateTime.now(),
                      status: PaymentStatus.completed,
                      method: selectedMethod,
                    ));
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFF9F43),
              ),
              child: Text('Record'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class PaymentTransaction {
  final String id;
  final String from;
  final String to;
  final double amount;
  final String reason;
  final DateTime date;
  final PaymentStatus status;
  final String method;

  PaymentTransaction({
    required this.id,
    required this.from,
    required this.to,
    required this.amount,
    required this.reason,
    required this.date,
    required this.status,
    required this.method,
  });
}

class SettlementSuggestion {
  final String from;
  final String to;
  final double amount;
  final String reason;
  final SettlementPriority priority;

  SettlementSuggestion({
    required this.from,
    required this.to,
    required this.amount,
    required this.reason,
    required this.priority,
  });
}

enum PaymentStatus { completed, pending, failed }
enum SettlementPriority { high, medium, low }