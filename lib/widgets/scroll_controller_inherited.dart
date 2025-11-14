import 'package:flutter/material.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class ScrollControllerInherited extends InheritedWidget {
  final AutoScrollController scrollController;

  const ScrollControllerInherited({
    super.key,
    required super.child,
    required this.scrollController,
  });

  static AutoScrollController? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ScrollControllerInherited>()?.scrollController;
  }

  @override
  bool updateShouldNotify(ScrollControllerInherited oldWidget) => false;
}