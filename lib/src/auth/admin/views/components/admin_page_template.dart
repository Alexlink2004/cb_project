import 'package:flutter/material.dart';

class AdminPageTemplate extends StatelessWidget {
  final String pageTitle;
  final String pageSubtitle;
  final Widget content;

  const AdminPageTemplate({
    required this.pageTitle,
    required this.pageSubtitle,
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: Container(
        height: double.infinity,
        color: Colors.white,
        child: SizedBox(
          height: 500,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pageTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  pageSubtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      content,
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
