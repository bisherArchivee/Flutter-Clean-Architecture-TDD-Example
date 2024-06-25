import 'package:education_app/config/theme/app_colors.dart';
import 'package:education_app/core/common/enum/router_pages_enum.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/presentation/widget/popup_item_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';

class ProfileAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  const ProfileAppBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final profilePageTitleLBL =
        context.appLocalizationEXT!.translate('_profilePage_Title_LBL');
    final editProfilePageEditBTNBTN =
        context.appLocalizationEXT!.translate('_editProfilePage_EditBTN_BTN');
    final profilePageNotificationsLBL =
        context.appLocalizationEXT!.translate('_profilePage_Notifications_LBL');
    final profilePageHelpLBL =
        context.appLocalizationEXT!.translate('_profilePage_Help_LBL');
    final profilePageLogoutLBL =
        context.appLocalizationEXT!.translate('_profilePage_Logout_LBL');

    return AppBar(
      title: Text(
        profilePageTitleLBL,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      ),
      actions: [
        PopupMenuButton(
          offset: const Offset(0, 50),
          // surfaceTintColor: Colors.white,
          icon: const Icon(Icons.more_horiz),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 1,
          itemBuilder: (_) => [
            PopupMenuItem<void>(
              child: PopupItemWidget(
                title: editProfilePageEditBTNBTN,
                icon: const Icon(
                  Icons.edit_outlined,
                  color: AppColors.neutralTextColour,
                ),
              ),
              // onTap: () => context.push(const Placeholder()),
              onTap: () {
                if (context.mounted) {
                  context.pushNamed(
                    RouterPagesEnum.editProfile.info.name,
                  );
                }
              },
            ),
            PopupMenuItem<void>(
              child: PopupItemWidget(
                title: profilePageNotificationsLBL,
                icon: const Icon(
                  IconlyLight.notification,
                  color: AppColors.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              child: PopupItemWidget(
                title: profilePageHelpLBL,
                icon: const Icon(
                  Icons.help_outline_outlined,
                  color: AppColors.neutralTextColour,
                ),
              ),
            ),
            PopupMenuItem<void>(
              height: 1,
              padding: EdgeInsets.zero,
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
                endIndent: 16,
                indent: 16,
              ),
            ),
            PopupMenuItem<void>(
              child: PopupItemWidget(
                title: profilePageLogoutLBL,
                icon: const Icon(
                  Icons.logout_rounded,
                  color: AppColors.neutralTextColour,
                ),
              ),
              onTap: () async {
                // final navigator = context;//Navigator.of(context);
                await FirebaseAuth.instance.signOut();
                if (context.mounted) {
                  context.pushReplacementNamed(
                    RouterPagesEnum.signIn.info.name,
                  );
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
