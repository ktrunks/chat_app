import 'package:fluro/fluro.dart';

import 'chat_route_handlers.dart';

///
class ChatRoutes {
  ///
  static late FluroRouter router;

  /// root end point
  static const String root = "/";

  /// home screen
  static const String home = "/home";

  /// sign screen
  static const String signIn = "/sign";

  /// webview screen
  static const String webView = "/web_view";

  static const String addNote = "/add_note";

  static const String changePassword = "/change_password ";

  /// configuring routes
  static void configureRoutes(FluroRouter router) {
    router.define(root,
        handler: rootHandler, transitionType: TransitionType.inFromRight);
    router.define(home,
        handler: homeHandler, transitionType: TransitionType.inFromRight);
  }
}
