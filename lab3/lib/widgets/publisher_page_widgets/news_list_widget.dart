import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_list_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/resources/app_strings.dart';
import 'package:lab2_ag/widgets/publisher_page_widgets/news_publisher_widget.dart';

class NewsListWidget extends StatelessWidget {
  const NewsListWidget({super.key, required this.item});

  final NewsListItem item;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Section header + sort/view controls
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'News by ${item.newsItems.isNotEmpty ? item.newsItems.first.publisher : ''}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.color1A1A1A,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Sort by: ',
                        style: TextStyle(
                          color: AppColors.color999999,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Newest',
                        style: TextStyle(
                          color: AppColors.color1A1A1A,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.keyboard_arrow_down, size: 18, color: AppColors.color1A1A1A),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.crop_square, size: 24, color: AppColors.primaryP2),
                      const SizedBox(width: 12),
                      Icon(Icons.view_agenda_outlined, size: 20, color: AppColors.color1A1A1A),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 14),

        // Search Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryP1,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.search, color: AppColors.color1A1A1A, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Search "${AppStrings.news}"',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: AppColors.color999999,
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 14),

        // The list of news cards (separated)
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: item.newsItems.length,
          separatorBuilder: (_, __) => const SizedBox(height: 24),
          itemBuilder: (context, index) {
            final newsItem = item.newsItems[index];
            return NewsPublisherWidget(item: newsItem);
          },
        ),
      ],
    );
  }
}