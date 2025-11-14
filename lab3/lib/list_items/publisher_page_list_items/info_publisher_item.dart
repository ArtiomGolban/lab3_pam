import 'package:lab2_ag/list_items/list_item.dart';

class InfoPublisherItem extends ListItem {
  final String publisherImgPath;
  final String publisherNewsNr;
  final String publisherFollowersNr;
  final String publisherFollowingNr;

  InfoPublisherItem({
    required this.publisherImgPath,
    required this.publisherNewsNr,
    required this.publisherFollowersNr,
    required this.publisherFollowingNr,
  });
}
