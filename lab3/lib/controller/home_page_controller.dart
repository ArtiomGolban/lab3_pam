import 'package:get/get.dart';
import 'package:lab2_ag/services/data_service.dart';
import 'package:lab2_ag/list_items/list_item.dart';
import 'package:lab2_ag/list_items/spacer_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/welcome_header_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_carousel_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_card_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_list_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_card_item.dart';

class HomePageController extends GetxController {
  RxList<ListItem> items = RxList();

  // new: notifications observable
  final RxInt notificationCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    try {
      final newsJson = await DataService.loadNews();

      // set notification count (defensive parsing)
      final rawCount = newsJson['user']?['notification_count'];
      int parsedCount = 0;
      if (rawCount is int) {
        parsedCount = rawCount;
      } else {
        parsedCount = int.tryParse('${rawCount ?? 0}') ?? 0;
      }
      notificationCount.value = parsedCount;

      items.clear();
      items.add(SpacerItem(height: 24));
      items.add(WelcomeHeaderItem(
        userName: (newsJson['user']?['name'] as String?) ?? 'User',
        profileImage: (newsJson['user']?['profile_image'] as String?) ?? '',
        notificationCount: parsedCount,
      ));
      items.add(SpacerItem(height: 24));

      // Trending -> build TrendingCardItem list (same as before)
      final trendingRaw = (newsJson['trending_news'] as List<dynamic>?) ?? [];
      final trendingItems = trendingRaw.map((t) {
        final m = t as Map<String, dynamic>;
        return TrendingCardItem(
          id: (m['id'] is int) ? m['id'] as int : int.tryParse('${m['id']}') ?? 0,
          imgPath: (m['image'] as String?) ?? '',
          trendingTitle: (m['title'] as String?) ?? '',
          publisherImgPath: (m['publisher_icon'] as String?) ?? '',
          publisher: (m['publisher'] as String?) ?? '',
          postDate: (m['date'] as String?) ?? '',
          trendingCategory: (m['category'] as String?) ?? '',
          isVerified: (m['is_verified'] as bool?) ?? false,
        );
      }).toList();
      items.add(TrendingCarouselItem(trendingItems: trendingItems));
      items.add(SpacerItem(height: 24));

      // Recommendations -> dynamic list
      final recs = (newsJson['recommendations'] as List<dynamic>?) ?? [];
      final recItems = recs.map((r) {
        final m = r as Map<String, dynamic>;
        return RecommendationCardItem(
          id: (m['id'] is int) ? m['id'] as int : int.tryParse('${m['id']}') ?? 0,
          imgPath: (m['image'] as String?) ?? '',
          newsTitle: (m['title'] as String?) ?? '',
          publisherImgPath: (m['publisher_icon'] as String?) ?? '',
          publisher: (m['publisher'] as String?) ?? '',
          postDate: (m['date'] as String?) ?? '',
          recommendationCategory: (m['category'] as String?) ?? '',
          isFollowing: (m['is_following'] as bool?) ?? false,
          isVerified: (m['publisher_verified'] as bool?) ?? false,
        );
      }).toList();

      items.add(RecommendationListItem(recommendationItems: recItems));
      items.add(SpacerItem(height: 24));
    } catch (e, st) {
      print('[HomePageController] error loading data: $e\n$st');
    }
  }
}
