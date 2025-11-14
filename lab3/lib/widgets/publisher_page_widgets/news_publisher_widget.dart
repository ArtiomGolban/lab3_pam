import 'package:flutter/material.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_publisher_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/utils/image_helper.dart';

class NewsPublisherWidget extends StatefulWidget {
  const NewsPublisherWidget({super.key, required this.item});

  final NewsPublisherItem item;

  @override
  State<NewsPublisherWidget> createState() => _NewsPublisherWidgetState();
}

class _NewsPublisherWidgetState extends State<NewsPublisherWidget> {
  late bool _bookmarked;

  @override
  void initState() {
    super.initState();
    _bookmarked = widget.item.isBookmarked;
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryP1,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // header
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: SizedBox(
                    height: 48,
                    width: 48,
                    child: buildCachedImage(
                      item.publisherImgPath,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            item.publisher,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(width: 8),
                          if (item.isVerified)
                            Icon(
                              Icons.verified_rounded,
                              color: AppColors.primaryP2,
                              size: 18,
                            ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.postDate,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                // bookmark icon
                IconButton(
                  onPressed: () {
                    setState(() {
                      _bookmarked = !_bookmarked;
                      // optionally persist to storage / update model
                    });
                  },
                  icon: Icon(
                    _bookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // title
            Text(
              item.newsTitle,
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
              softWrap: true,
            ),

            const SizedBox(height: 12),

            // category
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryP2, width: 1),
                borderRadius: BorderRadius.circular(6),
                color: Colors.transparent,
              ),
              child: Text(
                item.newsCategory,
                style: TextStyle(
                  color: AppColors.primaryP2,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // image
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: buildCachedImage(
                item.imgPath,
                fit: BoxFit.cover,
                height: 198,
                width: double.infinity,
              ),
            ),

            const SizedBox(height: 12),

            // stats row: likes / comments / shares
            Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 18,
                      color: AppColors.color999999,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.likes.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.color999999,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Row(
                  children: [
                    Icon(
                      Icons.comment_outlined,
                      size: 18,
                      color: AppColors.color999999,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.comments.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.color999999,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 18),
                Row(
                  children: [
                    Icon(
                      Icons.share_outlined,
                      size: 18,
                      color: AppColors.color999999,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      item.shares.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.color999999,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
