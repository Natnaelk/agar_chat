import 'package:agar_app/view/screens/message_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationListWidget extends StatefulWidget {
  String name;
  String messageText;
  String imageUrl;
  String time;
  ConversationListWidget({
    @required this.name,
    @required this.messageText,
    this.imageUrl,
    @required this.time,
  });
  @override
  _ConversationListWidgetState createState() => _ConversationListWidgetState();
}

class _ConversationListWidgetState extends State<ConversationListWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(const MessageDetails());
      },
      child: Container(
        decoration:
            BoxDecoration(boxShadow: [BoxShadow(color: Colors.grey[700])]),
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name,
                            style: const TextStyle(
                                fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13, color: Colors.grey[400]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle, color: Colors.green),
                  child: Center(
                      child: Text(
                    '2',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  widget.time,
                  style: TextStyle(color: Colors.grey[400], fontSize: 12),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
