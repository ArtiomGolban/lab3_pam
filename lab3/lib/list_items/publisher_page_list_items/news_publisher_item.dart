import 'package:lab2_ag/list_items/list_item.dart';

class NewsPublisherItem extends ListItem {
  final String imgPath;
  final String newsTitle;
  final String publisherImgPath;
  final String publisher;
  final String postDate;
  final String newsCategory;
  final bool isVerified;

  final int likes;
  final int comments;
  final int shares;
  final bool isBookmarked;

  NewsPublisherItem({
    required this.imgPath,
    required this.newsTitle,
    required this.publisherImgPath,
    required this.publisher,
    required this.postDate,
    required this.newsCategory,
    this.isVerified = false,
    this.likes = 0,
    this.comments = 0,
    this.shares = 0,
    this.isBookmarked = false,
  });
}
