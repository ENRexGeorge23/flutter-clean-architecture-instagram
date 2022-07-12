import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/core/resources/assets_manager.dart';
import 'package:instagram/core/resources/styles_manager.dart';
import 'package:instagram/core/utility/injector.dart';
import 'package:instagram/data/models/user_personal_info.dart';
import 'package:instagram/presentation/cubit/firestoreUserInfoCubit/user_info_cubit.dart';
import 'package:instagram/presentation/cubit/firestoreUserInfoCubit/users_info_cubit.dart';
import 'package:instagram/presentation/pages/activity/activity_page.dart';
import 'package:instagram/presentation/pages/messages/messages_page.dart';
import 'package:instagram/presentation/widgets/global/custom_widgets/custom_network_image_display.dart';

class CustomAppBar {
  static AppBar basicAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      title: instagramLogo(context),
      actions: [
        IconButton(
          icon: SvgPicture.asset(
            IconsAssets.add2Icon,
            color: Theme.of(context).focusColor,
            height: 22.5,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: SvgPicture.asset(
            IconsAssets.favorite,
            color: Theme.of(context).focusColor,
            height: 30,
          ),
          onPressed: () {
            UserPersonalInfo myPersonalInfo =
                FirestoreUserInfoCubit.getMyPersonalInfo(context);
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) =>
                    ActivityPage(myPersonalInfo: myPersonalInfo),
              ),
            );
          },
        ),
        IconButton(
          icon: SvgPicture.asset(
            IconsAssets.messengerIcon,
            color: Theme.of(context).focusColor,
            height: 22.5,
          ),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).push(
              CupertinoPageRoute(
                  builder: (context) => BlocProvider<UsersInfoCubit>(
                        create: (context) => injector<UsersInfoCubit>(),
                        child: const MessagesPage(),
                      ),
                  maintainState: false),
            );
          },
        )
      ],
    );
  }

  static AppBar chattingAppBar(
      UserPersonalInfo userInfo, BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      backgroundColor: Theme.of(context).primaryColor,
      title: Row(
        children: [
          CircleAvatar(
              child: ClipOval(
                  child: NetworkImageDisplay(
                imageUrl: userInfo.profileImageUrl,
              )),
              radius: 17),
          const SizedBox(
            width: 15,
          ),
          Text(
            userInfo.name,
            style: TextStyle(
                color: Theme.of(context).focusColor,
                fontSize: 16,
                fontWeight: FontWeight.normal),
          )
        ],
      ),
      actions: [
        SvgPicture.asset(
          "assets/icons/phone.svg",
          height: 27,
          color: Theme.of(context).focusColor,
        ),
        const SizedBox(
          width: 20,
        ),
        SvgPicture.asset(
          "assets/icons/video_point.svg",
          height: 25,
          color: Theme.of(context).focusColor,
        ),
        const SizedBox(
          width: 15,
        ),
      ],
    );
  }

  static AppBar oneTitleAppBar(BuildContext context, String text,
      {bool logoOfInstagram = false}) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: false,
      iconTheme: IconThemeData(color: Theme.of(context).focusColor),
      title: logoOfInstagram
          ? instagramLogo(context)
          : Text(
              text,
              style: getMediumStyle(
                  color: Theme.of(context).focusColor, fontSize: 20),
            ),
    );
  }

  static SvgPicture instagramLogo(BuildContext context) {
    return SvgPicture.asset(
      IconsAssets.instagramLogo,
      height: 32,
      color: Theme.of(context).focusColor,
    );
  }

  static AppBar menuOfUserAppBar(
      BuildContext context, String text, AsyncCallback bottomSheet) {
    return AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: Theme.of(context).focusColor),
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(text,
            style: getMediumStyle(
                color: Theme.of(context).focusColor, fontSize: 20)),
        actions: [
          IconButton(
            icon: SvgPicture.asset(
              IconsAssets.menuHorizontalIcon,
              color: Theme.of(context).focusColor,
              height: 22.5,
            ),
            onPressed: () => bottomSheet,
          ),
          const SizedBox(width: 5)
        ]);
  }
}
