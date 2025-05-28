import 'package:flutter/material.dart';

import 'home.dart';

class WhoOwesPage extends StatefulWidget {
  const WhoOwesPage({super.key});

  @override
  WhoOwesPageState createState() => WhoOwesPageState();
}

class WhoOwesPageState extends State<WhoOwesPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  
  List<OwesData> owesData = [
    OwesData(
      person: "Sarah Wilson",
      owesTo: "John Doe",
      amount: 40.25,
      reason: "Groceries split",
      date: DateTime.now().subtract(Duration(days: 1)),
      isSettled: false,
    ),
    OwesData(
      person: "Mike Chen",
      owesTo: "John Doe",
      amount: 40.25,
      reason: "Groceries split",
      date: DateTime.now().subtract(Duration(days: 1)),
      isSettled: false,
    ),
    OwesData(
      person: "John Doe",
      owesTo: "Sarah Wilson",
      amount: 600.00,
      reason: "Rent split",
      date: DateTime.now().subtract(Duration(days: 3)),
      isSettled: false,
    ),
    OwesData(
      person: "Mike Chen",
      owesTo: "Sarah Wilson",
      amount: 600.00,
      reason: "Rent split",
      date: DateTime.now().subtract(Duration(days: 3)),
      isSettled: false,
    ),
    OwesData(
      person: "John Doe",
      owesTo: "Mike Chen",
      amount: 42.88,
      reason: "Dinner out split",
      date: DateTime.now().subtract(Duration(days: 2)),
      isSettled: false,
    ),
    OwesData(
      person: "Sarah Wilson",
      owesTo: "Mike Chen",
      amount: 42.88,
      reason: "Dinner out split",
      date: DateTime.now().subtract(Duration(days: 2)),
      isSettled: true,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final unsettledDebts = owesData.where((debt) => !debt.isSettled).toList();
    final settledDebts = owesData.where((debt) => debt.isSettled).toList();
    final totalOwed = unsettledDebts.fold(0.0, (sum, debt) => sum + debt.amount);

    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFFF9F43),
        elevation: 0,
        title: Text(
          'Who Owes What',
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
            Tab(text: 'Outstanding'),
            Tab(text: 'Settled'),
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryCard(
                      "Total Outstanding",
                      "\$${totalOwed.toStringAsFixed(2)}",
                      Colors.red[100]!,
                      Colors.red[600]!,
                    ),
                    _buildSummaryCard(
                      "Settled This Month",
                      "\$${settledDebts.fold(0.0, (sum, debt) => sum + debt.amount).toStringAsFixed(2)}",
                      Colors.green[100]!,
                      Colors.green[600]!,
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Outstanding tab
                _buildDebtsList(unsettledDebts, false),
                // Settled tab
                _buildDebtsList(settledDebts, true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String title, String amount, Color bgColor, Color textColor) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            amount,
            style: TextStyle(
              fontSize: 18,
              color: textColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebtsList(List<OwesData> debts, bool isSettled) {
    if (debts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSettled ? Icons.check_circle_outline : Icons.money_off,
              size: 64,
              color: Colors.grey[400],
            ),
            SizedBox(height: 16),
            Text(
              isSettled ? 'No settled debts yet' : 'No outstanding debts',
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
        itemCount: debts.length,
        itemBuilder: (context, index) {
          final debt = debts[index];
          return Container(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: debt.isSettled ? Colors.green[50] : Colors.red[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: debt.isSettled ? Colors.green[200]! : Colors.red[200]!,
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: debt.isSettled ? Colors.green : Colors.orange,
                  radius: 20,
                  child: Text(
                    debt.person.substring(0, 2).toUpperCase(),
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${debt.person} owes ${debt.owesTo}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        debt.reason,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[600],
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _formatDate(debt.date),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '\$${debt.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: debt.isSettled ? Colors.green[600] : Colors.red[600],
                      ),
                    ),
                    if (!debt.isSettled) ...[
                      SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => _markAsSettled(debt),
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'Mark Paid',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ] else ...[
                      SizedBox(height: 8),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.green[100],
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          'Settled',
                          style: TextStyle(
                            color: Colors.green[600],
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  void _markAsSettled(OwesData debt) {
    setState(() {
      debt.isSettled = true;
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Debt marked as settled'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class OwesData {
  final String person;
  final String owesTo;
  final double amount;
  final String reason;
  final DateTime date;
  bool isSettled;

  OwesData({
    required this.person,
    required this.owesTo,
    required this.amount,
    required this.reason,
    required this.date,
    required this.isSettled,
  });
}