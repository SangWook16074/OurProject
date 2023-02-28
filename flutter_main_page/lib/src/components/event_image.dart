import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventImage extends StatelessWidget {
  final String url;
  const EventImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Get.size.width,
        height: Get.size.width,
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Container(
              width: Get.size.width,
              child: CachedNetworkImage(
                imageUrl: url,
                fit: BoxFit.fill,
                placeholder: (context, url) => Container(
                  color: Colors.black,
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )));
  }
}
