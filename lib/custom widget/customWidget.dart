import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/newsController.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();
  bool _isFocused = false;
  final NewsController controller = Get.put(NewsController());

  @override
  void initState() {
    super.initState();
    // Automatically rebuild to show/hide clear button
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: _isFocused
            ? [
          BoxShadow(
            color: Colors.orange.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ]
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          )
        ],
      ),
      child: Row(
        children: [
          // 🔍 Search icon
          InkWell(
            onTap: () {
              if (_controller.text.trim().isNotEmpty) {
                controller.searchNews(_controller.text.trim());
              }
            },
            child: Obx(() {
              return controller.isNewsForYouLoading.value
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.orange,
                ),
              )
                  : const Icon(Icons.search, color: Colors.orange, size: 24);
            }),
          ),
          const SizedBox(width: 10),
          // 🔤 TextField
          Expanded(
            child: Focus(
              onFocusChange: (focus) {
                setState(() {
                  _isFocused = focus;
                });
              },
              child: TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.black, fontSize: 16),
                decoration: const InputDecoration(
                  hintText: "Search news...",
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    controller.searchNews(value.trim());
                  }
                },
              ),
            ),
          ),
          // ❌ Clear button
          if (_controller.text.isNotEmpty)
            GestureDetector(
              onTap: () {
                _controller.clear();
                controller.fetchNewsForYou(); // reset to original news
              },
              child: const Icon(Icons.close, color: Colors.grey, size: 20),
            ),
        ],
      ),
    );
  }
}
