import 'package:chat_app/src/constants/colors.dart';
import 'package:chat_app/src/constants/gradients.dart';
import 'package:chat_app/src/screens/auth/components/auth_views.dart';
import 'package:chat_app/src/screens/chats/chats_gql.dart';
import 'package:chat_app/src/screens/chats/model.dart';
import 'package:chat_app/src/screens/messages/messages.dart';
import 'package:chat_app/src/screens/settings/settings.dart';
import 'package:chat_app/src/screens/users/users.dart';
import 'package:chat_app/src/state/app_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:provider/provider.dart';

class ChatListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(body: body(context));

  Widget body(context) {
    return Container(
      child: Column(
        children: <Widget>[
          mainListComponent(context),
          bottomBarComponent(context)
        ],
      ),
    );
  }

  Widget mainListComponent(context) {
    return Expanded(
      flex: 1,
      child: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Container(margin: EdgeInsets.only(top: 40)),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: gradientTextComponent(
              BLUE_GRADIENT,
              "Your Chats",
              align: TextAlign.start,
              size: 36,
            ),
          ),
          Container(margin: EdgeInsets.only(top: 20)),
          chatQueryComponent(context)
        ],
      ),
    );
  }

  Widget chatQueryComponent(context) {
    final appState = Provider.of<AppState>(context);

    return Query(
      options: QueryOptions(
        documentNode: gql(getChatsQuery),
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        pollInterval: 15,
        context: {
          'headers': <String, String>{
            'Authorization': 'Bearer ${appState.token}',
          },
        },
      ),
      builder: (result, {refetch, fetchMore}) {
        if (result.loading) return Center(child: CupertinoActivityIndicator());
        if (result.hasException)
          return Center(child: Text("Oops something went wrong"));

        if (result.data != null && result.data['getChats'] != null) {
          var chatList = ChatListModel.fromJson(result.data['getChats']);
          return chatListComponent(chatList.chats ?? []);
        }
        return Container();
      },
    );
  }

  Widget chatListComponent(List<ChatModel> chats) {
    return ListView.separated(
      separatorBuilder: (context, index) => Divider(indent: 60, height: 0),
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: chats.length ?? 0,
      itemBuilder: (context, index) => chatItem(context, chats[index]),
    );
  }

  Widget chatItem(context, ChatModel chat) {
    return InkWell(
      splashColor: ORANGE_SHADOW,
      highlightColor: WHITE_COLOR.withOpacity(.5),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MessageScreen(chatDetails: chat)),
        );
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(margin: EdgeInsets.only(left: 10)),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    chat.name,
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                  Container(margin: EdgeInsets.only(top: 5)),
                  Text(
                    chat.lastMessage ?? '',
                    maxLines: 1,
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      color: Color(0xFF979797),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomBarComponent(context) {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(OMIcons.settings),
            color: Colors.grey[500],
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SettingScreen()));
            },
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => UserListScreen()));
            },
            child: Container(
              height: 55,
              width: 170,
              padding: EdgeInsets.only(left: 15),
              decoration: BoxDecoration(
                gradient: BRIGHT_ORANGE_GRADIENT,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add, size: 22, color: WHITE_COLOR),
                  Container(margin: EdgeInsets.only(left: 10)),
                  Text(
                    "NEW CHAT",
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w500,
                      color: WHITE_COLOR,
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
