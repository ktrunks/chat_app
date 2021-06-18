import 'package:chat/application/chat_application_provider.dart';
import 'package:chat/routes/chat_routes.dart';
import 'package:chat/util/color/colors.dart';
import 'package:fluro/fluro.dart' as route;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Application class
class ChatApp extends StatefulWidget {
  /// shared preference object
  // final SharedPreferences sharedPreferences;

  /// constructor with shared preference object
  ChatApp();

  @override
  _ChatAppState createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ChatApplicationProvider>(
            create: (_) => ChatApplicationProvider()),
      ],
      child: MaterialApp(
        initialRoute: ChatRoutes.root,
        debugShowCheckedModeBanner: false,
        title: 'Chat App',
        onGenerateRoute: ChatRoutes.router.generator,
        theme: ThemeData(
          primaryColor: primaryColor,
          backgroundColor: primaryColor,
          buttonColor: primaryColor,
          accentColor: primaryColor,
          primarySwatch: secondaryPrimarySwatchColor,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final router = route.FluroRouter();
    ChatRoutes.router = router;
    ChatRoutes.configureRoutes(router);
  }

  ///
  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}
