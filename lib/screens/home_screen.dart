import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../utilities/colors.dart';
import '../widgets/custom_bottomNavBar.dart';
import '../widgets/cutom_card_stack.dart';
import 'accounts_and_card_screen.dart';
import 'bill_payments_screen.dart';
import 'mobile_prepaid_screen.dart';
import 'save_online_screen.dart';
import 'transaction_report_screen.dart';
import 'transfer_screen.dart';
import 'withdraw_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Map<String, dynamic>> menuItems = [
    {
      'image': 'assets/images/home_images/img.png',
      'label': 'Account\nand Card',
      'screen': const AccountsAndCardScreen(),
    },
    {
      'image': 'assets/images/home_images/img_1.png',
      'label': 'Transfer',
      'screen': const TransferScreen(),
    },
    {
      'image': 'assets/images/home_images/img_2.png',
      'label': 'Withdraw',
      'screen': const WithdrawScreen(),
    },
    {
      'image': 'assets/images/home_images/img_3.png',
      'label': 'Mobile prepaid',
      'screen': const MobilePrepaidScreen(),
    },
    {
      'image': 'assets/images/home_images/img_4.png',
      'label': 'Pay the bill',
      'screen': const BillPaymentsScreen(),
    },
    {
      'image': 'assets/images/home_images/img_5.png',
      'label': 'Save online',
      'screen': const SaveOnlineScreen(),
    },
    {
      'image': 'assets/images/home_images/img_6.png',
      'label': 'Credit Card',
      'screen': const AccountsAndCardScreen(),
    },
    {
      'image': 'assets/images/home_images/img_7.png',
      'label': 'Transaction report',
      'screen': const TransactionReportScreen(),
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.fetchUserProfile();
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => item['screen']),
        );
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.3), blurRadius: 5),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              item['image'],
              height: 28,
              width: 28,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 12),
            Text(
              item['label'],
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: AppColors.greyText,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.primaryColor,
          appBar: AppBar(
            toolbarHeight: 90,
            title: Padding(
              padding: const EdgeInsets.only(left: 24.0, right: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      userProvider.user?.profileImage ?? 'assets/images/personhomescreen.png',
                    ),
                    onBackgroundImageError: (_, __) {
                      // Handle error by showing default image
                    },
                  ),
                  const SizedBox(width: 18),
                  SizedBox(
                    width: 136,
                    height: 24,
                    child: Text(
                      "Hi, ${userProvider.user?.fullName ?? 'User'}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications, color: Colors.white, size: 28),
                        onPressed: () {
                          // Handle notifications
                        },
                      ),
                      if ((userProvider.user?.unreadNotifications ?? 0) > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(2),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: Text(
                                "${userProvider.user?.unreadNotifications}",
                                style: const TextStyle(fontSize: 10, color: Colors.white),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primaryColor,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
              ),
              color: Colors.white,
            ),
            child: RefreshIndicator(
              onRefresh: _loadUserData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(top: 91.0, left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CustomCardStack(),
                      const SizedBox(height: 32),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1,
                        ),
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) => _buildMenuItem(menuItems[index]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        );
      },
    );
  }
}
