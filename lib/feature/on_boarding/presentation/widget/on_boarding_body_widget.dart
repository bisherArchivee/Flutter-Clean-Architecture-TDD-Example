import 'package:education_app/config/theme/app_fonts.dart';
import 'package:education_app/core/common/extension/context_builder_extension.dart';
import 'package:education_app/core/common/presentation/widget/form_field_sizedbox_widget.dart';
import 'package:education_app/feature/on_boarding/domain/entity/on_boarding_content_entity.dart';
import 'package:flutter/material.dart';

class OnBoardingBodyWidget extends StatelessWidget {
  const OnBoardingBodyWidget({
    required this.onBoardingContentEntity,
    super.key,
  });

  final OnBoardingContentEntity onBoardingContentEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          onBoardingContentEntity.image,
          height: context.heightEXT * 0.4,
        ),
        AppFormFieldSizedBoxWidget(
          height: context.heightEXT * 0.03,
        ),
        Padding(
          padding: const EdgeInsets.all(20).copyWith(bottom: 0),
          child: Column(
            children: [
              AppFormFieldSizedBoxWidget(
                height: context.heightEXT * 0.15,
                child: Center(
                  child: Text(
                    onBoardingContentEntity.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: AppFonts.AEONIK,
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              // AppFormFieldSizedBoxWidget(
              //   height: context.heightEXT * 0.02,
              // ),
              AppFormFieldSizedBoxWidget(
                height: context.heightEXT * 0.15,
                child: Text(
                  onBoardingContentEntity.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: AppFonts.POPPINS,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),
              AppFormFieldSizedBoxWidget(
                height: context.heightEXT * 0.01,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
