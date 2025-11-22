final class AppRegExpText {
  AppRegExpText._();
// Regular Expression
  static String kRegExpEmail =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static String kRegExpPhone =
      // ignore: prefer_adjacent_string_concatenation
      "(\\+[0-9]+[\\- \\.]*)?(\\([0-9]+\\)[\\- \\.]*)?" +
          "([0-9][0-9\\- \\.]+[0-9])";

  static String patternMail =
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$";
}
//
// class OrderStatusNo {
//   static const String kPENDING = '0'; //order just placed
//   static const String kACCEPTED = '10'; //after accepted by shop owner
//   static const String kFOODPROCESSING = '20';
//   static const String kFOODREADY = '21';
//   static const String kFOODPICKED = '30';
//   static const String kFOODDELIVERED = '40';
//   static const String kCANCELLED = '80';
//   static const String kREJECTEDBYSHOP = '90';
//   static const String kFAILED = '100';
//   static const String kALL = 'all';
// }
//
// class DeliveryStatusNo {
//   static const String kPENDIG = '0';
//   static const String kDELIVERYMANCONFIRMED = '10';
//   static const String kDELIVERYSTARTED = '11';
//   static const String kARRIVEDATSHOP = '20';
//   static const String kONTRANSIT = '30';
//   static const String kDELIVERED = '40';
// }
//
// class OrderStatusColor {
//   //Order Status Color Code
//   static const Color kPENDING = Color(0xFF6c757d);
//   static const Color kACCEPTED = Color(0xFF0b79fa);
//   static const Color kFOODPROCESSING = Color(0xFF31a2b8);
//   static const Color kFOODREADY = Color(0xFFffc234);
//   static const Color kFOODPICKED = Color(0xFF6658dd);
//   static const Color kFOODDELIVERED = Color(0xFF4fa744);
//   static const Color kCANCELLED = Color(0xFFdd4246);
//   static const Color kREJECTEDBYSHOP = Color(0xFFdd4246);
//   static const Color kFAILED = Color(0xFFdd4246);
// }
//
// class DeliveryStatusColor {
//   //Delivery Status Color Code
//   static const Color kPENDING = Color(0xFF6c757d);
//   static const Color kDELIVERYMANCONFIRMED = Color(0xFF0b79fa);
//   static const Color kDELIVERYSTARTED = Color(0xFF6658dd);
//   static const Color kARRIVEDATSHOP = Color(0xFFffc234);
//   static const Color kONTRANSIT = Color(0xFFa5d23c);
//   static const Color kDELIVERED = Color(0xFF4fa744);
// }

///Page Value
const int TITLE = 1;

//AZAD ADDED====>

const String kKeyforgetEmail = "forget_email";
const String kKeyforgetOtp = "forget_otp";

const String kImageUrl = 'imageUrl';
const String kKeyfirstTime = "first";
const String kSelectedCategotyId = "selectedCategotyId";
const String kKeyStatus = 'status';
const String kEmail = 'email';
const String kUserEmail = 'userEmail';
const String kUserRegisterEmail = 'userRegisterEmail';

const String kforgetOtp = 'forgetOtp';
const String kPassword = 'password';
const String kMediaFile = 'media_files';
const String kIsFav = 'IsFav';

//old
const String kKeyJsonObject = 'json_object';
const String kKeyJsonArray = 'json_array';
const String kKeyStringData = 'string_data';
const String kKeyMessage = 'message';
const String kKeyData = 'data';
const String kKeyCode = 'code';
const String kKeyIsLoggedIn = 'is_logged_in';
const String kKeyAccessToken = 'access_token';
const String kKeyResetToken = 'reset_token';

//============== Food Scan Data Keys (Exact Postman Field Names) =====================
const String kKeyIsFood             = "is_food";

const String kKeyFoodName           = "food_name";
const String kKeyTotalCalories      = "total_estimated_calories";

const String kKeyCarbsPercentage    = "carbs_percentage";
const String kKeyCarbsInGm          = "carbs_in_gm";
const String kKeyProteinPercentage  = "protein_percentage";
const String kKeyProteinInGm        = "protein_in_gm";
const String kKeyFatPercentage      = "fat_percentage";
const String kKeyFatInGm            = "fat_in_gm";

const String kKeyProtein            = "protein";
const String kKeyTotalCarbs         = "total_carbs";
const String kKeyFiber              = "fiber";
const String kKeySugar              = "sugar";
const String kKeyTotalFat           = "total_fat";
const String kKeySaturated          = "saturated";
const String kKeySodium             = "sodium";
const String kKeyPotassium          = "potassium";

const String kKeyBun                = "bun";
const String kKeyBeefPatties        = "beef patties";
const String kKeyCheese             = "cheese";
const String kKeyLettuce            = "lettuce";
const String kKeyTomato             = "tomato";
const String kKeyPickles            = "pickles";
const String kKeyOnion              = "onion";
const String kKeySauce              = "sauce";

