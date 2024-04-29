import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/api_request/news_request.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/model_class/news_list_model.dart';
import 'package:news/model_class/viws_news_model.dart';
import 'package:news/utils/string_utils.dart';

part 'news_event.dart';

part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  NewsBloc() : super(NewsState.initial()) {
    on<NewsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetNewsListEvent>((event, emit) async {
      emit(state.copyWith(newsStatus: NewsStatus.loading));
      try {
        NewsListModel newsListModel = await NewsRequest.getNewsList();
        List<ViewNewsModel> viewNewsModelList = [];
        if (newsListModel.articles != null) {
          for (final article in newsListModel.articles!) {
            viewNewsModelList.add(ViewNewsModel(
              newsKey: StringUtils.favNewsKey(article.publishedAt.toString()),
              newsTitle: article.title,
              newsContent: article.content,
              newsDesc: article.description,
              newsPublishedAt: article.publishedAt,
              newsImageUrl: article.urlToImage,
            ));
          }
        }
        emit(state.copyWith(newsStatus: NewsStatus.loaded, newsListModel: newsListModel,viewNewsModelList: viewNewsModelList));
      } catch (e) {
        emit(state.copyWith(newsStatus: NewsStatus.error, error: e.toString()));
      }
    });

    on<AddFavoriteNewsEvent>((event, emit) async {
      Map<String, dynamic> data = {
        FavNewsDao.favNewsKey: StringUtils.favNewsKey(event.articles.publishedAt.toString()),
        FavNewsDao.favNewsTitle: event.articles.title.toString(),
        FavNewsDao.favNewsDesc: event.articles.description.toString(),
        FavNewsDao.favNewsContent: event.articles.content.toString(),
        FavNewsDao.favNewsPublishedAt: event.articles.publishedAt.toString(),
        FavNewsDao.favNewsImageUrl: event.articles.urlToImage.toString(),
      };

      print("KEY: ${StringUtils.favNewsKey(event.articles.publishedAt.toString())}");
      int count = await event.favNewsDao.dataCount(StringUtils.favNewsKey(event.articles.publishedAt.toString()));
      print("COUNT: $count");
      if (count == 0) {
        final id = await event.favNewsDao.insert(data);
        print("INSERTED_ID: $id");
      } else {
        print("DATA ALREADY INSERTED");
      }
    });
  }
}
