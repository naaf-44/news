import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/model_class/fav_news_model.dart';
import 'package:news/model_class/viws_news_model.dart';

part 'fav_news_event.dart';

part 'fav_news_state.dart';

class FavNewsBloc extends Bloc<FavNewsEvent, FavNewsState> {
  FavNewsBloc() : super(FavNewsState.initial()) {
    on<FavNewsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetFavNewsEvent>((event, emit) async {
      emit(state.copyWith(favNewsStatus: FavNewsStatus.loading));
      try {
        await event.favNewsDao.init();
        final resultList = await event.favNewsDao.getFavNews();
        List<FavNewsModel> favNewsModelList = [];
        List<ViewNewsModel> viewNewsModelList = [];

        for (final rows in resultList) {
          favNewsModelList.add(FavNewsModel(
            favNewsId: rows[FavNewsDao.favNewsId].toString(),
            favNewsKey: rows[FavNewsDao.favNewsKey],
            favNewsTitle: rows[FavNewsDao.favNewsTitle],
            favNewsDesc: rows[FavNewsDao.favNewsDesc],
            favNewsContent: rows[FavNewsDao.favNewsContent],
            favNewsPublishedAt: rows[FavNewsDao.favNewsPublishedAt],
            favNewsImageUrl: rows[FavNewsDao.favNewsImageUrl],
          ));
          viewNewsModelList.add(ViewNewsModel(
            newsId: rows[FavNewsDao.favNewsId].toString(),
            newsKey: rows[FavNewsDao.favNewsKey],
            newsTitle: rows[FavNewsDao.favNewsTitle],
            newsDesc: rows[FavNewsDao.favNewsDesc],
            newsContent: rows[FavNewsDao.favNewsContent],
            newsPublishedAt: rows[FavNewsDao.favNewsPublishedAt],
            newsImageUrl: rows[FavNewsDao.favNewsImageUrl],
            isFavorite: true,
          ));
        }
        emit(state.copyWith(favNewsStatus: FavNewsStatus.loaded, favNewsModelList: favNewsModelList, viewNewsModelList: viewNewsModelList));
      } catch (e) {
        emit(state.copyWith(favNewsStatus: FavNewsStatus.error, error: e.toString()));
      }
    });

    on<DeleteNewsEvent>((event, emit) async {
      int res = await event.favNewsDao.deleteFavNews(event.newsKey);
      final resultList = await event.favNewsDao.getFavNews();
      List<FavNewsModel> favNewsModelList = [];
      List<ViewNewsModel> viewNewsModelList = [];

      for (final rows in resultList) {
        favNewsModelList.add(FavNewsModel(
          favNewsId: rows[FavNewsDao.favNewsId].toString(),
          favNewsKey: rows[FavNewsDao.favNewsKey],
          favNewsTitle: rows[FavNewsDao.favNewsTitle],
          favNewsDesc: rows[FavNewsDao.favNewsDesc],
          favNewsContent: rows[FavNewsDao.favNewsContent],
          favNewsPublishedAt: rows[FavNewsDao.favNewsPublishedAt],
          favNewsImageUrl: rows[FavNewsDao.favNewsImageUrl],
        ));
        viewNewsModelList.add(ViewNewsModel(
          newsId: rows[FavNewsDao.favNewsId].toString(),
          newsKey: rows[FavNewsDao.favNewsKey],
          newsTitle: rows[FavNewsDao.favNewsTitle],
          newsDesc: rows[FavNewsDao.favNewsDesc],
          newsContent: rows[FavNewsDao.favNewsContent],
          newsPublishedAt: rows[FavNewsDao.favNewsPublishedAt],
          newsImageUrl: rows[FavNewsDao.favNewsImageUrl],
          isFavorite: true,
        ));
      }
      emit(state.copyWith(favNewsStatus: FavNewsStatus.loaded, favNewsModelList: favNewsModelList, viewNewsModelList: viewNewsModelList));
      print("RES: $res");
    });
  }
}
