import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class UserDeatil extends StatelessWidget {
  const UserDeatil({
    super.key,
    required this.context,
    required this.email,
    required this.avatarUrl,
  });

  final String email;
  final String avatarUrl;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.network(
          avatarUrl,
          height: 70, // Set height according to your needs
          width: 70, // Set width according to your needs
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 8),
        Text(
          email,
          style: context.typo.desc1.copyWith(
            color: context.color.text,
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
