class ViewNewsModel {
  final String? newsId;
  final String? newsKey;
  final String? newsTitle;
  final String? newsDesc;
  final String? newsContent;
  final String? newsPublishedAt;
  final String? newsImageUrl;
  final bool? isFavorite;

  ViewNewsModel({this.newsId, this.newsKey, this.newsTitle, this.newsDesc, this.newsContent, this.newsPublishedAt, this.newsImageUrl, this.isFavorite = false});
}
