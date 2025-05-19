import 'package:flutter/material.dart';
import 'package:just_mart/core/utils/app_text_styles.dart';
import 'package:just_mart/core/utils/app_colors.dart';
import 'package:just_mart/widgets/custom_appbar.dart';
import 'package:just_mart/widgets/custom_button.dart';
import 'package:just_mart/widgets/custom_checkbox.dart';
import 'package:just_mart/widgets/custom_text_form_field.dart';

class AddNewCard extends StatefulWidget {
  const AddNewCard({super.key});
  static const routeName = 'AddNewCard';

  @override
  State<AddNewCard> createState() => _AddNewCardPageState();
}

class _AddNewCardPageState extends State<AddNewCard> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _cvvController = TextEditingController();
  bool isDefaultCard = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: 'اضف بطاقة جديدة'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('اسم حامل البطاقة'),
                _buildCardNameField(),
                const SizedBox(height: 16),
                _buildLabel('رقم البطاقة'),
                _buildCardNumberField(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('تاريخ الصلاحيه'),
                            _buildExpiryDateField(),
                          ]),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('CVC'),
                            _buildCVVField(),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildVirtualCardField(),
                const SizedBox(height: 32),
                CustomButton(
                  onPressed: _submitForm,
                  text: 'أضف وسيلة دفع جديدة',
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: TextStyles.bold13),
    );
  }

  Widget _buildCardNameField() {
    return CustomTextFormField(
      controller: _cardNameController,
      hintText: 'أدخل اسم البطاقة',
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        return null;
      },
    );
  }

  Widget _buildCardNumberField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomTextFormField(
        controller: _cardNumberController,
        hintText: '**** **** **** ****',
        textInputType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          if (value.length < 16) {
            return 'رقم البطاقة غير صحيح';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildExpiryDateField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomTextFormField(
        controller: _expiryDateController,
        hintText: 'MM/YY',
        textInputType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCVVField() {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: CustomTextFormField(
        controller: _cvvController,
        hintText: '123',
        textInputType: TextInputType.number,
        obsecureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'هذا الحقل مطلوب';
          }
          if (value.length < 3) {
            return 'CVV غير صحيح';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildVirtualCardField() {
    return Row(
      children: [
        CustomCheckbox(
          isChecked: isDefaultCard,
          onChanged: (value) {
            setState(() {
              isDefaultCard = value;
            });
          },
        ),
        const SizedBox(width: 12),
        Text(
          'جعل البطاقة افتراضية',
          style: TextStyles.bold13.copyWith(color: const Color(0xFF333333)),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission
      _showComingSoonDialog();
    }
  }

  void _showComingSoonDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تنبيه'),
        content: const Text('هذه الميزة قيد التطوير، سيتم إتاحتها قريباً'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('موافق'),
          ),
        ],
      ),
    );
  }
}
