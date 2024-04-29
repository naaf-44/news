part of 'fav_news_bloc.dart';

enum FavNewsStatus { initial, loading, loaded, error }

class FavNewsState extends Equatable {
  final FavNewsStatus favNewsStatus;
  final List<FavNewsModel> favNewsModelList;
  final List<ViewNewsModel> viewNewsModelList;
  final String error;

  const FavNewsState({required this.favNewsStatus, required this.favNewsModelList, required this.viewNewsModelList, required this.error});

  @override
  // TODO: implement props
  List<Object?> get props => [favNewsStatus, favNewsModelList, viewNewsModelList, error];

  factory FavNewsState.initial() {
    return const FavNewsState(favNewsStatus: FavNewsStatus.initial, favNewsModelList: [], viewNewsModelList: [], error: "");
  }

  FavNewsState copyWith({FavNewsStatus? favNewsStatus, List<FavNewsModel>? favNewsModelList, List<ViewNewsModel>? viewNewsModelList, String? error}) {
    return FavNewsState(
      favNewsStatus: favNewsStatus ?? this.favNewsStatus,
      favNewsModelList: favNewsModelList ?? this.favNewsModelList,
      viewNewsModelList: viewNewsModelList ?? this.viewNewsModelList,
      error: error ?? this.error,
    );
  }
}
