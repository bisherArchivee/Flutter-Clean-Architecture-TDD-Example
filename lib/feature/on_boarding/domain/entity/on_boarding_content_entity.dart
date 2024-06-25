import 'package:education_app/config/theme/app_media_res.dart';
import 'package:equatable/equatable.dart';

class OnBoardingContentEntity extends Equatable {
  const OnBoardingContentEntity({
    required this.image,
    required this.title,
    required this.description,
  });

  const OnBoardingContentEntity.first({
    required String title,
    required String description,
  }) : this(
          image: MediaRes.casualReading,
          title: title,
          description: description,
        );

  const OnBoardingContentEntity.second({
    required String title,
    required String description,
  }) : this(
          image: MediaRes.casualLife,
          title: title,
          description: description,
        );

  const OnBoardingContentEntity.third({
    required String title,
    required String description,
  }) : this(
          image: MediaRes.casualMeditationScience,
          title: title,
          description: description,
        );

  final String image;
  final String title;
  final String description;

  @override
  List<Object?> get props => [image, title, description];
}
