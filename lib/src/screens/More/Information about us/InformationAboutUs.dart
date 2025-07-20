import 'package:flutter/material.dart';
import '../../../../style/Colors.dart';
import '../../../../style/Fonts.dart';
import '../../../../style/BaseScreen.dart';
import '../../../../style/CustomAppBar.dart';

class InformationAboutUsScreen extends StatelessWidget {
  const InformationAboutUsScreen({Key? key}) : super(key: key);

  Widget _buildStatsBox(String value, String label, {bool fullWidth = false, EdgeInsetsGeometry? margin}) {
    final box = Container(
      width: fullWidth ? double.infinity : null,
      margin: margin ?? const EdgeInsets.symmetric(vertical: 0), // فقط margin رأسي إذا لزم
      padding: const EdgeInsets.symmetric(vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.neutral100,
        border: Border.all(color: AppColors.neutral600, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            value,
            style: AppTexts.display1Accent.copyWith(color: AppColors.primary700),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: AppTexts.highlightEmphasis.copyWith(color: AppColors.neutral600),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
    return fullWidth ? box : Expanded(child: box);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'Information About Us'),
            Expanded(
              child: BaseScreen(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // أزل أي SizedBox علوي
                    Text(
                      "MSP (Microsoft Student Partner) is a program initiated in 2001 by Microsoft to sponsor students majoring in technology-related disciplines. In late 2006, the program was expanded to fifty countries worldwide. In 2011 on the campus of Al-Azhar University, MSP Tech Club Al-Azhar was founded by the hands of some engineering students with a vision to decrease technological illiteracy and increase awareness among the students. Since then, various activities have been established to achieve that vision, until we reached to have a 250 yearly average manpower from different educational backgrounds who believe in our vision and work together to achieve it.",
                      style: AppTexts.contentEmphasis,
                      textAlign: TextAlign.start,
                    ),
                    // أزل أي SizedBox بين العناصر أو اجعلها فقط للفصل الرأسي البسيط
                    const SizedBox(height: 24),
                    _buildStatsBox('50+', 'workshops', fullWidth: true, ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        _buildStatsBox('8000+', 'Trainees',),
                        SizedBox(width: 12),
                        _buildStatsBox('11+', 'Mega Events'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildStatsBox('12+', 'Years of Experience', fullWidth: true),
                    // أزل أي SizedBox سفلي أو اجعلها صغيرة جدًا
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}
