import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/bloc/fav_news_bloc/fav_news_bloc.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/widgets/fav_news_slide_panel.dart';

class FavNewsList extends StatefulWidget {
  const FavNewsList({Key? key}) : super(key: key);

  @override
  State<FavNewsList> createState() => _FavNewsListState();
}

class _FavNewsListState extends State<FavNewsList> {
  final favNewsDao = FavNewsDao();
  BuildContext? favNewsBlocContext;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FavNewsBloc()..add(GetFavNewsEvent(favNewsDao)),
        child: BlocConsumer<FavNewsBloc, FavNewsState>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            return previous != current && current.favNewsStatus == FavNewsStatus.loaded;
          },
          builder: (context, state) {
            favNewsBlocContext = context;
            if (state.favNewsStatus == FavNewsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.favNewsStatus == FavNewsStatus.error) {
              return Text(state.error.toString());
            } else {
              if (state.favNewsModelList.isEmpty) {
                return const Center(
                  child: Text("No Data Found"),
                );
              } else {
                return ListView.builder(
                    itemCount: state.viewNewsModelList.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                          boxShadow: const [BoxShadow(color: Colors.grey, blurRadius: 15, offset: Offset(0.0, 0.75))],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: FavNewsSlidePanel(
                            favNewsBlocContext: favNewsBlocContext,
                            index: index,
                            viewNewsModelList: state.viewNewsModelList,
                            favNewsDao: favNewsDao,
                          ),
                        ),
                      );
                    });
              }
            }
          },
        ));
  }
}
