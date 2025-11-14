import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/about_publisher_item.dart';
import 'package:lab2_ag/resources/app_colors.dart';
import 'package:lab2_ag/controller/publisher_page_controller.dart';

class AboutPublisherWidget extends StatelessWidget {
  const AboutPublisherWidget({super.key, required this.item});

  final AboutPublisherItem item;

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<PublisherPageController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                item.publisher,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              Obx(() {
                return ctrl.publisherVerified.value
                    ? Icon(Icons.verified_rounded, color: AppColors.primaryP2, size: 20)
                    : const SizedBox.shrink();
              }),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item.aboutPublisher,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w400,
              color: Colors.grey,
            ),
            softWrap: true,
          ),
        ],
      ),
    );
  }
}
