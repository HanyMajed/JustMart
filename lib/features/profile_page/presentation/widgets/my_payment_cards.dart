import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/features/profile_page/presentation/widgets/add_new_card.dart';
import 'package:just_mart/widgets/custom_appbar.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class MyPaymentCards extends StatelessWidget {
  const MyPaymentCards({super.key});
  static const routeName = 'my-payment-cards';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'المدفوعات'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildPaymentCard('MASTERCARD****1234'),
            const SizedBox(height: 16),
            _buildPaymentCard('VISA****4887 '),
            const SizedBox(height: 16),
            Text('ستتوفر هذه الخدمة لاحقا',
                style: TextStyles.bold16.copyWith(backgroundColor: AppColors.primaryColor, color: Colors.white)),
            const Spacer(),
            CustomButton(
              onPressed: () => _addNewPaymentMethod(context),
              text: 'أضف وسيلة دفع جديدة +',
            ),
            const SizedBox(height: 30)
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentCard(String cardDetails) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Row(
        children: [
          Expanded(
            child: CustomTextFormField(
              controller: TextEditingController(text: cardDetails),
              hintText: '',
              prefixIcon: const Icon(Icons.credit_card, color: AppColors.primaryColor),
              readOnly: true,
              showCursor: false,
              readOnlyBackgroundColor: Colors.white,
              readOnlyTextColor: const Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  void _addNewPaymentMethod(BuildContext context) {
    Navigator.pushNamed(context, AddNewCard.routeName);
  }
}
