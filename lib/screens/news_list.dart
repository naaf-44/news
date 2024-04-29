import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable_panel/flutter_slidable_panel.dart';
import 'package:news/bloc/news_bloc/news_bloc.dart';
import 'package:news/widgets/news_slide_panel.dart';

class NewsList extends StatefulWidget {
  const NewsList({Key? key}) : super(key: key);

  @override
  State<NewsList> createState() => _NewsListState();
}

class _NewsListState extends State<NewsList> {
  final SlideController slideController = SlideController(usePostActionController: true);
  BuildContext? newsBlocContext;

  @override
  void dispose() {
    super.dispose();
    slideController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(const GetNewsListEvent()),
      child: BlocConsumer<NewsBloc, NewsState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          newsBlocContext = context;
          if (state.newsStatus == NewsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.newsStatus == NewsStatus.error) {
            return Text(state.error.toString());
          } else {
            if (state.newsListModel.articles == null) {
              return Center(
                child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(state.newsListModel.message == null ? "No Data Found" : state.newsListModel.message!)),
              );
            } else {
              return ListView.builder(
                itemCount: state.newsListModel.articles!.length,
                shrinkWrap: true,
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
                      child: NewsSlidePanel(newsState: state, index: index, newsBlocContext: newsBlocContext),
                    ),
                  );
                },
              );
            }
          }
        },
      ),
    );
  }
}
