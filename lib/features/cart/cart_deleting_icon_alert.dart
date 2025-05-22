import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/features/cart/cart_provider.dart';

class CartDeletingIconAlert extends StatelessWidget {
  const CartDeletingIconAlert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () async {
        final shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('هل تريد الخروج وبدء عربة تسوّق جديدة؟', style: TextStyles.bold16),
            content: const Text('اذا خرجت سيتم حذف عربة التسوّق الخاصة بك لهذا البائع', style: TextStyles.semiBold13),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('لا', style: TextStyles.bold13),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('اريد الخروج', style: TextStyles.bold13),
              ),
            ],
          ),
        );
        if (shouldPop ?? true) {
          context.read<CartProvider>().clearCart();
          Navigator.pop(context);
        } else {}
      },
    );
  }
}
