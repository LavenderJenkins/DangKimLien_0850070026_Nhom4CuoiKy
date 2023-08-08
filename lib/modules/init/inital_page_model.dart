import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mc_application/core/bases/base_page_model.dart';
import 'package:mc_application/core/helpers/navigator_helper.dart';
import 'package:mc_application/routes/route_config.dart';
import 'package:page_transition/page_transition.dart';

class InitialPageModel extends BasePageModel {
  void redirectPage(BuildContext context) async {
    Timer(const Duration(milliseconds: 500), () {
      navigatorHelper.changeView(context, RouteNames.login,
          isReplaceName: true, type: PageTransitionType.fade);
    });
  }
}
