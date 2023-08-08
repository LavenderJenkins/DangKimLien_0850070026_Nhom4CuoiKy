import 'package:flutter/material.dart';
import 'package:mc_application/core/helpers/screen_helper.dart';
import 'package:mc_application/modules/home/home_page_model.dart';
import 'package:remixicon/remixicon.dart';

class AddFriendButton extends StatefulWidget {
  final HomePageModel model;
  const AddFriendButton(this.model, {Key? key}) : super(key: key);

  @override
  State<AddFriendButton> createState() => _AddFriendButtonState();
}

final ButtonStyle style = ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    elevation: 0,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)));

class _AddFriendButtonState extends State<AddFriendButton> {
  @override
  Widget build(BuildContext context) {
    return buildExpandedButton();
  }

  ElevatedButton buildExpandedButton() {
    return ElevatedButton(
      style: style,
      onPressed: () {
        print('add friend clicked');
      },
      child: SizedBox(
        height: screenHelper.getHeightByPercent(0.06),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Remix.user_add_line, size: 14),
            SizedBox(
              width: 10,
            ),
            Text(
              'Add new friend',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
