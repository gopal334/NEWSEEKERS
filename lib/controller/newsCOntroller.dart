import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/newsModel.dart';

class NewsController extends GetxController {
  // Observable lists
  RxList<NewsArticle> trendingNews = <NewsArticle>[].obs;
  RxList<NewsArticle> newsForYou = <NewsArticle>[].obs;
  RxList<NewsArticle> newsForYou5 = <NewsArticle>[].obs;
  RxList<NewsArticle> AppleNewsList= <NewsArticle>[].obs;
  RxList<NewsArticle> AppleNews5 = <NewsArticle>[].obs;
  RxList<NewsArticle> TeslaNewsList= <NewsArticle>[].obs;
  RxList<NewsArticle> TeslaNews5 = <NewsArticle>[].obs;
  RxList<NewsArticle> BusinessNewsList= <NewsArticle>[].obs;
  RxList<NewsArticle> BusinessNews5 = <NewsArticle>[].obs;



  // Separate loading states
  var isTrendingLoading = false.obs;
  var isNewsForYouLoading = false.obs;
  var isAppleNewsLoading = false.obs;
  var isTeslaNewsLoading = false.obs;
  var isBusinessNewsLoading = false.obs;
  FlutterTts flutterTts = FlutterTts();
  RxBool isSpeaking = false.obs;



  @override
  void onInit() {
    super.onInit();
    fetchTrendingNews();
    fetchNewsForYou();
    getAppleNews();
    getTeslaNews();
    getBusinessNews();
  }

  // Fetch trending news
  Future<void> fetchTrendingNews() async {
    try {
      isTrendingLoading(true);
      trendingNews.clear();

      var url =
          "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'];
        if (articles != null) {
          for (var item in articles) {
            trendingNews.add(NewsArticle.fromJson(item));
          }
        }
      } else {
        print("Failed to load trending news: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching trending news: $e");
    } finally {
      isTrendingLoading(false);
    }
  }

  // Fetch "News for You"
  Future<void> fetchNewsForYou() async {
    try {
      isNewsForYouLoading(true);
      newsForYou.clear();

      var url =
          "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'];
        if (articles != null) {
          for (var item in articles) {
            newsForYou.add(NewsArticle.fromJson(item));
          }
          newsForYou5.value = newsForYou.sublist(0, 5);
        }

      } else {
        print("Failed to load news for you: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news for you: $e");
    } finally {
      isNewsForYouLoading(false);
    }
  }
  Future<void> getAppleNews() async {
    try {
      isAppleNewsLoading(true);
      AppleNewsList.clear();

      var url =
          "https://newsapi.org/v2/everything?q=apple&from=2025-09-22&to=2025-09-22&sortBy=popularity&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'];
        if (articles != null) {
          for (var item in articles) {
            AppleNewsList.add(NewsArticle.fromJson(item));
          }
          AppleNews5.value = AppleNewsList.sublist(0, 5);
        }

      } else {
        print("Failed to load news for you: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news for you: $e");
    } finally {
      isNewsForYouLoading(false);
    }
  }
  Future<void> getTeslaNews() async {
    try {
      isTeslaNewsLoading(true);
      TeslaNewsList.clear();

      var url =
          "https://newsapi.org/v2/everything?q=tesla&from=2025-08-23&sortBy=publishedAt&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'];
        if (articles != null) {
          for (var item in articles) {
            TeslaNewsList.add(NewsArticle.fromJson(item));
          }
          TeslaNews5.value = TeslaNewsList.sublist(0, 5);
        }

      } else {
        print("Failed to load news for you: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news for you: $e");
    } finally {
      isNewsForYouLoading(false);
    }
  }
  Future<void> getBusinessNews() async {
    try {
      isBusinessNewsLoading(true);
      BusinessNewsList.clear();

      var url =
          "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'];
        if (articles != null) {
          for (var item in articles) {
            BusinessNewsList.add(NewsArticle.fromJson(item));
          }
          BusinessNews5.value = BusinessNewsList.sublist(0, 5);
        }

      } else {
        print("Failed to load news for you: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching news for you: $e");
    } finally {
      isNewsForYouLoading(false);
    }
  }
  Future<void> searchNews(String search) async {
    if (search.trim().isEmpty) return;

    try {
      isNewsForYouLoading(true);
      newsForYou.clear();

      var url =
          "https://newsapi.org/v2/everything?sources=techcrunch&q=$search&apiKey=eba549bcf9914dbf886301aba784b766";

      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var body = jsonDecode(response.body);
        var articles = body['articles'] as List<dynamic>;;
        if (articles != null && articles.isNotEmpty) {
          // Correct way to update RxList
          newsForYou.assignAll(
              articles.map((item) => NewsArticle.fromJson(item)).toList());
        } else {
          newsForYou.clear();
        }
      } else {
        print("Failed to load search results: ${response.statusCode}");
      }
    } catch (e) {
      print("Error searching news: $e");
    } finally {
      isNewsForYouLoading(false);
    }
  }

  Future<void> speak(String text) async {
    // Stop any previous speech immediately
    await flutterTts.stop();

    // Update state
    isSpeaking.value = true;

    // TTS settings
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    // Start new speech
    await flutterTts.speak(text);

    // Reset state when speech completes
    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
    });
  }

  void pause()async{

   await flutterTts.pause();
   isSpeaking.value = false;
  }




}
