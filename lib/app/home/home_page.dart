
import 'package:flutter/material.dart';
import 'package:tellus_mockup/app/home/account/account_page.dart';
import 'package:tellus_mockup/app/home/cupertino_home_scaffold.dart';
import 'package:tellus_mockup/app/home/entries/entries_page.dart';
import 'package:tellus_mockup/app/home/jobs/jobs_page.dart';
import 'package:tellus_mockup/app/home/posts/posts_page.dart';
import 'package:tellus_mockup/app/home/tab_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.posts;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.posts: GlobalKey<NavigatorState>(),
    TabItem.jobs: GlobalKey<NavigatorState>(),
    TabItem.entries: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.posts: (_) => PostsPage(),
      TabItem.jobs: (_) => JobsPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  void _select(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
        currentTab: _currentTab,
        onSelectTab: _select,
        widgetBuilders: widgetBuilders,
        navigatorKeys: navigatorKeys,
      ),
    );
  }

}
