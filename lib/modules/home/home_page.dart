import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/bases/base_mixin_model.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/core/widgets/loading/loading_widget.dart';
import 'package:mc_application/modules/home/home_page_model.dart';
import 'package:mc_application/modules/home/widgets/add_friend_button_widget.dart';
import 'package:mc_application/modules/home/widgets/conversation_widget.dart';
import 'package:mc_application/modules/home/widgets/navbar_widget.dart';
import 'package:mc_application/resources/modal_progress_hud.dart';
import 'package:need_resume/need_resume.dart';
import 'package:remixicon/remixicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ResumableState<HomePage>
    with MixinModel<HomePageModel> {
  HomePageModel homePageModel = HomePageModel();
  double widthScreen = screenHelper.getWidth();
  double heightScreen = screenHelper.getHeight();
  double yPadding = screenHelper.getHeightByPercent(0.02);
  double xPadding = screenHelper.getWidthByPercent(0.03);

  @override
  void initState() {
    homePageModel.initializeSocketService();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return present(context);
  }

  @override
  Function(BuildContext ctx, HomePageModel model, Widget? child) withBuilder() {
    return (BuildContext context, HomePageModel model, Widget? child) {
      return ModalProgressHUD(
          inAsyncCall: homePageModel.busy,
          progressIndicator: const Loading(),
          child: buildBody(context));
    };
  }

  @override
  HomePageModel withModel() {
    return homePageModel;
  }

  buildBody(context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: RefreshIndicator(
        onRefresh: homePageModel.onRefresh,
        child: FutureBuilder(
            future: homePageModel.getConversation(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text('Đã xảy ra lỗi: ${snapshot.error}'),
                );
              } else {
                return Container(
                  padding: EdgeInsets.symmetric(
                      vertical: yPadding, horizontal: xPadding),
                  child: Column(children: [
                    AddFriendButton(homePageModel),
                    SizedBox(height: screenHelper.setHeight(20)),
                    NavBar(homePageModel),
                    SizedBox(height: screenHelper.setHeight(20)),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: homePageModel.conversationList.length,
                        itemBuilder: (context, index) {
                          return Conversation(
                              homePageModel.conversationList[index].id,
                              username:
                                  homePageModel.conversationList[index].username,
                              isOnline: homePageModel
                                  .conversationList[index].isOnline,
                                latestMessage: homePageModel
                                  .conversationList[index].latestMessage,
                                time: homePageModel
                                  .conversationList[index].time,
                              onClick: homePageModel.onConversationClick);
                        },
                      ),
                    )
                  ]),
                );
              }
            }),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const Text(
          'Chat',
          style: TextStyle(
              color: primaryGreen, fontSize: 26, fontWeight: FontWeight.w600),
        ),
        Row(children: [
          Center(
            child: InkWell(
              onTap: () {
                // Xử lý khi người dùng nhấn vào nút
                print('Nút đã được nhấn');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Remix.search_line,
                ),
              ),
            ),
          ),
          Center(
            child: InkWell(
              onTap: () {
                print('Nút đã được nhấn');
              },
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Icon(
                  Remix.menu_3_fill,
                ),
              ),
            ),
          ),
        ])
      ]),
    );
  }
}
