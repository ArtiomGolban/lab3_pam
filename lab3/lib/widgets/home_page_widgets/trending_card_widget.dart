import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_card_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/utils/image_helper.dart';

class TrendingCardWidget extends StatelessWidget {
  const TrendingCardWidget({super.key, required this.item});

  final TrendingCardItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18),
      child: Container(
        padding: EdgeInsets.all(8),
        width: 300,
        decoration: BoxDecoration(
          color: AppColors.primaryP1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // ------------- Image ----------------
            Stack(
              alignment: Alignment.topLeft,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: buildCachedImage(
                    item.imgPath,
                    fit: BoxFit.cover,
                    height: 162,
                    width: 286,
                  ),
                ),
                Positioned(
                  left: 8,
                  top: 8,
                  child: Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.primaryP2,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      item.trendingCategory,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // ------------- Title ----------------
            Text(
              item.trendingTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              softWrap: true,
            ),

            const SizedBox(height: 12),

            // ------------- Footer ---------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: buildCachedImage(
                        item.publisherImgPath,
                        fit: BoxFit.cover,
                        height: 24,
                        width: 24,
                      ),
                    ),
                    const SizedBox(width: 2),
                    Text(
                      item.publisher,
                      style: TextStyle(
                        color: AppColors.color999999,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    if (item.isVerified) ...[
                      const SizedBox(width: 2),
                      Icon(
                        Icons.verified_rounded,
                        color: AppColors.primaryP2,
                        size: 16,
                      ),
                    ],
                  ],
                ),
                Text(
                  item.postDate,
                  style: TextStyle(
                    color: AppColors.color999999,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
