import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:inkwell_library/core/network/api_client.dart';
import 'package:inkwell_library/core/utils/debounce.dart';
import 'package:inkwell_library/core/utils/format_selector.dart';
import 'package:url_launcher/url_launcher.dart';

class BooksController {
  final String category;

  BooksController({required this.category});

  final ApiClient apiClient = ApiClient(client: http.Client());

  RxList<dynamic> bookList = [].obs;
  RxBool isLoading = false.obs;
  RxBool isFetchingMore = false.obs;

  String? nextPageUrl;
  String searchQuery = "";

  final Debouncer _debouncer = Debouncer(milliseconds: 400);

  void init() {
    fetchBooks(isNewSearch: true);
  }

  Future<void> fetchBooks({bool isNewSearch = false}) async {
    if (isNewSearch) {
      bookList.clear();
      nextPageUrl = null;
      isLoading.value = true;
    } else {
      if (nextPageUrl == null) return;
      isFetchingMore.value = true;
    }

    try {
      Map<String, String>? queryParams;

      if (isNewSearch) {
        queryParams = {
          "topic": category.toLowerCase(),
          "mime_type": "image/",
          if (searchQuery.isNotEmpty) "search": searchQuery,
        };

        final response = await apiClient.get(
          "/books",
          queryParams: queryParams,
        );

        bookList.addAll(response['results']);
        nextPageUrl = response['next'];
      } else {
        final response = await apiClient.getFromUrl(nextPageUrl!);

        bookList.addAll(response['results']);
        nextPageUrl = response['next'];
      }
    } catch (e) {
      Get.defaultDialog(title: "Error", middleText: e.toString());
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  void onSearchChanged(String value) {
    _debouncer.run(() {
      searchQuery = value;
      fetchBooks(isNewSearch: true);
    });
  }

  Future<void> openBook(Map<String, dynamic> book) async {
    final formats = book['formats'];
    final url = FormatSelector.getPreferredFormat(formats);

    if (url != null) {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } else {
      Get.defaultDialog(
        title: "Error",
        middleText: "No viewable version available",
      );
    }
  }

  void dispose() {
    _debouncer.dispose();
  }
}
