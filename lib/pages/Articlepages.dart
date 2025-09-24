import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/newsController.dart';
import '../custom widget/customWidget.dart';
import '../shimmer_card.dart';
import 'NewsDetail.dart';


class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.put(NewsController());

    return Scaffold(
      backgroundColor: const Color(0xFF101820), // Dark navy background
      appBar: AppBar(
        backgroundColor: const Color(0xFF101820),
        elevation: 0,
        title: const Text(
          "Articles",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 🔍 Search Bar
            CustomSearchBar(),
            const SizedBox(height: 20),

            // 📰 Article List
            Expanded(
              child: Obx(() {
                if (controller.isNewsForYouLoading.value) {
                  // 🔥 Shimmer while loading
                  return ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        height: 160,
                        width: double.infinity,
                      );
                    },
                  );
                }

                if (controller.newsForYou.isEmpty) {
                  return const Center(
                    child: Text(
                      "No trending news found",
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }

                // ✅ Real News Cards
                return ListView.builder(
                  itemCount: controller.newsForYou.length,
                  itemBuilder: (context, index) {
                    var article = controller.newsForYou[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                NewsDetailPage(article: article),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // 🖼 Image
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(16),
                              ),
                              child: Image.network(
                                article.urlToImage ??
                                    "https://picsum.photos/400/200",
                                height: 160,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),

                            // 📖 Title + Author
                            Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    article.title ?? "No Title",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    article.author ?? "Unknown Author",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
