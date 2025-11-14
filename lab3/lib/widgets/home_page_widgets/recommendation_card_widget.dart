import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_card_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/utils/image_helper.dart';

class RecommendationCardWidget extends StatefulWidget {
  const RecommendationCardWidget({super.key, required this.item});

  final RecommendationCardItem item;

  @override
  State<RecommendationCardWidget> createState() =>
      _RecommendationCardWidgetState();
}

class _RecommendationCardWidgetState extends State<RecommendationCardWidget> {
  late bool _isFollowing;

  @override
  void initState() {
    super.initState();
    // initialize local state from model (comes from JSON)
    _isFollowing = widget.item.isFollowing;
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ButtonStyle followStyle = ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: _isFollowing
          ? AppColors.color1A1A1A
          : const Color.fromRGBO(18, 19, 20, 0.08),
      foregroundColor: _isFollowing ? Colors.white : AppColors.color1A1A1A,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryP1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --------------- Header --------------
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // First part of the header
                GestureDetector(
                  onTap: () {
                    final publisherName = widget.item.publisher;
                    print(
                      '[Home] navigate to publisher page for (name press): $publisherName',
                    );
                    Get.toNamed(
                      '/publisher-page',
                      arguments: {'publisherName': publisherName},
                    );
                  },
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: SizedBox(
                          height: 48,
                          width: 48,
                          child: buildCachedImage(
                            widget.item.publisherImgPath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                widget.item.publisher,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey,
                                ),
                              ),
                              if (widget.item.isVerified) ...[
                                const SizedBox(width: 8),
                                Icon(
                                  Icons.verified_rounded,
                                  color: AppColors.primaryP2,
                                  size: 18,
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 1),
                          Text(
                            widget.item.postDate,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // Second part of the header
                Row(
                  children: [
                    ElevatedButton(
                      style: followStyle,
                      // ElevatedButton.styleFrom(
                      //   elevation: 0,
                      //   backgroundColor: Color.fromRGBO(18, 19, 20, 0.08),
                      //   foregroundColor: AppColors.color1A1A1A,
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: 22,
                      //     vertical: 9,
                      //   ),
                      //   shape: RoundedRectangleBorder(
                      //     borderRadius: BorderRadius.circular(7),
                      //   ),
                      //   textStyle: TextStyle(
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w500,
                      //   ),
                      // ),
                      onPressed: _toggleFollow,
                      child: Row(
                        children: [
                          Text(_isFollowing ? 'Following' : 'Follow'),
                          // if (_isFollowing) const SizedBox(width: 8),
                          // if (_isFollowing) const Icon(Icons.check, size: 16),
                        ],
                      ),
                    ),

                    const SizedBox(width: 14),

                    Icon(
                      Icons.more_vert_outlined,
                      size: 24,
                      color: Color.fromRGBO(18, 19, 20, 1),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // --------------- Title --------------
            Text(
              widget.item.newsTitle,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              softWrap: true,
            ),

            const SizedBox(height: 12),

            // --------------- Category --------------
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryP2, width: 1),
                borderRadius: BorderRadius.circular(6),
                color: Colors.transparent,
              ),
              child: Text(
                widget.item.recommendationCategory,
                style: TextStyle(
                  color: AppColors.primaryP2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // --------------- Image --------------
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: buildCachedImage(
                widget.item.imgPath,
                fit: BoxFit.cover,
                height: 198,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
