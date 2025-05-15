import 'package:flutter/material.dart';
import 'package:visionhr/utils/colors.dart';
class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  int expandedIndex = 1; // Initially expanded index (2nd item)

  final List<String> questions = [
    "How does your SaaS Product work?",
    "How does your SaaS Product work?",
    "How does your SaaS Product work?",
    "How does your SaaS Product work?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E0E12),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0E0E12),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'FAQs',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: questions.length,
        itemBuilder: (context, index) {
          final isExpanded = expandedIndex == index;
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: AppColors.nbgcolr,
              borderRadius: BorderRadius.circular(25),
            ),
            child: ExpansionTile(
              key: Key(index.toString()), // For proper rebuild
              initiallyExpanded: isExpanded,
              tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              collapsedIconColor: Colors.white,
              iconColor: Colors.white,
              title: Text(
                questions[index],
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
              onExpansionChanged: (expanded) {
                setState(() {
                  expandedIndex = expanded ? index : -1;
                });
              },
              children: isExpanded
                  ? [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: Text(
                    "This text here comes to describe the contents of the accordion title. It can contain any kind of information or details, ranging from info to warning to success messages.",
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ),
              ]
                  : [],
            ),
          );
        },
      ),
    );
  }
}