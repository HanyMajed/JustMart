import 'package:flutter/material.dart';
import 'package:just_mart/widgets/custom_appbar.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});
  static const routeName = 'termsAndconditions';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, title: "الشروط و الأحكام"),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'شروط وأحكام استخدام تطبيق JUST MART',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          _buildSectionTitle('1. مقدمة'),
          _buildSectionContent(
              'مرحبًا بكم في تطبيق JUST MART، المنصة الإلكترونية الرائدة للتسوق عبر الإنترنت. باستخدامك للتطبيق، فإنك توافق على الالتزام بالشروط والأحكام التالية. يرجى قراءتها بعناية قبل الاستخدام.'),
          _buildSectionTitle('2. القبول بالشروط'),
          _buildSectionContent(
              'يُعتبر استخدامك للتطبيق موافقة تامة على هذه الشروط. إذا لم توافق على أي بند من هذه الشروط، يرجى التوقف عن استخدام التطبيق فورًا.'),
          _buildSectionTitle('3. حسابات المستخدمين'),
          _buildSectionContent(
              '- يجب أن تكون المعلومات المقدمة أثناء إنشاء الحساب صحيحة وكاملة\n- أنت المسؤول الوحيد عن سرية معلومات الحساب\n- يحق للتطبيق تعليق الحساب في حالة مخالفة الشروط'),
          _buildSectionTitle('4. الخصوصية والأمان'),
          _buildSectionContent(
              '- نحن نحمي بياناتك الشخصية وفقًا لأحدث معايير الأمان\n- لا نشارك معلوماتك مع أطراف ثالثة دون موافقتك\n- التطبيق يستخدم تشفير SSL لحماية المعاملات'),
          _buildSectionTitle('5. الطلبات والدفع'),
          _buildSectionContent(
              '- الأسعار المعروضة نهائية وتشمل الضريبة\n- يحق للتطبيق رفض الطلبات غير المكتملة\n- نضمن طرق دفع آمنة عبر بوابات معتمدة'),
          _buildSectionTitle('6. الإرجاع والاستبدال'),
          _buildSectionContent(
              '- يمكنك إرجاع المنتجات خلال 14 يومًا من الاستلام\n- يجب أن يكون المنتج في حالته الأصلية\n- سيتم استرجاع المبلغ خلال 5 أيام عمل'),
          _buildSectionTitle('7. الملكية الفكرية'),
          _buildSectionContent(
              'جميع المحتويات الموجودة على التطبيق (شعارات، نصوص، صور) محمية بحقوق الملكية الفكرية. أي استخدام غير مصرح به يعرضك للمساءلة القانونية.'),
          _buildSectionTitle('8. التعديلات'),
          _buildSectionContent(
              'نحتفظ بحق تعديل هذه الشروط في أي وقت، وسيتم إعلامكم بالتغييرات عبر التطبيق أو البريد الإلكتروني.'),
          _buildSectionTitle('9. الاتصال بنا'),
          _buildSectionContent(
              'لأية استفسارات أو ملاحظات، يرجى التواصل عبر:\nالبريد الإلكتروني: support@justmart.com\nالهاتف: 0790000000'),
          const SizedBox(height: 30),
          Text(
            'تاريخ آخر تحديث: 17 مايو 2024',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 10),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue[800],
        ),
      ),
    );
  }

  Widget _buildSectionContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        height: 1.5,
        color: Colors.grey[800],
      ),
      textAlign: TextAlign.justify,
    );
  }
}
