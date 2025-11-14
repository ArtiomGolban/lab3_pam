import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/controller/publisher_page_controller.dart';
import 'package:lab2_ag/pages/home_page.dart';
import 'package:lab2_ag/pages/publisher_page.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => const HomePage()),
      GetPage(
        name: '/publisher-page',
        page: () => const PublisherPage(),
        binding: BindingsBuilder(() {
          // controller will be created when route opens and disposed when closed
          Get.lazyPut<PublisherPageController>(() => PublisherPageController());
        }),
      ),
    ],
  ));
}
