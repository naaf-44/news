part of 'news_bloc.dart';

abstract class NewsEvent extends Equatable {
  const NewsEvent();
}

class GetNewsListEvent extends NewsEvent {
  const GetNewsListEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddFavoriteNewsEvent extends NewsEvent {
  final FavNewsDao favNewsDao;
  final Articles articles;

  const AddFavoriteNewsEvent(this.favNewsDao, this.articles);

  @override
  // TODO: implement props
  List<Object?> get props => [favNewsDao, articles];
}
