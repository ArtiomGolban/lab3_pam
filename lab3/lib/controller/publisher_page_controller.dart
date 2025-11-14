import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lab2_ag/list_items/list_item.dart';
import 'package:lab2_ag/list_items/spacer_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/info_publisher_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/about_publisher_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_list_item.dart';
import 'package:lab2_ag/list_items/publisher_page_list_items/news_publisher_item.dart';

class PublisherPageController extends GetxController {
  RxList<ListItem> items = RxList();

  // Basic observables for AppBar
  final RxString username = ''.obs;
  final RxString publisherLogo = ''.obs;
  final RxBool publisherVerified = false.obs;
  final RxBool isFollowing = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadForRequestedPublisher();
  }

  // normalization helper: lowercase, trim, collapse whitespace, remove punctuation
  static String _normalize(String s) {
    var out = s.trim().toLowerCase();
    out = out.replaceAll(RegExp(r'[\u00A0]'), ' '); // NBSP
    out = out.replaceAll(
      RegExp(r'[\W_]+'),
      ' ',
    ); // remove punctuation, keep spaces and letters/numbers
    out = out.replaceAll(RegExp(r'\s+'), ' ');
    return out;
  }

  Future<void> _loadForRequestedPublisher() async {
    try {
      final rawArgs = Get.arguments;
      // accept either {publisherName: 'Bloomberg'} or {publisherId: 102}
      int requestedId = 0;
      String requestedRaw = '';
      if (rawArgs is Map) {
        if (rawArgs['publisherId'] != null) {
          if (rawArgs['publisherId'] is int) {
            requestedId = rawArgs['publisherId'] as int;
          } else {
            requestedId = int.tryParse('${rawArgs['publisherId']}') ?? 0;
          }
        }
        if (rawArgs['publisherName'] != null) {
          requestedRaw = '${rawArgs['publisherName']}';
        } else if (rawArgs['publisher'] != null) {
          requestedRaw = '${rawArgs['publisher']}';
        }
      }

      final String requested = _normalize(requestedRaw);
      print(
        '[PublisherPage] requestedRaw="$requestedRaw", requestedNorm="$requested", requestedId=$requestedId',
      );

      // 1) load publishers details file (use your actual filename)
      // NOTE: change path if your file is named differently ('publishers.json' or 'news_details.json')
      final String rawPublishers = await rootBundle.loadString(
        'assets/data/news_details.json',
      );
      final Map<String, dynamic> publishersJson =
          jsonDecode(rawPublishers) as Map<String, dynamic>;
      final List<dynamic> publishersArr =
          (publishersJson['publishers'] as List<dynamic>?) ?? [];

      Map<String, dynamic>? matchedBlock;

      // If user passed an id, try to match by publisher.id first (fast and deterministic)
      if (requestedId > 0) {
        print('[PublisherPage] attempting id match...');
        for (final p in publishersArr) {
          try {
            final block = p as Map<String, dynamic>;
            final pub = (block['publisher'] as Map<String, dynamic>?) ?? {};
            final dynamic idRaw = pub['id'];
            final int id = (idRaw is int)
                ? idRaw
                : int.tryParse('${idRaw ?? ''}') ?? 0;
            if (id == requestedId) {
              matchedBlock = block;
              print('[PublisherPage] matched by id -> publisher id=$id');
              break;
            }
          } catch (e) {
            // ignore per-block errors
          }
        }
      }

      // If not matched by id, try robust name/username matching
      if (matchedBlock == null && requested.isNotEmpty) {
        print('[PublisherPage] attempting name/username matching...');
        // Build a list of candidate tuples for easier debug
        for (final p in publishersArr) {
          try {
            final block = p as Map<String, dynamic>;
            final pub = (block['publisher'] as Map<String, dynamic>?) ?? {};
            final String name = _normalize((pub['name'] as String?) ?? '');
            final String usernameVal = _normalize(
              (pub['username'] as String?) ?? '',
            );
            final String nameNoSpace = name.replaceAll(' ', '');
            final String usernameNoSpace = usernameVal.replaceAll(' ', '');
            final String requestedNoSpace = requested.replaceAll(' ', '');

            // exact normalized match
            if (name == requested || usernameVal == requested) {
              matchedBlock = block;
              print(
                '[PublisherPage] exact normalized match -> name="$name", username="$usernameVal"',
              );
              break;
            }

            // match without spaces
            if (nameNoSpace == requestedNoSpace ||
                usernameNoSpace == requestedNoSpace) {
              matchedBlock = block;
              print(
                '[PublisherPage] normalized no-space match -> name="$name", username="$usernameVal"',
              );
              break;
            }

            // contains / substring fallback (e.g., requested "bloom" matches "bloomberg")
            if (name.contains(requested) ||
                usernameVal.contains(requested) ||
                requested.contains(name) ||
                requested.contains(usernameVal)) {
              matchedBlock = block;
              print(
                '[PublisherPage] substring match -> name="$name", username="$usernameVal"',
              );
              break;
            }
          } catch (e) {
            // ignore
          }
        }
      }

      final List<ListItem> built = [];
      built.add(SpacerItem(height: 24));

      if (matchedBlock != null) {
        // FULL publisher details found
        final Map<String, dynamic> pub =
            (matchedBlock['publisher'] as Map<String, dynamic>?) ?? {};
        final String parsedName = (pub['name'] as String?) ?? '';
        final String parsedUsername =
            (pub['username'] as String?) ?? parsedName;
        final String parsedLogo = (pub['logo'] as String?) ?? '';
        final String parsedBio = (pub['bio'] as String?) ?? '';
        final Map<String, dynamic> stats =
            (pub['stats'] as Map<String, dynamic>?) ?? {};
        final String parsedNewsCount = (stats['news_count']?.toString()) ?? '';
        final String parsedFollowers = (stats['followers']?.toString()) ?? '';
        final String parsedFollowing = (stats['following']?.toString()) ?? '';
        final bool parsedIsFollowing = (pub['is_following'] as bool?) ?? false;
        final bool parsedVerified = (pub['verified'] as bool?) ?? false;

        username.value = parsedUsername;
        publisherLogo.value = parsedLogo;
        publisherVerified.value = parsedVerified;
        isFollowing.value = parsedIsFollowing;

        built.add(
          InfoPublisherItem(
            publisherImgPath: parsedLogo,
            publisherNewsNr: parsedNewsCount,
            publisherFollowersNr: parsedFollowers,
            publisherFollowingNr: parsedFollowing,
          ),
        );

        built.add(SpacerItem(height: 24));

        built.add(
          AboutPublisherItem(publisher: parsedName, aboutPublisher: parsedBio),
        );

        built.add(SpacerItem(height: 24));

        final List<dynamic> newsRaw =
            (matchedBlock['news'] as List<dynamic>?) ?? [];

        int _parseInt(dynamic v) {
          if (v == null) return 0;
          if (v is int) return v;
          return int.tryParse('$v') ?? 0;
        }

        final newsList = newsRaw.map((nj) {
          final Map<String, dynamic> n = nj as Map<String, dynamic>;
          final Map<String, dynamic> statMap =
              (n['stats'] as Map<String, dynamic>?) ?? {};

          return NewsPublisherItem(
            imgPath: (n['image'] as String?) ?? '',
            newsTitle: (n['title'] as String?) ?? '',
            publisherImgPath: parsedLogo,
            publisher: parsedName,
            postDate: (n['date'] as String?) ?? '',
            newsCategory: (n['category'] as String?) ?? '',
            // new fields:
            isVerified: (n['publisher_verified'] as bool?) ?? parsedVerified,
            likes: _parseInt(statMap['likes']),
            comments: _parseInt(statMap['comments']),
            shares: _parseInt(statMap['shares']),
            isBookmarked: (n['is_bookmarked'] as bool?) ?? false,
          );
        }).toList();

        if (newsList.isNotEmpty) {
          built.add(NewsListItem(newsItems: newsList));
          built.add(SpacerItem(height: 24));
        }

        items.assignAll(built);
        print('[PublisherPage] Loaded full publisher block for "$parsedName"');
        return;
      }

      // --- fallback: search news.json for an article that has the requested publisher
      print(
        '[PublisherPage] no publisher block matched. Trying fallback search in news.json...',
      );
      final String rawNews = await rootBundle.loadString(
        'assets/data/news.json',
      );
      final Map<String, dynamic> newsJson =
          jsonDecode(rawNews) as Map<String, dynamic>;

      Map<String, dynamic>? foundEntry;

      final List<dynamic> recs =
          (newsJson['recommendations'] as List<dynamic>?) ?? [];
      for (final r in recs) {
        try {
          final Map<String, dynamic> m = r as Map<String, dynamic>;
          final String pname = _normalize((m['publisher'] as String?) ?? '');
          if (pname == requested ||
              pname.replaceAll(' ', '') == requested.replaceAll(' ', '')) {
            foundEntry = m;
            print(
              '[PublisherPage] found article in recommendations matching publisher="$pname"',
            );
            break;
          }
        } catch (_) {}
      }

      if (foundEntry == null) {
        final List<dynamic> trending =
            (newsJson['trending_news'] as List<dynamic>?) ?? [];
        for (final r in trending) {
          try {
            final Map<String, dynamic> m = r as Map<String, dynamic>;
            final String pname = _normalize((m['publisher'] as String?) ?? '');
            if (pname == requested ||
                pname.replaceAll(' ', '') == requested.replaceAll(' ', '')) {
              foundEntry = m;
              print(
                '[PublisherPage] found article in trending matching publisher="$pname"',
              );
              break;
            }
          } catch (_) {}
        }
      }

      if (foundEntry != null) {
        final parsedLogo = (foundEntry['publisher_icon'] as String?) ?? '';
        final parsedName = (foundEntry['publisher'] as String?) ?? requestedRaw;
        username.value = parsedName;
        publisherLogo.value = parsedLogo;
        publisherVerified.value = (foundEntry['is_verified'] as bool?) ?? false;
        isFollowing.value = (foundEntry['is_following'] as bool?) ?? false;

        built.add(
          InfoPublisherItem(
            publisherImgPath: parsedLogo,
            publisherNewsNr: '',
            publisherFollowersNr: '',
            publisherFollowingNr: '',
          ),
        );
        built.add(SpacerItem(height: 24));
        built.add(
          AboutPublisherItem(
            publisher: parsedName,
            aboutPublisher:
                'No detailed profile available. Showing the article found in news.json.',
          ),
        );
        built.add(SpacerItem(height: 24));
        built.add(
          NewsListItem(
            newsItems: [
              NewsPublisherItem(
                imgPath: (foundEntry['image'] as String?) ?? '',
                newsTitle: (foundEntry['title'] as String?) ?? '',
                publisherImgPath: parsedLogo,
                publisher: parsedName,
                postDate: (foundEntry['date'] as String?) ?? '',
                newsCategory: (foundEntry['category'] as String?) ?? '',
              ),
            ],
          ),
        );
        built.add(SpacerItem(height: 24));

        items.assignAll(built);
        print('[PublisherPage] Fallback minimal page built for "$parsedName"');
        return;
      }

      // nothing found
      built.add(
        AboutPublisherItem(
          publisher: requestedRaw,
          aboutPublisher: 'No publisher or article found for "$requestedRaw".',
        ),
      );
      built.add(SpacerItem(height: 24));
      items.assignAll(built);
      print(
        '[PublisherPage] No data found for requested publisher "$requestedRaw"',
      );
    } catch (e, st) {
      print('[PublisherPage] Error loading publisher by name/id: $e\n$st');
      items.assignAll([
        SpacerItem(height: 24),
        AboutPublisherItem(
          publisher: '',
          aboutPublisher: 'Failed to load publisher data.',
        ),
      ]);
    }
  }
}
