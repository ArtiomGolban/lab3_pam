import 'package:lab2_ag/list_items/list_item.dart';

class TrendingCardItem extends ListItem {
  final int id;
  final String imgPath;
  final String trendingTitle;
  final String publisherImgPath;
  final String publisher;
  final String postDate;
  final String trendingCategory;
  final bool isVerified;

  TrendingCardItem({
    required this.id,
    required this.imgPath,
    required this.trendingTitle,
    required this.publisherImgPath,
    required this.publisher,
    required this.postDate,
    required this.trendingCategory,
    this.isVerified = false,
  });
}
