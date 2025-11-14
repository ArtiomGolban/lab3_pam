import 'package:lab2_ag/list_items/list_item.dart';

class RecommendationCardItem extends ListItem {
  final int id;
  final String imgPath;
  final String newsTitle;
  final String publisherImgPath;
  final String publisher;
  final String postDate;
  final String recommendationCategory;
  final bool isFollowing;
  final bool isVerified;

  RecommendationCardItem({
    required this.id,
    required this.imgPath,
    required this.newsTitle,
    required this.publisherImgPath,
    required this.publisher,
    required this.postDate,
    required this.recommendationCategory,
    this.isFollowing = false,
    this.isVerified = false,
  });
}
