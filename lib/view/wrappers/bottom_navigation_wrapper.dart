import 'package:flutter/material.dart';
import '../components/common/floating_cart_button.dart';
import 'package:get/get.dart'; // Retained for GetBuilder
import '../../data/controller/home_controller.dart';
import '../../data/repo/product_repo.dart';
// import '../../data/service/api_service.dart'; // No longer directly used here
import '../screens/home_screen.dart';
import '../screens/category_screen.dart';
import '../screens/orders_screen.dart';
import '../components/custom_nav_bar.dart';
import '../screens/profile_screen.dart';

class BottomNavigationWrapper extends StatefulWidget {
  const BottomNavigationWrapper({super.key});

  @override
  State<BottomNavigationWrapper> createState() =>
      _BottomNavigationWrapperState();
}

class _BottomNavigationWrapperState extends State<BottomNavigationWrapper> {
  int _selectedIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      GetBuilder<HomeController>(
        init: HomeController(ProductRepo()),
        builder: (controller) => const HomeScreen(),
      ),
      const OrdersScreen(),
      const CategoryScreen(),
      const ProfileScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: CustomNavBar(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
      floatingActionButton: const FloatingCartButton(),
    );
  }
}
