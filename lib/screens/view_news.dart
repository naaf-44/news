import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/database_dao/fav_news_dao.dart';
import 'package:news/model_class/viws_news_model.dart';
import 'package:news/utils/string_utils.dart';

class ViewNews extends StatefulWidget {
  final ViewNewsModel? viewNewsModel;

  const ViewNews({Key? key, required this.viewNewsModel}) : super(key: key);

  @override
  State<ViewNews> createState() => _ViewNewsState();
}

class _ViewNewsState extends State<ViewNews> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: ListView(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.viewNewsModel!.newsImageUrl.toString(),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorWidget: (context, str, obj) {
                      return const Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            size: 100,
                          ));
                    },
                    placeholder: (context, str) {
                      return const Center(child: CircularProgressIndicator());
                    },
                  ),
                  isFavorite(),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.viewNewsModel!.newsTitle.toString(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 5),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  size: 20,
                ),
                Text(
                  "${StringUtils.newsDateFormat(
                    widget.viewNewsModel!.newsPublishedAt.toString(),
                  )} GMT",
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 9,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.viewNewsModel!.newsContent.toString(),
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  isFavorite() {
    if (widget.viewNewsModel!.isFavorite ?? false) {
      return const Padding(padding: EdgeInsets.all(5), child: Align(alignment: Alignment.topRight, child: Icon(Icons.favorite, color: Colors.red)));
    } else {
      return FutureBuilder(
          future: getFavoriteData(),
          builder: (context, snapShot) {
            if (snapShot.error == true || snapShot.data == false) {
              return Container();
            } else {
              return const Padding(padding: EdgeInsets.all(5), child: Align(alignment: Alignment.topRight, child: Icon(Icons.favorite, color: Colors.red)));
            }
          });
    }
  }

  Future<bool> getFavoriteData() async {
    final favNewsDao = FavNewsDao();
    await favNewsDao.init();

    int res = await favNewsDao.dataCount(widget.viewNewsModel!.newsKey.toString());
    if (res > 0) {
      return true;
    } else {
      return false;
    }
  }
}
