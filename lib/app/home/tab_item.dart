
import 'package:flutter/material.dart';

enum TabItem { posts, jobs, entries, account }

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.posts: TabItemData(title: 'Posts', icon: Icons.dehaze),
    TabItem.jobs: TabItemData(title: 'Jobs', icon: Icons.work),
    TabItem.entries: TabItemData(title: 'Entries', icon: Icons.view_headline),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}