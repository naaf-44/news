import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news/model_class/news_list_model.dart';
import 'package:news/model_class/viws_news_model.dart';
import 'package:news/utils/string_utils.dart';

class NewsTile extends StatefulWidget {
  final ViewNewsModel? viewNewsModel;
  final VoidCallback? function;

  const NewsTile({Key? key, required this.viewNewsModel, required this.function}) : super(key: key);

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.function,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CachedNetworkImage(
                imageUrl: widget.viewNewsModel!.newsImageUrl.toString(),
                fit: BoxFit.cover,
                width: 80,
                height: 80,
                errorWidget: (context, str, obj) {
                  return const Center(
                      child: Icon(
                    Icons.broken_image_rounded,
                    size: 50,
                  ));
                },
                placeholder: (context, str) {
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.viewNewsModel!.newsTitle.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.viewNewsModel!.newsContent.toString(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        size: 20,
                      ),
                      Text(
                        "${StringUtils.newsDateFormat(widget.viewNewsModel!.newsPublishedAt.toString())} GMT",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 9,
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
