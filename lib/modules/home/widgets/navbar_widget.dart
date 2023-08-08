import 'package:flutter/material.dart';
import 'package:mc_application/core/appearances/colors.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/modules/home/home_page_model.dart';
import 'package:remixicon/remixicon.dart';

class NavBar extends StatefulWidget {
  final HomePageModel model;
  const NavBar(this.model, {Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 0;

  // Danh sách các icon cho từng nút
  List<IconData> buttonIcons = [
    Remix.discuss_line,
    Remix.message_2_line,
    Remix.user_received_2_line
  ];

  List<String> buttonsText = ['All', 'Unread', 'Received'];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              buttonIcons.length,
              (index) => SizedBox(
                height: screenHelper.getHeightByPercent(0.06),
                width: screenHelper.getWidthByPercent((1 - 0.06) / 3),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent,
                      backgroundColor:
                          _currentIndex == index ? softGreen : backgroundColor,
                      elevation: 0,
                      disabledBackgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent),
                  onPressed: () {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        buttonIcons[index],
                        color: _currentIndex == index
                            ? primaryGreen
                            : Colors.black,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        buttonsText[index],
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight:
                                _currentIndex == index ? FontWeight.bold : null,
                            color: _currentIndex == index
                                ? primaryGreen
                                : Colors.black),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
