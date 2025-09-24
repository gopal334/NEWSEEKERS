import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/newsController.dart';
import '../shimmer_card.dart';
import 'NewsDetail.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsController controller = Get.put(NewsController());

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          "NEWSEEKERS",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      drawer: const Drawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Trending News
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                "Trending News",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 400,
              child: Obx(() {
                if (controller.isTrendingLoading.value) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        width: 250,
                        height: 400,
                      );
                    },
                  );
                }
                if (controller.trendingNews.isEmpty) {
                  return const Center(child: Text("No trending news found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.trendingNews.length,
                  itemBuilder: (context, index) {
                    var article = controller.trendingNews[index];
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
                      child: Container(
                        width: 250,
                        margin: const EdgeInsets.only(left: 16, right: 8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(16)),
                              child: Image.network(
                                article.urlToImage ??
                                    "https://picsum.photos/400/200",
                                height: 280,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
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
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    article.author ?? "Unknown Author",
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.grey),
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

            const SizedBox(height: 20),

            // 📌 News for You
            sectionHeader("News for You"),
            SizedBox(
              height: 180,
              child: Obx(() {
                if (controller.isNewsForYouLoading.value) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        width: 320,
                        height: 180,
                      );
                    },
                  );
                }
                if (controller.newsForYou.isEmpty) {
                  return const Center(child: Text("No news for you found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.newsForYou5.length,
                  itemBuilder: (context, index) {
                    var article = controller.newsForYou5[index];
                    return newsCard(context, article, index);
                  },
                );
              }),
            ),

            const SizedBox(height: 20),

            // 📌 Business News
            sectionHeader("Business News"),
            SizedBox(
              height: 300,
              child: Obx(() {
                if (controller.isNewsForYouLoading.value) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        width: 320,
                        height: 300,
                      );
                    },
                  );
                }
                if (controller.newsForYou.isEmpty) {
                  return const Center(child: Text("No Business News found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.BusinessNews5.length,
                  itemBuilder: (context, index) {
                    var article = controller.BusinessNews5[index];
                    return newsCard(context, article, index);
                  },
                );
              }),
            ),

            const SizedBox(height: 20),

            // 📌 Apple News
            sectionHeader("Apple News"),
            SizedBox(
              height: 180,
              child: Obx(() {
                if (controller.isNewsForYouLoading.value) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        width: 320,
                        height: 180,
                      );
                    },
                  );
                }
                if (controller.newsForYou.isEmpty) {
                  return const Center(child: Text("No Apple News found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.AppleNews5.length,
                  itemBuilder: (context, index) {
                    var article = controller.AppleNews5[index];
                    return newsCard(context, article, index);
                  },
                );
              }),
            ),

            const SizedBox(height: 20),

            // 📌 Tesla News
            sectionHeader("Tesla News"),
            SizedBox(
              height: 240,
              child: Obx(() {
                if (controller.isNewsForYouLoading.value) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return const ShimmerCard(
                        width: 320,
                        height: 240,
                      );
                    },
                  );
                }
                if (controller.newsForYou.isEmpty) {
                  return const Center(child: Text("No Tesla News found"));
                }
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.TeslaNews5.length,
                  itemBuilder: (context, index) {
                    var article = controller.TeslaNews5[index];
                    return newsCard(context, article, index);
                  },
                );
              }),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // 🔹 Section Header Widget
  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            child: const Text(
              "See All",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  // 🔹 Reusable News Card Widget
  Widget newsCard(BuildContext context, var article, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(article: article),
          ),
        );
      },
      child: Container(
        width: 320,
        margin: const EdgeInsets.only(left: 16, right: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
              const BorderRadius.horizontal(left: Radius.circular(12)),
              child: Image.network(
                article.urlToImage ??
                    "https://picsum.photos/120/90?random=$index",
                width: 120,
                height: 90,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article.title ?? "No Title",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      article.author ?? "Unknown Author",
                      style:
                      const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
