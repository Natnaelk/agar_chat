import 'dart:async';

import 'package:flutter/services.dart';
import 'package:pusher_websocket_flutter/pusher.dart';

class PusherService {
  Event lastEvent;
  String lastConnectionState;
  Channel channel;
  StreamController<String> _eventData = StreamController<String>();
  Sink get _inEventData => _eventData.sink;
  Stream get eventStream => _eventData.stream;
  Future<void> initPusher() async {
    try {
      await Pusher.init('accd6364089f3fa5e749', PusherOptions(cluster: 'mt1'));
    } on PlatformException catch (e) {
      print(e.message);
    }
  }

  void connectPusher() {
    Pusher.connect(
        onConnectionStateChange: (ConnectionStateChange connectionState) async {
      lastConnectionState = connectionState.currentState;
    }, onError: (ConnectionError e) {
      print("Error: ${e.message}");
    });
  }

  Future<void> subscribePusher(String channelName) async {
    channel = await Pusher.subscribe(channelName);
  }

  void unSubscribePusher(String channelName) {
    Pusher.unsubscribe(channelName);
  }

  void bindEvent(String eventName) {
    channel.bind(eventName, (last) {
      final String data = last.data;
      _inEventData.add(data);
    });
  }

  void unbindEvent(String eventName) {
    channel.unbind(eventName);
    _eventData.close();
  }

  Future<void> startPusher(String channelName, String eventName) async {
    await initPusher();
    connectPusher();
    await subscribePusher(channelName);
    bindEvent(eventName);
  }
}
