import 'package:chat/application/chat_application_provider.dart';
import 'package:chat/model/message.dart';
import 'package:chat/provider/home_provider.dart';
import 'package:chat/util/color/colors.dart';
import 'package:chat/util/enum.dart';
import 'package:chat/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HomeProvider homeProvider = Provider.of<HomeProvider>(context);
    final ChatApplicationProvider applicationProvider =
        Provider.of<ChatApplicationProvider>(context);
    return SafeArea(
      child: Scaffold(
        key: homeProvider.scaffoldKey,
        appBar: AppBar(title: Text("Chat")),
        body: Column(
          children: [
            Selector<HomeProvider, NetWorkResponseStatus>(
                builder: (context, data, child) {
                  NetWorkResponseStatus responseStatus = data;
                  late Widget notesWidget;
                  switch (data) {
                    case NetWorkResponseStatus.ResponseData:
                      notesWidget =
                          chatWidget(homeProvider.messages, homeProvider);
                      break;
                    case NetWorkResponseStatus.ResponseError:
                      Center(child: Text('${homeProvider.error}'));
                      break;
                    case NetWorkResponseStatus.ResponseEmpty:
                      notesWidget = Center(child: Text('No Notes'));
                      break;
                    case NetWorkResponseStatus.NetworkError:
                      notesWidget = Center(child: Text('Internet Error'));
                      break;
                    case NetWorkResponseStatus.Loading:
                      notesWidget = CustomProgressIndicator();
                      break;
                  }
                  return Expanded(child: notesWidget);
                },
                selector: (buildContext, provider) => provider.responseStatus),
            Row(
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: new TextField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: homeProvider.textEditingController,
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 1.0),
                          ),
                          hintText: 'message',
                        ),
                      ),
                    ),
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: new Icon(Icons.send),
                    onPressed: () => homeProvider.sendMessage(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget chatWidget(List<Messages> message, HomeProvider homeProvider) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: message.length,
      scrollDirection: Axis.vertical,
      reverse: true,
      physics: const ScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return homeProvider.messages.reversed.elementAt(index).userName ==
                homeProvider.userName
            ? chatMessageDisplayWidget(const EdgeInsets.only(left: 50),
                homeProvider.messages.reversed.elementAt(index).message)
            : chatMessageDisplayWidget(const EdgeInsets.only(right: 50),
                homeProvider.messages.reversed.elementAt(index).message);
      },
    );
  }

  Widget chatMessageDisplayWidget(EdgeInsetsGeometry padding, String message) {
    return Padding(
      padding: padding,
      child: Container(
        child: Text(
          message,
          style: TextStyle(color: primaryColor),
        ),
        padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
        width: 200.0,
        decoration: BoxDecoration(
            color: brownishGreyColor, borderRadius: BorderRadius.circular(8.0)),
        margin: EdgeInsets.only(bottom: 10.0, right: 10.0, left: 10),
      ),
    );
  }
}
