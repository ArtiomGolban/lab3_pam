import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/home_page_list_items/welcome_header_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/utils/image_helper.dart';

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({super.key, required this.item});

  final WelcomeHeaderItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Texts on the left
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Welcome back, ${item.userName}!",
                  style: const TextStyle(
                    color: AppColors.color1A1A1A,
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Discover a world of news that matters to you",
                  style: TextStyle(
                    color: AppColors.color999999,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Profile image on the right
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 56,
              height: 56,
              child: buildCachedImage(
                item.profileImage,
                fit: BoxFit.cover,
                width: 56,
                height: 56,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
