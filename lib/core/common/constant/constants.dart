/*Application Database*/
const String appDBName = 'app_database.db';

/*Shared preferences*/
const String kLoginStatusTypeKey = 'login_type'; //email,firebase,facebook,google
const String kIsFirstTimeLoginKey = 'is_first_time_login'; //true,false
const String kIsDarkThemeEnabledKey = 'is_dark_theme_enabled'; //dark,light,null

/*Failure States Code*/
const int kFireBaseStatusCode = 800;
const int kCacheStatusCode = 700;
const int kConnectionStatusCode = 600;

/*Failure States Code*/
const String kDefaultUserProfile =
    'https://images.freeimages.com/fic/images/icons/573/must_have/256/user.png';

/*FireStore DB Tables */
const String kUsersTable = 'users';

/*FireStorage Folders Buckets */
const String kUsersProfileAvatar = 'profile_pics';

/**/
const double kPageBottomVerticalSpacing = 30;
const double kFormFieldVerticalSpacing = 15;
