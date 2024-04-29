part of 'fav_news_bloc.dart';

abstract class FavNewsEvent extends Equatable {
  const FavNewsEvent();
}

class GetFavNewsEvent extends FavNewsEvent {
  final FavNewsDao favNewsDao;

  const GetFavNewsEvent(this.favNewsDao);

  @override
  // TODO: implement props
  List<Object?> get props => [favNewsDao];
}

class DeleteNewsEvent extends FavNewsEvent {
  final FavNewsDao favNewsDao;
  final String newsKey;

  const DeleteNewsEvent(this.favNewsDao, this.newsKey);

  @override
  // TODO: implement props
  List<Object?> get props => [favNewsDao, newsKey];
}
