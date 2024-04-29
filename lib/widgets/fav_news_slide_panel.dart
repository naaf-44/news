import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:news/bloc/fav_news_bloc/fav_news_bloc.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/model_class/viws_news_model.dart';
import 'package:news/screens/view_news.dart';
import 'package:news/widgets/news_tile.dart';

class FavNewsSlidePanel extends StatefulWidget {
  final List<ViewNewsModel> viewNewsModelList;
  final int index;
  final BuildContext? favNewsBlocContext;
  final FavNewsDao favNewsDao;

  const FavNewsSlidePanel({Key? key, required this.viewNewsModelList, required this.index, required this.favNewsBlocContext, required this.favNewsDao})
      : super(key: key);

  @override
  State<FavNewsSlidePanel> createState() => _FavNewsSlidePanelState();
}

class _FavNewsSlidePanelState extends State<FavNewsSlidePanel> {
  final SlideController slideController = SlideController(usePostActionController: true);

  @override
  void dispose() {
    slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlidablePanel(
      controller: slideController,
      maxSlideThreshold: 0.3,
      postActions: [
        InkWell(
          onTap: () async {
            widget.favNewsBlocContext!.read<FavNewsBloc>().add(DeleteNewsEvent(widget.favNewsDao, widget.viewNewsModelList[widget.index].newsKey.toString()));
            widget.favNewsBlocContext!.read<FavNewsBloc>().add(GetFavNewsEvent(widget.favNewsDao));
            slideController.dismiss();
          },
          child: Container(
            color: Colors.red.shade100,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.delete, color: Colors.red),
                SizedBox(height: 5),
                Text(
                  "Delete",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
      child: NewsTile(
        viewNewsModel: widget.viewNewsModelList[widget.index],
        function: () {
          viewNews(widget.viewNewsModelList![widget.index]);
        },
      ),
    );
  }

  viewNews(ViewNewsModel viewNewsModel) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ViewNews(viewNewsModel: viewNewsModel)));
  }
}
