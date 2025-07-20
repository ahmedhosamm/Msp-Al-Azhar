import 'package:flutter/material.dart';
import 'package:flutter_easy_faq/flutter_easy_faq.dart';
import '../../../../../style/BaseScreen.dart';
import '../../../../../style/Colors.dart';
import '../../../../../style/CustomAppBar.dart';
import '../../../../../style/Fonts.dart';
class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.neutral100,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(title: 'FAQ'),
            Expanded(
              child: BaseScreen(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  CustomFaqItem(
                    question: 'How do I apply for MSP Al-Azhar?',
                    answer: "Applications for MSP Al-Azhar are opened every year in the month of October. The most important thing is to follow us on the Facebook page, and I will post the link for the application and details.",
                  ),
                  const SizedBox(height: 12),
                  CustomFaqItem(
                    question: 'What is the abbreviation of MSP Al-Azhar?',
                    answer: 'Microsoft Student Partner means the student partner of Microsoft.',
                  ),
                  const SizedBox(height: 12),
                  CustomFaqItem(
                    question: 'What are the different fields available in MSP Al-Azhar?',
                    answer: '''Technology Fields:\n• Java\n• Python\n• Embedded Systems\n• Artificial Intelligence (AI)\n• Networking\n• Databases\n• C++\n• Flutter\n\nDevelopment & Design:\n• Front-End Development\n• Back-End Development\n• UI/UX Design\n• Graphic Design\n• Media Production\n• Video Editing\n• Photography\n\nManagement & Marketing:\n• Marketing\n• Public Relations\n• Human Resources\n• Logistics''',
                  ),
                  const SizedBox(height: 12),
                  CustomFaqItem(
                    question: 'What distinguishes MSP Al-Azhar from anywhere else?',
                    answer: 'We are available offline and online and close to the university. Our training is strong and from correct sources. You will have a chance to be promoted at the end of the semester and to the position you want, in proportion to your skills. We work throughout the semester to develop two parts, the technical skills and the soft skills. And both are very, very important',
                  ),
                  const SizedBox(height: 12),
                  CustomFaqItem(
                    question: 'Will we stay in MSP for a certain period or continue?',
                    answer: 'It continues normally, but each season has a different position.',
                  ),
                  const SizedBox(height: 12),
                  CustomFaqItem(
                    question: 'Who supervises the head of each track?',
                    answer: 'The President and the Vice President.',
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    )
    );
  }
}

class CustomFaqItem extends StatefulWidget {
  final String question;
  final String answer;
  const CustomFaqItem({required this.question, required this.answer, Key? key}) : super(key: key);

  @override
  State<CustomFaqItem> createState() => _CustomFaqItemState();
}

class _CustomFaqItemState extends State<CustomFaqItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.neutral200, width: 1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                expanded = !expanded;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.question,
                      style: (expanded
                              ? AppTexts.highlightAccent.copyWith(color: AppColors.primary700)
                              : AppTexts.highlightAccent.copyWith(color: AppColors.neutral1000)),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.remove : Icons.add,
                    color: expanded ? AppColors.primary700 : AppColors.neutral1000,
                  ),
                ],
              ),
            ),
          ),
          if (expanded) ...[
            Divider(
              color: AppColors.primary700,
              thickness: 1,
              height: 0,
              indent: 16,
              endIndent: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: widget.question == 'What are the different fields available in MSP Al-Azhar?'
                  ? _buildFieldsAnswer()
                  : Text(
                      widget.answer,
                      style: AppTexts.contentEmphasis.copyWith(color: AppColors.neutral1000),
                    ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFieldsAnswer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Technology Fields :',
          style: AppTexts.highlightAccent.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 2),
        Text('• Java\n• Python\n• Cyber security\n• C++\n• Networking\n• Databases\n• C++\n• Artificial intelligence( AI ) ( Data analysis - ML ) \n• Embedded System',
            style: AppTexts.contentRegular.copyWith(color: AppColors.neutral1000)),
        const SizedBox(height: 8),
        Text(
          'Developers Fields :',
          style: AppTexts.highlightAccent.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 2),
        Text('• Front-End Development\n• Back-End Development\n• UI/UX Design\n• mobile app development ( Flutter ) \n• Testing',
            style: AppTexts.contentRegular.copyWith(color: AppColors.neutral1000)),
        const SizedBox(height: 8),
        Text(
          'Media Fields :',
          style: AppTexts.highlightBold.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 2),
        Text('• Video editing\n• Graphic Design\n• Photography',
            style: AppTexts.contentRegular.copyWith(color: AppColors.neutral1000)),
        Text(
          'Human resources ( HR ) ',
          style: AppTexts.highlightAccent.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 8),
        Text(
          'Logistics',
          style: AppTexts.highlightBold.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 8),
        Text(
          'Public relations ( PR )',
          style: AppTexts.highlightAccent.copyWith(color: AppColors.primary700),
        ),
        const SizedBox(height: 8),
        Text(
          'Marketing ',
          style: AppTexts.highlightBold.copyWith(color: AppColors.primary700),
        ),
      ],
    );
  }
}
