import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/backend_endpoints.dart';
import 'package:just_mart/features/cart/cart_provider.dart';
import 'package:just_mart/features/home/presentation/views/widgets/cart_item.dart';
import 'package:just_mart/features/orders/buyer_all_orders.dart';
import 'package:just_mart/features/orders/order_model.dart';

class CartView extends StatefulWidget {
  const CartView({super.key, required this.signedUID});
  final String signedUID;

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  double? totalPrice;
  bool _isPlacingOrder = false;
  List<String> locations = ["مبنى ال C (الهندسية)", "مجمع القاعات التدريسية", "مبنى ال P (الطبية)"];
  var paymentMethod = 'cash';
  int drpdownValue = 0;

  @override
  void initState() {
    totalPrice = context.read<CartProvider>().total;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    final cartItems = cartProvider.items;

    return WillPopScope(
      onWillPop: () async => false, // Disable back gesture & back button
      child: Scaffold(
        appBar: AppBar(
          title: const Text("السلة", style: TextStyles.bold16),
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context); // Manual back
            },
          ),
        ),
        body: cartItems.isEmpty
            ? const Center(child: Text('لم يتم العثور على المنتجات'))
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        return CartItem(
                          onRemove: () {
                            cartProvider.removeAt(index);
                            setState(() {
                              totalPrice = cartProvider.total;
                            });
                          },
                          product: cartItems[index],
                        );
                      },
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 26),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.white,
                          border: Border.all(color: AppColors.primaryColor),
                        ),
                        child: ListTile(
                          title: const Text('دفع نقدي عند الإستلام', style: TextStyles.bold13),
                          leading: Radio<String>(
                            value: 'cash',
                            groupValue: paymentMethod,
                            onChanged: (value) {
                              setState(() {
                                paymentMethod = value!;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 26),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: const Color.fromARGB(132, 245, 245, 245),
                          border: Border.all(color: const Color.fromARGB(255, 136, 136, 136)),
                        ),
                        child: ListTile(
                          title: const Text(
                            '''دفع عن طريق البطاقة 
(سيتم تفعيلها لاحقاً)''',
                            style: TextStyles.bold13,
                          ),
                          leading: Radio<String>(
                            value: 'Visa',
                            groupValue: paymentMethod,
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: DropdownButtonFormField<int>(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      dropdownColor: Colors.white.withAlpha(230),
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("مبنى ال C (الهندسية)", style: TextStyle(color: AppColors.primaryColor))),
                        DropdownMenuItem(value: 1, child: Text("مجمع القاعات التدريسية", style: TextStyle(color: AppColors.primaryColor))),
                        DropdownMenuItem(value: 2, child: Text("مبنى ال P (الطبية)", style: TextStyle(color: AppColors.primaryColor))),
                      ],
                      value: drpdownValue,
                      onChanged: (newValue) {
                        setState(() {
                          drpdownValue = newValue!;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    width: 280,
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: _isPlacingOrder ? Colors.grey : AppColors.primaryColor,
                        borderRadius: const BorderRadius.all(Radius.circular(14)),
                      ),
                      child: _isPlacingOrder
                          ? const Center(child: CircularProgressIndicator(color: Colors.white))
                          : GestureDetector(
                              onTap: _placeOrder,
                              child: Center(
                                child: Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'تأكيد الطلب بقيمة  ',
                                        style: TextStyles.semiBold16.copyWith(color: Colors.white),
                                      ),
                                      TextSpan(
                                        text: cartProvider.total.toStringAsFixed(2),
                                        style: TextStyles.semiBold16.copyWith(color: AppColors.seconderyColor),
                                      ),
                                      TextSpan(
                                        text: ' دينار',
                                        style: TextStyles.semiBold16.copyWith(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
      ),
    );
  }

  Future<void> _placeOrder() async {
    if (_isPlacingOrder) return;

    setState(() => _isPlacingOrder = true);

    try {
      final cartProvider = context.read<CartProvider>();

      final order = OrderModel(
        vendorId: cartProvider.items.first.vendorId,
        buyerId: widget.signedUID,
        orderItems: cartProvider.items,
        totalPrice: cartProvider.total,
      );

      await order.placeOrder(widget.signedUID);

      await FirebaseFirestore.instance.collection(BackendEndpoints.placeOrder).doc(order.orderId).update({
        'deliveryLocation': locations[drpdownValue],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('تم تأكيد الطلب بنجاح! رقم الطلب: ${order.orderId}'),
          duration: const Duration(seconds: 3),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => BuyerAllOrders(order: order)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('فشل تأكيد الطلب: ${e.toString()}'),
          backgroundColor: const Color.fromARGB(255, 134, 9, 0),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isPlacingOrder = false);
      }
    }
  }
}
