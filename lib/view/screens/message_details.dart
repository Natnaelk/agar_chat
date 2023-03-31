import 'dart:convert';

import 'package:agar_app/api_client.dart';
import 'package:agar_app/helper/pusher_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDetails extends StatefulWidget {
  const MessageDetails({Key key}) : super(key: key);

  @override
  State<MessageDetails> createState() => _MessageDetailsState();
}

class _MessageDetailsState extends State<MessageDetails> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _messageFocus = FocusNode();
  PusherService pusherService = PusherService();
  List<String> messageList = [];
  bool hasFocus = false;

  @override
  void initState() {
    pusherService = PusherService();
    pusherService.startPusher('my-channel', 'my-event');
    focusListner();
    super.initState();
  }

  void focusListner() {
    _messageFocus.addListener(() {
      setState(() {
        hasFocus = true;
      });
    });
  }

  @override
  void dispose() {
    pusherService.unbindEvent('my-event');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey[900],
        flexibleSpace: SafeArea(
          child: Container(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  width: 2,
                ),
                const CircleAvatar(
                  maxRadius: 20,
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Natnael Kebede",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          Text(
                            "Active Now",
                            style: TextStyle(
                                color: Colors.grey.shade400, fontSize: 13),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Container(
                            height: 7,
                            width: 7,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green[500]),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          StreamBuilder(
              stream: pusherService.eventStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  var data = jsonDecode(snapshot.data);
                  messageList.add(data['message']);
                  return ListView.builder(
                    itemCount: messageList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return messageList.length == null || messageList.isEmpty
                          ? const Center(
                              child: Text('No message'),
                            )
                          : Container(
                              padding: const EdgeInsets.only(
                                  left: 14, right: 14, top: 10, bottom: 10),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.grey.shade200,
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Text(
                                    messageList[index],
                                    style: const TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                    },
                  );
                } else {
                  return const Center(child: Text('No messages yet'));
                }
              }),
          SafeArea(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.grey[900],
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        focusNode: _messageFocus,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    hasFocus
                        ? FloatingActionButton(
                            onPressed: () {
                              sendMessage(_controller.text);
                              _controller.clear();
                            },
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 18,
                            ),
                            backgroundColor: Colors.green[400],
                            elevation: 0,
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
