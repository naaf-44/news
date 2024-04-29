import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:news/bloc/news_bloc/news_bloc.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/model_class/viws_news_model.dart';
import 'package:news/screens/view_news.dart';
import 'package:news/widgets/news_tile.dart';

class NewsSlidePanel extends StatefulWidget {
  final NewsState newsState;
  final int index;
  final BuildContext? newsBlocContext;

  const NewsSlidePanel({Key? key, required this.newsState, required this.index, required this.newsBlocContext}) : super(key: key);

  @override
  State<NewsSlidePanel> createState() => _NewsSlidePanelState();
}

class _NewsSlidePanelState extends State<NewsSlidePanel> {
  final SlideController slideController = SlideController(usePostActionController: true);
  final favNewsDao = FavNewsDao();

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    favNewsDao.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SlidablePanel(
      controller: slideController,
      maxSlideThreshold: 0.3,
      postActions: [
        InkWell(
          onTap: () {
            widget.newsBlocContext!.read<NewsBloc>().add(AddFavoriteNewsEvent(favNewsDao, widget.newsState.newsListModel.articles![widget.index]));
            slideController.dismiss();
          },
          child: Container(
            color: Colors.red.shade100,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.favorite, color: Colors.red),
                SizedBox(height: 5),
                Text(
                  "Add to \nFavorite",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
      child: NewsTile(
        viewNewsModel: widget.newsState.viewNewsModelList[widget.index],
        function: () {
          viewNews(widget.newsState.viewNewsModelList[widget.index]);
        },
      ),
    );
  }

  viewNews(ViewNewsModel viewNewsModel) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNews(viewNewsModel: viewNewsModel)));
  }
}
