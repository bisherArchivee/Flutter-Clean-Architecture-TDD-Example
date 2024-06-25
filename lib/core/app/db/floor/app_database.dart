// @TypeConverters([StringListConverter,MediaListConverter,MediaMetadataListConverter,DateTimeConverter])
import 'dart:async';

import 'package:education_app/core/common/feature/localizationFromDB/data/datasource/local/dao/localization_dao.dart';
import 'package:education_app/core/common/feature/localizationFromDB/data/model/localization_model.dart';
import 'package:floor/floor.dart';
/*should import this package manually to fix .g.dart issues*/
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

// @TypeConverters([StringListConverter,MediaListConverter,MediaMetadataListConverter,DateTimeConverter])
@Database(version: 1, entities: [LocalizationModel])
abstract class AppDatabase extends FloorDatabase {
  LocalizationDAO get localizationDAO;
}
