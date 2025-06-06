import 'package:flutter/material.dart';
import '../../../core/colors.dart';
import '../../screens/cart_screen.dart';

class FloatingCartButton extends StatelessWidget {
  const FloatingCartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.pushNamed(context, CartScreen.routeName);
      },
      backgroundColor: AppColors.primary,
      child: const Icon(
        Icons.shopping_cart_outlined,
        color: Colors.white,
      ),
    );
  }
}
