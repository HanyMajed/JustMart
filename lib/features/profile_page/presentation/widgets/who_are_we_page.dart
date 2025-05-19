import 'package:flutter/material.dart';

class WhoAreWePage extends StatelessWidget {
  const WhoAreWePage({super.key});

  static const routeName = 'who_are_we_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'من نحن؟',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('من نحن؟'),
            _buildSectionContent(
              'نحن تطبيق مخصص لطلاب جامعة العلوم والتكنولوجيا الأردنية. تم تصميم وتطوير هذا التطبيق '
              'لتلبية احتياجات الطلاب في هذه الجامعة العريقة، حيث يتيح لهم الوصول إلى خدمات التجارة '
              'الإلكترونية بسهولة وأمان.',
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('نظام التحقق المتقدم'),
            _buildSectionContent(
              'يتميز تطبيقنا بنظام تحقق متقدم يضمن أن المستخدمين هم فقط طلاب الجامعة من خلال التحقق '
              'من البريد الإلكتروني للطالب، مما يضمن أن جميع المشاركين في السوق الإلكترونية هم جزء '
              'من مجتمع الجامعة.',
              icon: Icons.verified_user,
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('دعم المشاريع الطلابية'),
            _buildSectionContent(
              'نحن نؤمن بأهمية دعم مشاريع الطلاب الشخصية والمبادرات الصغيرة. في الآونة الأخيرة، أصبحنا '
              'نشهد العديد من الطلاب الذين يطلقون مشاريعهم الصغيرة مثل بيع الطعام والأشياء اليدوية '
              'وغيرها. ولذلك، يوفر تطبيقنا منصة آمنة وفعّالة لهم لعرض وبيع منتجاتهم بكل يسر وسهولة، '
              'مما يسهم في تعزيز روح المبادرة والإبداع بين الطلاب.',
              icon: Icons.group_work,
            ),
            const SizedBox(height: 32),
            _buildSectionTitle('رؤيتنا'),
            _buildSectionContent(
              'نحن هنا لدعم كل فكرة وطموح، ونسعى لأن نكون حلقة وصل بين الطلاب ومنتجاتهم في عالم '
              'التجارة الإلكترونية، لتوفير بيئة تشجع على الابتكار والنجاح.',
              icon: Icons.visibility,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF2C3E50),
              height: 1.4,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionContent(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(left: 12, top: 4),
              child: Icon(icon, color: Colors.blue[800], size: 24),
            ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
                height: 1.6,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
