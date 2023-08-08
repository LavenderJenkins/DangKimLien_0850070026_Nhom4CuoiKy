import 'package:flutter/material.dart';
import 'package:mc_application/routes/route_config.dart';

class Router {
  static Route generateRoute(RouteSettings settings) {
    // if ("${DotEnv().env['ENV']}" != 'production') {
    //   BaseRoute route = getRoute(settings.name)!;
    //   Widget? view = route.view!(settings: settings);

    //   if (view != null) {
    //     return MaterialPageRoute(builder: (_) => view);
    //   } else {
    //     return MaterialPageRoute(
    //         builder: (_) => const Scaffold(
    //               body:
    //                   Center(child: Text('Chức năng này đang được phát triển')),
    //             ));
    //   }
    // } else {
    // }
    BaseRoute route = getRoute(settings.name)!;
    Widget? view = route.view!(settings: settings);

    if (view != null) {
      return MaterialPageRoute(builder: (_) => view);
    } else {
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                body: Center(child: Text('Chức năng này đang được phát triển')),
              ));
    }
  }
}
