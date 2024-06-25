import 'package:education_app/config/theme/app_colors.dart';
import 'package:education_app/config/theme/app_media_res.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:education_app/core/common/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileHeaderWidget extends StatefulWidget {
  const ProfileHeaderWidget({super.key});

  @override
  State<ProfileHeaderWidget> createState() => _ProfileHeaderWidgetState();
}

class _ProfileHeaderWidgetState extends State<ProfileHeaderWidget> {
  late final profilePageNoUserLBL =
  context.appLocalizationEXT!.translate('_profilePage_NoUser_LBL');
  @override
  Widget build(BuildContext context) {

    return Consumer<UserProvider>(
      builder: (_, provider, __) {
        final user = provider.userEntity;
        final image = user?.photoURL == null || user!.photoURL!.isEmpty
            ? null
            : user.photoURL;
        return Column(
          children: [
            const AppFormFieldSizedBoxWidget(),
            CircleAvatar(
              radius: 50,
              backgroundImage: image != null
                  ? NetworkImage(image)
                  : const AssetImage(MediaRes.user) as ImageProvider,
            ),
            const AppFormFieldSizedBoxWidget(),
            Text(
              user?.displayName ?? profilePageNoUserLBL,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
            ),
            if (user?.bio != null && user!.bio!.isNotEmpty) ...[
              const AppFormFieldSizedBoxWidget(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: context.widthEXT * .15,
                ),
                child: Text(
                  user.bio!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.neutralTextColour,
                  ),
                ),
              ),
            ],
            const AppFormFieldSizedBoxWidget(),
          ],
        );
      },
    );
  }
}
