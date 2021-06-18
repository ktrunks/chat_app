import 'package:chat/model/message.dart';
import 'package:chat/util/enum.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../base_state.dart';

class HomeProvider extends BaseState {
  String userName;

  HomeProvider(this.userName) {
    getNotes();
  }

  NetWorkResponseStatus responseStatus = NetWorkResponseStatus.Loading;
  List<Messages> messages = [];
  String responseError = 'z';
  TextEditingController textEditingController = TextEditingController();

  void getNotes() {
    FirebaseFirestore.instance
        .collection("messages")
        .orderBy('timestamp')
        .snapshots()
        .listen((querySnapshot) {
      if (querySnapshot.size > 0) {
        messages.clear();
        querySnapshot.docs.forEach((query) {
          debugPrint('chat --- ${query.data()}');
          messages.add(Messages.fromJson(query.data()));
          responseStatus = NetWorkResponseStatus.ResponseData;
          notifyListeners();
        });
      } else {
        responseStatus = NetWorkResponseStatus.ResponseEmpty;
        notifyListeners();
      }
    });
  }

  sendMessage() {
    if (textEditingController.text.trim().isNotEmpty)
      firebaseSend(FirebaseFirestore.instance.collection("messages").doc());
  }

  void firebaseSend(DocumentReference docReference, {imageUrl}) {
    Map<String, dynamic> data = {
      'message': textEditingController.text.trim(),
      'timestamp': DateTime.now().millisecondsSinceEpoch.toString(),
      'user_name': userName
    };

    updateProgressIndicatorStatus(true);
    docReference.set(data).then((result) {
      debugPrint('message sent succesfully');
      updateProgressIndicatorStatus(false);
      textEditingController.clear();
    }).catchError((error) {
      updateErrorWidget('error');
      updateProgressIndicatorStatus(false);
    });
  }
}
