import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../controller/newsController.dart';
import '../model/newsModel.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsArticle article;

  const NewsDetailPage({super.key, required this.article});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  late FlutterTts flutterTts;
  final NewsController controller = Get.put(NewsController());

  @override
  void initState() {
    super.initState();
    flutterTts = FlutterTts();

    // Reset controller state if user navigates back
    flutterTts.setCompletionHandler(() {
      controller.isSpeaking.value = false;
    });
  }

  Future<void> _speak(String text) async {
    // Stop any previous speech first
    await flutterTts.stop();

    controller.isSpeaking.value = true;

    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);

    await flutterTts.speak(text);
  }

  Future<void> _pause() async {
    await flutterTts.stop();
    controller.isSpeaking.value = false;
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final article = widget.article;

    return Scaffold(
      appBar: AppBar(
        title: Text(article.title ?? "News Detail"),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(bottom: Radius.circular(16)),
              child: Image.network(
                article.urlToImage ?? "https://picsum.photos/400/200",
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.title ?? "No Title",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),

            // Author + Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 14,
                    backgroundImage: NetworkImage(article.urlToImage),
                  ),
                  const SizedBox(width: 8),
                  Text(article.author ?? "Unknown", style: const TextStyle(fontWeight: FontWeight.w600)),
                  const Spacer(),

                ],
              ),
            ),
            const SizedBox(height: 16),
            Center(child: Text(article.publishedAt?.split("T").first ?? "", style: const TextStyle(color: Colors.grey))),

            // Audio Player
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Colors.tealAccent, Colors.cyanAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      offset: const Offset(2, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Play/Pause Button
                    Obx(() => Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: DecoratedBox(
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: Icon(
                              controller.isSpeaking.value
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_filled,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              if (controller.isSpeaking.value) {
                                _pause();
                              } else {
                                _speak(article.description ?? "No description");
                              }
                            },
                          ),
                        ),
                      ),
                    )),

                    const SizedBox(width: 12),

                    // Wave animation
                    Expanded(
                      child: Obx(() => Lottie.asset(
                        "assets/Audio_Wave.json",
                        fit: BoxFit.contain,
                        animate: controller.isSpeaking.value,
                      )),
                    ),

                    // Optional Timer placeholder
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: const Text(
                        "00:00",
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Full Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                article.description ?? "Description not available",
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
