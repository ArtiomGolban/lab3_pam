import 'package:lab2_ag/list_items/list_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_card_item.dart';

class TrendingCarouselItem extends ListItem{
  final List<TrendingCardItem> trendingItems;

  TrendingCarouselItem({
    required this.trendingItems
  });
}