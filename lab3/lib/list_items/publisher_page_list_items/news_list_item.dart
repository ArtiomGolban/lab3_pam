import 'package:lab2_ag/list_items/list_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_publisher_item.dart';

class NewsListItem extends ListItem {
  final List<NewsPublisherItem> newsItems;

  NewsListItem({required this.newsItems});
}
