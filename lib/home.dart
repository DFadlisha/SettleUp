import 'package:flutter/material.dart';
//import 'package:settleup/firebase_auth.dart';
//import 'authentication/auth.dart';
//import 'package:flutter/services.dart';
import 'logout.dart'; // Import the logout page

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String _timeOfDay = 'Morning';
  String _selectedPeriod = 'Weekly';

  @override
  void initState() {
    super.initState();
    _setTimeOfDay();
  }

  void _setTimeOfDay() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      _timeOfDay = 'Morning';
    } else if (hour < 17) {
      _timeOfDay = 'Afternoon';
    } else {
      _timeOfDay = 'Evening';
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Navigate to logout page
  void _navigateToLogout() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LogoutPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFFE8F7F0),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryBox(),
                      const SizedBox(height: 16),
                      _buildPeriodToggle(),
                      const SizedBox(height: 16),
                      Expanded(child: _buildTransactionsList()),
                      _buildBottomNavBar(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(color: Color(0xFFFFA14E)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hi, Welcome Back',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Good $_timeOfDay',
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_outlined),
                      onPressed: () {},
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(width: 8), // Add spacing between icons
                  Container(
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.logout),
                      onPressed:
                          _navigateToLogout, // Call function to navigate to logout page
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.account_balance_wallet_outlined,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Total Balance',
                          style: TextStyle(fontSize: 14, color: Colors.black87),
                        ),
                      ],
                    ),
                    const Text(
                      '\$7,783.00',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Container(height: 40, width: 1, color: Colors.black26),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.trending_down,
                            size: 16,
                            color: Colors.red,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'Total Expense',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black87,
                            ),
                          ),
                        ],
                      ),
                      const Text(
                        '-\$1,187.40',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Container(
                    height: 8,
                    decoration: BoxDecoration(
                      // ignore: deprecated_member_use
                      color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    height: 8,
                    width: MediaQuery.of(context).size.width * 0.3,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F3F33),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.29,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: Color(0xFF0F3F33),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.circle, color: Colors.white, size: 8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle_outline, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        '30% Of Your Expenses, Looks Good.',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                  const Text(
                    '\$20,000.00',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryBox() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFA14E),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFC18E),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.directions_car_outlined,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Savings',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const Text(
                  'On Goals',
                  style: TextStyle(fontSize: 12, color: Colors.black87),
                ),
              ],
            ),
          ),
          Container(height: 80, width: 1, color: Colors.black26),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.account_balance_wallet, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        'Revenue Last Week',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                  const Text(
                    '\$4,000.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.restaurant, size: 16),
                      const SizedBox(width: 4),
                      const Text(
                        'Food Last Week',
                        style: TextStyle(fontSize: 12, color: Colors.black87),
                      ),
                    ],
                  ),
                  const Text(
                    '-\$100.00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildPeriodButton('Daily'),
        const SizedBox(width: 8),
        _buildPeriodButton('Weekly'),
        const SizedBox(width: 8),
        _buildPeriodButton('Monthly'),
      ],
    );
  }

  Widget _buildPeriodButton(String text) {
    final isSelected = _selectedPeriod == text;
    return InkWell(
      onTap: () {
        setState(() {
          _selectedPeriod = text;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFC18E) : const Color(0xFFFFE0C9),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.black87 : Colors.black54,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    return ListView(
      children: [
        _buildTransactionItem(
          'Salary',
          '18:27 - April 30',
          'Monthly',
          '\$4,000.00',
          Colors.pink.shade200,
          Icons.account_balance_wallet,
          isExpense: false,
        ),
        _buildTransactionItem(
          'Groceries',
          '17:00 - April 24',
          'Pantry',
          '-\$100.00',
          Colors.orange.shade200,
          Icons.shopping_bag_outlined,
          isExpense: true,
        ),
        _buildTransactionItem(
          'Rent',
          '8:30 - April 15',
          'Rent',
          '-\$674.40',
          Colors.brown.shade300,
          Icons.house_outlined,
          isExpense: true,
        ),
      ],
    );
  }

  Widget _buildTransactionItem(
    String title,
    String date,
    String category,
    String amount,
    Color iconBgColor,
    IconData icon, {
    required bool isExpense,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(color: Colors.black54, fontSize: 12),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                category,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isExpense ? Colors.red : Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavBarItem(0, Icons.home),
          _buildNavBarItem(1, Icons.pie_chart),
          _buildNavBarItem(2, Icons.sync),
          _buildNavBarItem(3, Icons.layers),
          _buildNavBarItem(4, Icons.person),
        ],
      ),
    );
  }

  Widget _buildNavBarItem(int index, IconData icon) {
    final isSelected = _selectedIndex == index;
    return InkWell(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFFFA14E) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: isSelected ? Colors.black : Colors.grey),
      ),
    );
  }
}
