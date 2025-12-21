import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @orders.
  ///
  /// In ar, this message translates to:
  /// **'الطلبات'**
  String get orders;

  /// No description provided for @newOrders.
  ///
  /// In ar, this message translates to:
  /// **'الجديدة'**
  String get newOrders;

  /// No description provided for @urgentOrders.
  ///
  /// In ar, this message translates to:
  /// **'المستعجلة'**
  String get urgentOrders;

  /// No description provided for @previousOrders.
  ///
  /// In ar, this message translates to:
  /// **'السابقة'**
  String get previousOrders;

  /// No description provided for @canceledOrders.
  ///
  /// In ar, this message translates to:
  /// **'الملغية'**
  String get canceledOrders;

  /// No description provided for @profile.
  ///
  /// In ar, this message translates to:
  /// **'الملف الشخصي'**
  String get profile;

  /// No description provided for @phoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الجوال'**
  String get phoneNumber;

  /// No description provided for @email.
  ///
  /// In ar, this message translates to:
  /// **'البريد الإلكتروني'**
  String get email;

  /// No description provided for @country.
  ///
  /// In ar, this message translates to:
  /// **'الدولة'**
  String get country;

  /// No description provided for @saudiArabia.
  ///
  /// In ar, this message translates to:
  /// **'السعودية'**
  String get saudiArabia;

  /// No description provided for @changePassword.
  ///
  /// In ar, this message translates to:
  /// **'تغيير كلمة المرور'**
  String get changePassword;

  /// No description provided for @addProductsViaExcel.
  ///
  /// In ar, this message translates to:
  /// **'اضافة المنتجات عبر الاكسيل'**
  String get addProductsViaExcel;

  /// No description provided for @defaultDeferredPayment.
  ///
  /// In ar, this message translates to:
  /// **'الدفع الآجل الافتراضي'**
  String get defaultDeferredPayment;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الليلي'**
  String get darkMode;

  /// No description provided for @language.
  ///
  /// In ar, this message translates to:
  /// **'اللغة'**
  String get language;

  /// No description provided for @downloadLatestVersion.
  ///
  /// In ar, this message translates to:
  /// **'تحميل اخر اصدار'**
  String get downloadLatestVersion;

  /// No description provided for @logout.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الخروج'**
  String get logout;

  /// No description provided for @categories.
  ///
  /// In ar, this message translates to:
  /// **'الفئات'**
  String get categories;

  /// No description provided for @storeOwner.
  ///
  /// In ar, this message translates to:
  /// **'صاحب المتجر'**
  String get storeOwner;

  /// No description provided for @checkingForUpdates.
  ///
  /// In ar, this message translates to:
  /// **'جاري التحقق من التحديثات...'**
  String get checkingForUpdates;

  /// No description provided for @appUpdate.
  ///
  /// In ar, this message translates to:
  /// **'تحديث التطبيق'**
  String get appUpdate;

  /// No description provided for @noUpdatesAvailable.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد تحديثات متاحة، أنت تستخدم النسخة الأحدث'**
  String get noUpdatesAvailable;

  /// No description provided for @error.
  ///
  /// In ar, this message translates to:
  /// **'خطأ'**
  String get error;

  /// No description provided for @errorCheckingUpdates.
  ///
  /// In ar, this message translates to:
  /// **'حدث خطأ أثناء التحقق من التحديثات'**
  String get errorCheckingUpdates;

  /// No description provided for @packageStatusAll.
  ///
  /// In ar, this message translates to:
  /// **'الكل'**
  String get packageStatusAll;

  /// No description provided for @packageStatusNotApproved.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم التأكيد بعد من المحاسب اليمني'**
  String get packageStatusNotApproved;

  /// No description provided for @packageStatusConfirmed.
  ///
  /// In ar, this message translates to:
  /// **'تم التأكيد من المحاسب اليمني'**
  String get packageStatusConfirmed;

  /// No description provided for @packageStatusInvoiceCreated.
  ///
  /// In ar, this message translates to:
  /// **'تم إنشاء الفاتورة'**
  String get packageStatusInvoiceCreated;

  /// No description provided for @packageStatusInvoicePaid.
  ///
  /// In ar, this message translates to:
  /// **'تم تسديد الفاتورة من قبل المحاسب السعودي'**
  String get packageStatusInvoicePaid;

  /// No description provided for @packageStatusShipped.
  ///
  /// In ar, this message translates to:
  /// **'تم تأكيد شحن الطلب'**
  String get packageStatusShipped;

  /// No description provided for @packageStatusReceived.
  ///
  /// In ar, this message translates to:
  /// **'تم استلام الطلب من قبل مندوب الاستلام اليمني'**
  String get packageStatusReceived;

  /// No description provided for @packageStatusDelivered.
  ///
  /// In ar, this message translates to:
  /// **'تم تسليم الطلب للزبون'**
  String get packageStatusDelivered;

  /// No description provided for @packageStatusCanceled.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء الطلب'**
  String get packageStatusCanceled;

  /// No description provided for @noData.
  ///
  /// In ar, this message translates to:
  /// **'لا توجد بيانات'**
  String get noData;

  /// No description provided for @orderNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الطلب'**
  String get orderNumber;

  /// No description provided for @billNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم الفاتورة'**
  String get billNumber;

  /// No description provided for @itemCount.
  ///
  /// In ar, this message translates to:
  /// **'عدد الاصناف'**
  String get itemCount;

  /// No description provided for @paymentInfo.
  ///
  /// In ar, this message translates to:
  /// **'بيانات السداد'**
  String get paymentInfo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
