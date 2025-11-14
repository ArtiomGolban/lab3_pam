import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/controller/home_page_controller.dart';
import 'package:lab2_ag/list_items/home_page_list_items/recommendation_list_item.dart';
import 'package:lab2_ag/list_items/spacer_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/trending_carousel_item.dart';
import 'package:lab2_ag/list_items/home_page_list_items/welcome_header_item.dart';
import 'package:lab2_ag/widgets/home_page_widgets/recommendation_list_widget.dart';
import 'package:lab2_ag/widgets/home_page_widgets/trending_carousel_widget.dart';
import 'package:lab2_ag/widgets/home_page_widgets/welcome_header_widget.dart';
import 'package:lab2_ag/widgets/spacer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => HomePageController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    HomePageController homePageController = Get.find();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          leading: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 18.0),
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: Colors.grey, width: 1),
              ),
              child: const Icon(Icons.menu, size: 24, color: Colors.black),
            ),
          ),

          // actions: notification icon with badge (reactive)
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18.0),
              child: Obx(() {
                final count = homePageController.notificationCount.value;
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.grey, width: 1),
                      ),
                      child: IconButton(
                        icon: const Icon(
                          Icons.notifications_none_outlined,
                          size: 22,
                          color: Colors.black,
                        ),
                        onPressed: () {
                          // TODO: open notifications screen
                        },
                      ),
                    ),
                    if (count > 0)
                      Positioned(
                        right: -6,
                        top: -6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            minHeight: 20,
                          ),
                          child: Center(
                            child: Text(
                              count > 99 ? '99+' : '$count',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: homePageController.items.length,
          itemBuilder: (context, index) {
            var item = homePageController.items[index];
            if (item is WelcomeHeaderItem) {
              return WelcomeHeaderWidget(item: item);
            }
            if (item is SpacerItem) {
              return SpacerWidget(item: item);
            }
            if (item is TrendingCarouselItem) {
              return TrendingCarouselWidget(item: item);
            }
            if (item is RecommendationListItem) {
              return RecommendationListWidget(item: item);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
