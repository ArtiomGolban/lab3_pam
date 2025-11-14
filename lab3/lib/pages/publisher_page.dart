import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/controller/publisher_page_controller.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/about_publisher_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/info_publisher_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_list_item.dart';
import 'package:lab2_ag/list_items/spacer_item.dart';
import 'package:lab2_ag/widgets/publisher_page_widgets/about_publisher_widget.dart';
import 'package:lab2_ag/widgets/publisher_page_widgets/info_publisher_widget.dart';
import 'package:lab2_ag/widgets/publisher_page_widgets/news_list_widget.dart';
import 'package:lab2_ag/widgets/spacer_widget.dart';

class PublisherPage extends StatefulWidget {
  const PublisherPage({super.key});

  @override
  State<PublisherPage> createState() => _PublisherPageState();
}

class _PublisherPageState extends State<PublisherPage> {
  @override
  void initState() {
    super.initState();
    Get.lazyPut(() => PublisherPageController());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PublisherPageController publisherPageController = Get.find();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60), // Custom height for AppBar
        child: AppBar(
          title: Obx(() {
            final uname = publisherPageController.username.value;
            return Text(
              uname.isEmpty ? 'Publisher' : uname,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            );
          }),
          backgroundColor: Colors.white, // AppBar background color
          leading: Align(
            alignment: Alignment.centerLeft, // Align to left
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(left: 18.0),
                // Padding from the left
                width: 40,
                // Fixed width for the container
                height: 40,
                // Fixed height for the container
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.grey, width: 1),
                ),
                child: Icon(
                  Icons.arrow_back,
                  size: 24, // Icon size to prevent stretching
                ),
              ),
            ),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 18.0),
              // Padding from the right
              width: 40,
              // Fixed width for the container
              height: 40,
              // Fixed height for the container
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: Colors.grey,
                  width: 1,
                ), // Border radius of 6
              ),
              child: Icon(
                Icons.more_vert_outlined,
                size: 24, // Icon size to prevent stretching
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: publisherPageController.items.length,
          itemBuilder: (context, index) {
            var item = publisherPageController.items[index];
            if (item is SpacerItem) {
              return SpacerWidget(item: item);
            }
            if (item is InfoPublisherItem) {
              return InfoPublisherWidget(item: item);
            }
            if (item is AboutPublisherItem) {
              return AboutPublisherWidget(item: item);
            }
            if (item is NewsListItem) {
              return NewsListWidget(item: item);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
