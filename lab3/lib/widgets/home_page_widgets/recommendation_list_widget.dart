import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_card_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_list_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/widgets/home_page_widgets/recommendation_card_widget.dart';

class RecommendationListWidget extends StatelessWidget {
  const RecommendationListWidget({super.key, required this.item});

  final RecommendationListItem item;

  @override
  Widget build(BuildContext context) {
    final List<RecommendationCardItem> recs = item.recommendationItems;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Text(
            'Recommendation',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.color1A1A1A,
            ),
          ),
        ),
        const SizedBox(height: 8),
        // Vertical list of recommendation cards
        ListView.separated(
          shrinkWrap:
              true, // important to allow nesting in ListView (home page)
          physics:
              const NeverScrollableScrollPhysics(), // delegate scrolling to outer ListView
          padding: EdgeInsets.zero,
          itemCount: recs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final card = recs[index];
            return RecommendationCardWidget(item: card);
          },
        ),
      ],
    );
  }
}
