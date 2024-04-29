part of 'news_bloc.dart';

enum NewsStatus { initial, loading, loaded, error }

class NewsState extends Equatable {
  final NewsStatus newsStatus;
  final NewsListModel newsListModel;
  final List<ViewNewsModel> viewNewsModelList;
  final String error;

  const NewsState({required this.newsStatus, required this.newsListModel, required this.viewNewsModelList, required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [newsStatus, newsListModel, viewNewsModelList, error];

  factory NewsState.initial() {
    return NewsState(newsStatus: NewsStatus.initial, newsListModel: NewsListModel(), viewNewsModelList: const [], error: "");
  }

  NewsState copyWith({NewsStatus? newsStatus, NewsListModel? newsListModel, List<ViewNewsModel>? viewNewsModelList, String? error}) {
    return NewsState(
      newsStatus: newsStatus ?? this.newsStatus,
      newsListModel: newsListModel ?? this.newsListModel,
      viewNewsModelList: viewNewsModelList ?? this.viewNewsModelList,
      error: error ?? this.error,
    );
  }
}
