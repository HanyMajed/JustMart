import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';

class QuantitySelector extends StatefulWidget {
  final int initialValue;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const QuantitySelector({
    super.key,
    this.initialValue = 1,
    this.minValue = 1,
    this.maxValue = 99,
    required this.onChanged,
  });

  @override
  _QuantitySelectorState createState() => _QuantitySelectorState();
}

class _QuantitySelectorState extends State<QuantitySelector> {
  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 20,
            ),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            onPressed: _increment,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            '$quantity',
            style: TextStyles.semiBold16.copyWith(fontSize: 20, color: Colors.black),
          ),
        ),
        Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: Colors.grey.shade500,
            borderRadius: BorderRadius.circular(14),
          ),
          child: IconButton(
            icon: const Icon(Icons.remove, color: Colors.white, size: 20),
            padding: const EdgeInsets.all(4),
            constraints: const BoxConstraints(),
            onPressed: _decrement,
          ),
        ),
      ],
    );
  }

  void _increment() {
    if (quantity < widget.maxValue) {
      setState(() {
        quantity++;
        widget.onChanged(quantity);
      });
    }
  }

  void _decrement() {
    if (quantity > widget.minValue) {
      setState(() {
        quantity--;
        widget.onChanged(quantity);
      });
    }
  }
}
