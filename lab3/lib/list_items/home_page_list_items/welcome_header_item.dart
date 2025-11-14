import 'package:lab2_ag/list_items/list_item.dart';

class WelcomeHeaderItem extends ListItem {
  final String userName;
  final String profileImage;
  final int notificationCount;

  WelcomeHeaderItem({
    required this.userName,
    this.profileImage = '',
    this.notificationCount = 0,
  });
}
