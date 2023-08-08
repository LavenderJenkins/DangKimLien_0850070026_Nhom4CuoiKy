import 'package:flutter/material.dart';
import 'package:mc_application/app_data.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/bases/base_mixin_model.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/core/widgets/loading/loading_widget.dart';
import 'package:mc_application/modules/init/inital_page_model.dart';
import 'package:mc_application/resources/modal_progress_hud.dart';
import 'package:need_resume/need_resume.dart';

class InitialPage extends StatefulWidget {
  const InitialPage({super.key});

  @override
  State<InitialPage> createState() => _InitialPageState();
}

class _InitialPageState extends ResumableState<InitialPage>
    with MixinModel<InitialPageModel> {
  final InitialPageModel initialPageModel = InitialPageModel();

  @override
  void onReady() {
    super.onReady();
    initialPageModel.redirectPage(context);
  }

  @override
  InitialPageModel withModel() {
    return initialPageModel;
  }

  @override
  Widget build(BuildContext context) {
    return present(context);
  }

  @override
  Function(BuildContext ctx, InitialPageModel model, Widget? child)
      withBuilder() {
    return (BuildContext context, InitialPageModel model, Widget? child) {
      return ModalProgressHUD(
          progressIndicator: const Loading(),
          inAsyncCall: initialPageModel.busy,
          child: buildBody(context));
    };
  }

  Stack buildBody(context) {
    //get screen info
    appData.widthScreen = screenHelper.getOriginWidth(context);
    appData.heightScreen = screenHelper.getOriginHeight(context);
    return const Stack(
      children: [
        SafeArea(
            child: Scaffold(
          backgroundColor: backgroundColor,
          body: Center(
            child: Text(
              'Chat app',
              style: TextStyle(
                  color: primaryGreen,
                  fontSize: 50,
                  fontWeight: FontWeight.w300),
            ),
          ),
        ))
      ],
    );
  }
}
