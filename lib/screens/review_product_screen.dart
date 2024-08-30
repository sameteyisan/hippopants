import 'package:flutter/material.dart';
import 'package:hippopants/widgets/page_indicator.dart';
import 'package:pinch_zoom_release_unzoom/pinch_zoom_release_unzoom.dart';

class ReviewProductScreen extends StatefulWidget {
  const ReviewProductScreen(
      {super.key, required this.images, required this.initialIndex, required this.title});
  final List<String> images;
  final int initialIndex;
  final String title;

  @override
  State<ReviewProductScreen> createState() => _ReviewProductScreenState();
}

class _ReviewProductScreenState extends State<ReviewProductScreen> {
  late final PageController controller;

  int currentPageIndex = 0;

  @override
  void initState() {
    controller = PageController(initialPage: widget.initialIndex);
    currentPageIndex = widget.initialIndex;
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            onPageChanged: (value) => setState(() => currentPageIndex = value),
            controller: controller,
            children: widget.images
                .map((image) => PinchZoomReleaseUnzoomWidget(
                      child: Image.asset(image),
                    ))
                .toList(),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: widget.images.indexed
                        .map((e) => PageIndicator(selected: e.$1 == currentPageIndex))
                        .toList(),
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SizedBox(
              height: 56,
              child: AppBar(
                title: Text(widget.title),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
