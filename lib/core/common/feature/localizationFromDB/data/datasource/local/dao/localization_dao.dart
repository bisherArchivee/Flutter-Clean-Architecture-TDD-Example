import 'package:education_app/core/common/feature/localizationFromDB/data/model/localization_model.dart';
import 'package:floor/floor.dart';

@dao
abstract class LocalizationDAO {
  static const tableName = LocalizationModel.className;

  @Query('SELECT * FROM $tableName WHERE languageCode :appLanguage '
      'AND textCode :local ')
  Future<String?> getLocal(String appLanguage, String local);

}


// @Insert(onConflict: OnConflictStrategy.replace)
// Future<void> insertArticle(ArticleModel articleModel);
//
// @delete
// Future<void> deleteArticle(ArticleModel articleModel);

// @Query('select * from article')
// Future<List<ArticleModel>> getArticleList();
//
// @Query(
//     'SELECT * FROM article WHERE title IS NULL OR title LIKE :keyword ORDER BY publishedDate ASC')
// Future<List<ArticleModel>> getArticlesByTitleKeywordASC(String keyword);
//
// @Query(
//     'SELECT * FROM article WHERE title IS NULL OR title LIKE :keyword ORDER BY publishedDate DESC')
// Future<List<ArticleModel>> getArticlesByTitleKeywordDESC(String keyword);