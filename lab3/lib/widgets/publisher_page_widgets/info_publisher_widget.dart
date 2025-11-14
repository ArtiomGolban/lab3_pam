import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/info_publisher_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/resources/app_strings.dart';
import 'package:lab2_ag/utils/image_helper.dart';
import 'package:lab2_ag/controller/publisher_page_controller.dart';

class InfoPublisherWidget extends StatelessWidget {
  const InfoPublisherWidget({super.key, required this.item});

  final InfoPublisherItem item;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PublisherPageController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final horizontalGap = math.max(12.0, screenWidth * 0.04);
    final verticalGap = math.max(8.0, screenWidth * 0.02);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          // image with small verified overlay
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: SizedBox(
                  height: 108,
                  width: 108,
                  child: buildCachedImage(item.publisherImgPath, fit: BoxFit.cover),
                ),
              ),
              // verified badge (small)
              Positioned(
                right: 4,
                bottom: 4,
                child: Obx(() {
                  return ctrl.publisherVerified.value
                      ? Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.verified_rounded, size: 16, color: AppColors.primaryP2),
                        )
                      : const SizedBox.shrink();
                }),
              ),
            ],
          ),

          SizedBox(width: horizontalGap),

          Expanded(
            child: SizedBox(
              height: 108,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top stats
                  Row(
                    children: [
                      Expanded(
                        child: _StatColumn(value: item.publisherNewsNr, label: AppStrings.news),
                      ),
                      SizedBox(width: math.max(6.0, screenWidth * 0.015)),
                      Expanded(
                        child: _StatColumn(value: item.publisherFollowersNr, label: AppStrings.followers),
                      ),
                      SizedBox(width: math.max(6.0, screenWidth * 0.015)),
                      Expanded(
                        child: _StatColumn(value: item.publisherFollowingNr, label: AppStrings.following),
                      ),
                    ],
                  ),

                  SizedBox(height: verticalGap),

                  // reactive Follow button
                  Obx(() {
                    final following = ctrl.isFollowing.value;
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // toggle observable
                          ctrl.isFollowing.value = !ctrl.isFollowing.value;
                          // optionally persist to local storage / call API
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 11),
                          backgroundColor: following ? AppColors.color1A1A1A : Colors.white,
                          foregroundColor: following ? Colors.white : AppColors.color1A1A1A,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                            side: following ? BorderSide.none : BorderSide(color: AppColors.color1A1A1A),
                          ),
                          elevation: 0,
                        ),
                        child: Text(following ? 'Following' : 'Follow'),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  const _StatColumn({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          value,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.color1A1A1A,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.color999999,
          ),
        ),
      ],
    );
  }
}
