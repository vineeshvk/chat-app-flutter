import 'package:chat_app/src/screens/auth/auth.dart';
import 'package:chat_app/src/screens/chats/chats.dart';
import 'package:chat_app/src/state/app_state.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  final bool auth;
  final client;
  App({this.auth = false, this.client});

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: ChangeNotifierProvider<AppState>(
          builder: (_) => AppState(),
          child: MaterialAppWidget(auth: auth),
        ),
      ),
    );
  }
}

// have to create a new class inorder to use the provider
class MaterialAppWidget extends StatelessWidget {
  final bool auth;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  MaterialAppWidget({this.auth = false}) {
    _firebaseMessaging.configure();
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness:
            appState.currentTheme.brightness == Brightness.dark
                ? Brightness.light
                : Brightness.dark,
      ),
    );

    return MaterialApp(
      theme: appState.currentTheme,
      title: "chat app",
      home: auth ? ChatListScreen() : AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
