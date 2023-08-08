import 'package:flutter/material.dart';
import 'package:mc_application/modules/authentication/login/login_page.dart';
import 'package:mc_application/modules/authentication/signup/signup_page.dart';
import 'package:mc_application/modules/chat/chat_page.dart';
import 'package:mc_application/modules/home/home_page.dart';
import 'package:mc_application/modules/init/initial_page.dart';

class RouteNames {
  static const String initial = 'Initial';
  static const String home = 'Home';
  static const String login = 'Login';
  static const String signUp = 'SignUp';
  static const String chat = 'Chat';
}

class RouteCreator {
  static Map<String, BaseRoute> routes = {
    //initial
    RouteNames.initial: BaseRoute(RouteNames.initial, 'Initial', null,
        view: ({settings, params}) => InitialPage()),
    //authentication
    RouteNames.login: BaseRoute(RouteNames.login, 'Login', null,
        view: ({settings, params}) => LoginPage()),
    RouteNames.signUp: BaseRoute(RouteNames.signUp, 'SignUp', null,
        view: ({settings, params}) => SignUpPage()),
    //home
    RouteNames.home: BaseRoute(RouteNames.home, 'Home', null,
        view: ({settings, params}) => HomePage()),
    //chat
    RouteNames.chat: BaseRoute(RouteNames.chat, 'Chat', null,
        view: ({settings, params}) => ChatPage(
              params: params,
            ))
  };
}

class BaseRoute {
  final IconData? icon;
  final String routeName;
  final String routeTitle;
  final Widget Function({
    RouteSettings? settings,
    Map<String, String>? params,
  })? view;

  BaseRoute(this.routeName, this.routeTitle, this.icon, {this.view});
}

BaseRoute? Function(String?) getRoute = (String? routeName) {
  return RouteCreator.routes[routeName];
};
