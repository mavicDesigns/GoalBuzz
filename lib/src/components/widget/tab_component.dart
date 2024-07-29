import 'package:flutter/material.dart';

class TabComponent extends StatelessWidget {
  final int tabCount;
  final List<Widget> tabViews;
  final List<String> tabTitles;
  final String? title;

  const TabComponent({
    Key? key,
    required this.tabCount,
    required this.tabViews,
    required this.tabTitles,
    this.title,
  })  : assert(tabCount > 0, 'tabCount must be greater than 0'),
        assert(tabViews.length == tabCount, 'tabViews length must be equal to tabCount'),
        assert(tabTitles.length == tabCount, 'tabTitles length must be equal to tabCount'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        appBar: AppBar(
          title: Text(title ?? 'Tabs'),
          bottom: TabBar(
            tabs: List.generate(tabCount, (index) => Tab(text: tabTitles[index])),
          ),
        ),
        body: TabBarView(
          children: tabViews,
        ),
      ),
    );
  }
}
