import 'package:flutter/material.dart';
import 'package:news/api_request/news_request.dart';
import 'package:news/model_class/news_list_model.dart';
import 'package:news/screens/fav_news_list.dart';
import 'package:news/screens/news_list.dart';
import 'package:news/widgets/tab_bar_child.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {

  NewsListModel? newsListModel;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: Colors.transparent,
            dividerColor: Colors.transparent,
            indicator: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.grey.shade300),
            indicatorPadding: const EdgeInsets.all(5),
            tabs: const [
              TabBarChild(
                text: "News",
                iconData: Icons.list,
              ),
              TabBarChild(
                text: "Favs",
                iconData: Icons.favorite,
                iconColor: Colors.red,
              ),
            ],
            onTap: (val) {},
          ),
        ),
        body: const TabBarView(
          children: [NewsList(), FavNewsList()],
        ),
      ),
    );
  }
}
