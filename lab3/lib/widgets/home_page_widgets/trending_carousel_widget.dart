import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_carousel_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/resources/app_strings.dart';
import 'package:lab2_ag/widgets/home_page_widgets/trending_card_widget.dart';

class TrendingCarouselWidget extends StatelessWidget {
  const TrendingCarouselWidget({super.key, required this.item});

  final TrendingCarouselItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Trending News',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color1A1A1A,
                ),
              ),
              Text(
                AppStrings.seeAll,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.color999999,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8,),
        SizedBox(
          height: 306,
          child: ListView.separated(
            separatorBuilder: (_, __) => const SizedBox(width: 0),
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.zero,
            itemCount: item.trendingItems.length,
            itemBuilder: (context, index) {
              final card = item.trendingItems[index];

              return TrendingCardWidget(item: card);
            },
          ),
        ),
      ],
    );
  }
}