const String kKeyNutritionalInsights = "nutritional_insights";
const String kKeyLastFoodScanResponse = "last_food_scan_response";


const String userId = 'user_ID';
const String kPhone = 'phone_number';
const String kKeySelectedLocation = 'selected_location';
const String kKeySelectedLat = 'selected_lot';
const String kKeySelectedLng = 'selected_lng';
const String kKeyAddress = 'address';
const String kKeyCurrency = 'currency';
const String kKeyLanguage = 'language';
const String kKeyLanguageCode = 'language_code';
const String kKeyCountryCode = 'language_code';
const String kKeyName = 'name';
const String kKeyToken = 'token';
const String kKeyTokenType = 'token_type';
const String kKeyDeviceToken = 'device_token';
const String kKeyUser = 'user';
const String kKeyEmailVerifiedAt = 'email_verified_at';
const String kKeyPhoneVerifiedAt = 'phone_verified_at';
const String kKeyFaqText = 'faq_text';
const String kKeyTermsAndConditionsText = 'toc_text';
const String kKeyAverageRating = 'average_rating';
const String kKeyViews = 'views';
const String kKeyProvider = 'provider';
const String kFacebook = 'facebook';
const String kApple = 'apple';
const String kGoogle = 'google';
const String kKeyEnglish = 'en';
const String kKeyPortuguese = 'pt';
const String kKeyFrench = 'fr';
const String kKeyGerman = 'de';
const String kKeySpanish = 'es';
const String kKeyRussian = 'ru';
const String kKeyFirstName = 'first_name';
const String kKeyLastName = 'lst_name';
const String kKeyDeviceID = 'device_id';
const String kKeyEmail = 'email';
const String kKeyPassword = 'password';
const String kKeyRememberMe = 'remember_me';
const String kKeyShopID = 'shop_id';
const String kKeycategoriesID = 'categoriesId';
const String kKeyproductID = 'productId';
const String kKeyShopSlug = 'shop_slug';
const String kKeyRestaurantID = 'productId';
const String kKeyIsExploring = 'exploring';
const String kKeyIsFirstTime = "firstTime";
//order statuses

// * For This App
const String kKeyUserID = 'user_id';
const String kKeyUserEmail = 'user_email';
const String kKeyUserMobile = 'user_mobile';
const String kKeyUserType = 'user_type';

// * Recover user signup data
const String kKeyuserEmail = 'userEmail';
const String kKeyuserPassword = 'userPassword';

const String kKeyuserFullName = 'userFullName';
const String kKeyuserAge = 'userAge';
const String kKeyuserGender = 'userGender';
const String kKeyuserReminderStartTime = 'userReminderStartTime';
const String kKeyuserReminderEndTime = 'userReminderEndTime';

//* Athlete User Section data
const String kKeyuserAthleteFullName = 'userAthleteFullName';
const String kKeyuserAthletePassword = 'userAthletePassword';
const String kKeyuserAthleteEmail = 'userAthleteEmail';
const String kKeyAthleteSelectGoal = 'athleteSelectGoal';
const String kKeyAthleteSelectSport = 'athleteSelectGoalSport';
const String kKeyAthleteExperiencelevel = 'athleteExperiencelevel';
const String kKeyAthleteDailyReminder = 'athleteDailyReminder';


// * Injury Details - Recovery Step One
const String kKeyInjuryName = 'InjuryName';
const String kKeyInjuryLevel = 'InjuryLevel';
const String kKeyInjuryDate = 'InjuryDate';
const String kKeyRecoveryStage = 'RecoveryStage';

// * Recovery Step Two

const String kKeyPhysicalSymptom = 'PhysicalSymptom';
const String kKeySymptomLevel = 'SymptomLevel';
const String kKeyFrequency = 'Frequency';
const String kKeyDuration = 'Duration';
const String kKeyEmotionalSymptom = 'EmotionalSymptom';

// * Recovery Step Three

const String kKRecoveryTimePeriod = 'Recovery Tme Period';
const String kKRecoveryGoal = 'Recovery Goal';
const String ProgressTimelines = 'Progress Timeline';
const String TargetDuration = 'TargetDuration';

const List<String> kLanguagesKey = [
  kKeyEnglish,
  kKeyPortuguese,
  kKeyFrench,
  kKeyGerman,
  kKeySpanish,
  kKeyRussian,
];
const Map languages = <String, String>{
  kKeyEnglish: "English",
  kKeyPortuguese: "Portuguese",
  kKeyFrench: "French",
  kKeyGerman: "Dutch",
  kKeySpanish: "Spanish",
  kKeyRussian: "Russian",
};
const Map countriesCode = <String, String>{
  kKeyEnglish: "US",
  kKeyPortuguese: "PT",
  kKeyFrench: "FR",
  kKeyGerman: "DE",
  kKeySpanish: "ES",
  kKeyRussian: "RU",
};

class DefaultValue {
  static const bool kDefaultBoolean = false;
  static const int kDefaultInt = 0;
  static const double kDefaultDouble = 0.0;
  static const String kDefaultString = '';
}
