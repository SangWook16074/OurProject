import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_main_page/src/components/font_text.dart';
import 'package:flutter_main_page/src/controller/event_controller.dart';
import 'package:flutter_main_page/src/data/model/event_model.dart';
import 'package:get/get.dart';
import '../View_pages/event_view.dart';

class EventPage extends GetView<EventController> {
  final String userNumber;
  EventPage(this.userNumber, {Key? key}) : super(key: key);

  userCheck(List usersList, String userNumber) {
    if (usersList.contains(userNumber)) {
      usersList.remove(userNumber);
    } else {
      usersList.add(userNumber);
    }
    return usersList;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(
        () => Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData.fallback(),
            backgroundColor: Colors.white,
            title: FontText(
              text: '이벤트',
              type: FontType.SUB,
              fontSize: 25,
            ),
            centerTitle: true,
          ),
          resizeToAvoidBottomInset: true,
          body: ListView.builder(
              itemCount: controller.events.length,
              itemBuilder: (context, index) {
                final eventModel = controller.events[index];
                return _buildItemWidget(eventModel);
              }),
        ),
      ),
    );
  }

  Widget _buildItemWidget(EventModel eventModel) {
    return GestureDetector(
      onTap: () => Get.to(() => EventViewPage(
            eventModel: eventModel,
          )),
      child: Column(
        children: [
          ListTile(
              visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
              title: Text(
                eventModel.title,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                Text(eventModel.countLike.toString()),
                IconButton(
                    icon: Icon(Icons.favorite,
                        color: eventModel.likedUsersList.contains(userNumber)
                            ? Colors.red
                            : Colors.grey),
                    onPressed: () {
                      controller.updatelikedUsersList(eventModel.documentId!,
                          userNumber, eventModel.likedUsersList);
                      controller.updatecountLike(
                          eventModel.documentId!, eventModel.likedUsersList);
                    }),
              ])),
          SizedBox(
            height: 10,
          ),
          (eventModel.url != '')
              ? Container(
                  width: Get.size.width,
                  height: Get.size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Container(
                        width: Get.size.width,
                        child: CachedNetworkImage(
                          imageUrl: eventModel.url,
                          fit: BoxFit.fill,
                          placeholder: (context, url) => Container(
                            color: Colors.black,
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )))
              : Container(),
          Divider(),
        ],
      ),
    );
  }
}
