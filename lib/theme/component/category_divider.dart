import 'package:flutter/material.dart';

class CategoryDivider extends StatelessWidget {
  const CategoryDivider({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Text(
              title,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Divider(
              thickness: 0.5,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
