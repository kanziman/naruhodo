import 'package:flutter/material.dart';
import 'package:naruhodo/src/service/theme_service.dart';

class TagCardTips extends StatelessWidget {
  const TagCardTips({
    super.key,
    this.character,
    required this.meaning,
  });

  final String? character;
  final String meaning;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: context.color.quinary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        // 아이템들을 가로로 배치
        children: [
          Icon(
            Icons.tips_and_updates_outlined, // 여기에 원하는 아이콘을 사용하세요
            color: context.color.quinary, // 아이콘 색상 설정
            size: 24, // 아이콘 크기 설정
          ),
          const SizedBox(width: 8), // 아이콘과 텍스트 사이의 간격
          Expanded(
            // 텍스트가 Row의 남은 공간을 모두 차지하도록 함
            child: Text(
              '$character$meaning',
              style: context.typo.body2.copyWith(
                fontWeight: context.typo.semiBold,
                color: context.color.quinary,
              ),
              textAlign: TextAlign.left, // 텍스트 왼쪽 정렬
            ),
          ),
        ],
      ),
    );
  }
}
