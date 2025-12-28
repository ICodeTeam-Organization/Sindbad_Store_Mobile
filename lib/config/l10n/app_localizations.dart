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

  /// No description provided for @oldPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور القديمة'**
  String get oldPassword;

  /// No description provided for @newPassword.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور الجديدة'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد كلمة المرور'**
  String get confirmPassword;

  /// No description provided for @pleaseFillAllFields.
  ///
  /// In ar, this message translates to:
  /// **'الرجاء ملء جميع الحقول'**
  String get pleaseFillAllFields;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور غير متطابقة'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordRequirements.
  ///
  /// In ar, this message translates to:
  /// **'يجب أن تكون كلمة المرور على الأقل 9 حروف، ويجب أن تحتوي على حرف واحد على الأقل و رقم واحد على الأقل'**
  String get passwordRequirements;

  /// No description provided for @thisFieldIsRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get thisFieldIsRequired;

  /// No description provided for @typeHere.
  ///
  /// In ar, this message translates to:
  /// **'أكتب هنا...'**
  String get typeHere;

  /// No description provided for @errorMessage.
  ///
  /// In ar, this message translates to:
  /// **'هناك خطأ الرجاء المحاولة لاحقاً'**
  String get errorMessage;

  /// No description provided for @products.
  ///
  /// In ar, this message translates to:
  /// **'المنتجات'**
  String get products;

  /// No description provided for @offers.
  ///
  /// In ar, this message translates to:
  /// **'العروض'**
  String get offers;

  /// No description provided for @reports.
  ///
  /// In ar, this message translates to:
  /// **'التقارير'**
  String get reports;

  /// No description provided for @allProducts.
  ///
  /// In ar, this message translates to:
  /// **'الجميع'**
  String get allProducts;

  /// No description provided for @withOffers.
  ///
  /// In ar, this message translates to:
  /// **'عليها عروض'**
  String get withOffers;

  /// No description provided for @stopped.
  ///
  /// In ar, this message translates to:
  /// **'الموقوفة'**
  String get stopped;

  /// No description provided for @addProducts.
  ///
  /// In ar, this message translates to:
  /// **'أضافة منتجات'**
  String get addProducts;

  /// No description provided for @stopProducts.
  ///
  /// In ar, this message translates to:
  /// **'ايقاف منتجات'**
  String get stopProducts;

  /// No description provided for @somethingWentWrong.
  ///
  /// In ar, this message translates to:
  /// **'هناك خطأ ما...'**
  String get somethingWentWrong;

  /// No description provided for @ok.
  ///
  /// In ar, this message translates to:
  /// **'حسنا'**
  String get ok;

  /// No description provided for @productNumber.
  ///
  /// In ar, this message translates to:
  /// **'رقم المنتج:'**
  String get productNumber;

  /// No description provided for @price.
  ///
  /// In ar, this message translates to:
  /// **'السعر:'**
  String get price;

  /// No description provided for @currency.
  ///
  /// In ar, this message translates to:
  /// **'ريال'**
  String get currency;

  /// No description provided for @edit.
  ///
  /// In ar, this message translates to:
  /// **'تعديل'**
  String get edit;

  /// No description provided for @delete.
  ///
  /// In ar, this message translates to:
  /// **'حذف'**
  String get delete;

  /// No description provided for @deleteProduct.
  ///
  /// In ar, this message translates to:
  /// **'حذف المنتج'**
  String get deleteProduct;

  /// No description provided for @deleteProductConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل انت متأكد من حذف المنتج'**
  String get deleteProductConfirm;

  /// No description provided for @deleteProductPermanent.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا المنتج بشكل نهائي'**
  String get deleteProductPermanent;

  /// No description provided for @addProduct.
  ///
  /// In ar, this message translates to:
  /// **'إضافة منتج'**
  String get addProduct;

  /// No description provided for @productInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات المنتج'**
  String get productInfo;

  /// No description provided for @productName.
  ///
  /// In ar, this message translates to:
  /// **'أسم المنتج'**
  String get productName;

  /// No description provided for @priceLabel.
  ///
  /// In ar, this message translates to:
  /// **'السعر'**
  String get priceLabel;

  /// No description provided for @productNumberLabel.
  ///
  /// In ar, this message translates to:
  /// **'رقم المنتج'**
  String get productNumberLabel;

  /// No description provided for @oldPrice.
  ///
  /// In ar, this message translates to:
  /// **'السعر السابق'**
  String get oldPrice;

  /// No description provided for @shortDescription.
  ///
  /// In ar, this message translates to:
  /// **'وصف مختصر'**
  String get shortDescription;

  /// No description provided for @selectProductImage.
  ///
  /// In ar, this message translates to:
  /// **'أختر صورة المنتج'**
  String get selectProductImage;

  /// No description provided for @selectCategory.
  ///
  /// In ar, this message translates to:
  /// **'أختر الفئة'**
  String get selectCategory;

  /// No description provided for @selectCategoryHint.
  ///
  /// In ar, this message translates to:
  /// **'قم بإختيار الفئة المناسبة'**
  String get selectCategoryHint;

  /// No description provided for @selectSection.
  ///
  /// In ar, this message translates to:
  /// **'أختر القسم'**
  String get selectSection;

  /// No description provided for @selectSectionHint.
  ///
  /// In ar, this message translates to:
  /// **'قم بإختيار القسم المناسب'**
  String get selectSectionHint;

  /// No description provided for @selectCategoryFirst.
  ///
  /// In ar, this message translates to:
  /// **'إختر الفئة الأساسية أولا'**
  String get selectCategoryFirst;

  /// No description provided for @selectBrand.
  ///
  /// In ar, this message translates to:
  /// **'أختر اسم البراند'**
  String get selectBrand;

  /// No description provided for @selectBrandHint.
  ///
  /// In ar, this message translates to:
  /// **'قم بإختيار البراند المناسب'**
  String get selectBrandHint;

  /// No description provided for @productAttributes.
  ///
  /// In ar, this message translates to:
  /// **'خصائص المنتج'**
  String get productAttributes;

  /// No description provided for @attribute.
  ///
  /// In ar, this message translates to:
  /// **'خاصية'**
  String get attribute;

  /// No description provided for @value.
  ///
  /// In ar, this message translates to:
  /// **'قيمة'**
  String get value;

  /// No description provided for @addMore.
  ///
  /// In ar, this message translates to:
  /// **'أضف المزيد'**
  String get addMore;

  /// No description provided for @confirm.
  ///
  /// In ar, this message translates to:
  /// **'تأكيد'**
  String get confirm;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'الغاء'**
  String get cancel;

  /// No description provided for @productAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تم إضافة المنتج بنجاح!'**
  String get productAddedSuccess;

  /// No description provided for @productAddFailed.
  ///
  /// In ar, this message translates to:
  /// **'فشل في إضافة المنتج, الرجاء المحاولة مرة أخرى'**
  String get productAddFailed;

  /// No description provided for @addImage.
  ///
  /// In ar, this message translates to:
  /// **'إضافة صورة'**
  String get addImage;

  /// No description provided for @noCancelOperation.
  ///
  /// In ar, this message translates to:
  /// **'لا, إلغاء العملية'**
  String get noCancelOperation;

  /// No description provided for @yesContinueProcess.
  ///
  /// In ar, this message translates to:
  /// **'نعم, متابعة الحذف'**
  String get yesContinueProcess;

  /// No description provided for @reactivate.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تنشيط'**
  String get reactivate;

  /// No description provided for @reactivateProducts.
  ///
  /// In ar, this message translates to:
  /// **'إعادة تنشيط المنتجات'**
  String get reactivateProducts;

  /// No description provided for @addOffer.
  ///
  /// In ar, this message translates to:
  /// **'اضافة عرض'**
  String get addOffer;

  /// No description provided for @offerInfo.
  ///
  /// In ar, this message translates to:
  /// **'معلومات العرض'**
  String get offerInfo;

  /// No description provided for @offerName.
  ///
  /// In ar, this message translates to:
  /// **'اسم العرض'**
  String get offerName;

  /// No description provided for @offerStart.
  ///
  /// In ar, this message translates to:
  /// **'بداية العرض'**
  String get offerStart;

  /// No description provided for @offerEnd.
  ///
  /// In ar, this message translates to:
  /// **'نهاية العرض'**
  String get offerEnd;

  /// No description provided for @selectProducts.
  ///
  /// In ar, this message translates to:
  /// **'اختر المنتجات'**
  String get selectProducts;

  /// No description provided for @browseProducts.
  ///
  /// In ar, this message translates to:
  /// **'تصفح المنتجات'**
  String get browseProducts;

  /// No description provided for @addProductsToOffer.
  ///
  /// In ar, this message translates to:
  /// **'اضف منتجات للعرض'**
  String get addProductsToOffer;

  /// No description provided for @invalidDateFormat.
  ///
  /// In ar, this message translates to:
  /// **'صيغة التاريخ غير صحيحة. من فضلك تحقق من التواريخ.'**
  String get invalidDateFormat;

  /// No description provided for @yesChangeStatus.
  ///
  /// In ar, this message translates to:
  /// **'نعم , قم بتغيير الحالة'**
  String get yesChangeStatus;

  /// No description provided for @confirmChangeOfferStatus.
  ///
  /// In ar, this message translates to:
  /// **'هل انت متأكد من تغيير حالة العرض ؟'**
  String get confirmChangeOfferStatus;

  /// No description provided for @confirmDeleteOffer.
  ///
  /// In ar, this message translates to:
  /// **'هل انت متأكد من الحذف ؟'**
  String get confirmDeleteOffer;

  /// No description provided for @offerWillBeDeleted.
  ///
  /// In ar, this message translates to:
  /// **'سيتم حذف هذا العرض, هل تريد المتابعة'**
  String get offerWillBeDeleted;

  /// No description provided for @offerAddedSuccess.
  ///
  /// In ar, this message translates to:
  /// **'تمت إضافة العرض بنجاح'**
  String get offerAddedSuccess;

  /// No description provided for @noOffersYet.
  ///
  /// In ar, this message translates to:
  /// **'لم تضف اي عروض حتى الان!'**
  String get noOffersYet;

  /// No description provided for @encourageCustomers.
  ///
  /// In ar, this message translates to:
  /// **'شجع عملائك على الشراء بتقديم عروض مغرية'**
  String get encourageCustomers;

  /// No description provided for @errorTryAgainLater.
  ///
  /// In ar, this message translates to:
  /// **'هناك خطأ الرجاء المحاولة لاحقاً'**
  String get errorTryAgainLater;

  /// No description provided for @infoNotFetched.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم جلب المعلومات!!'**
  String get infoNotFetched;

  /// No description provided for @discountType.
  ///
  /// In ar, this message translates to:
  /// **'نوع الخصم'**
  String get discountType;

  /// No description provided for @discountAmount.
  ///
  /// In ar, this message translates to:
  /// **'خصم مبلغ من منتج'**
  String get discountAmount;

  /// No description provided for @buyXGetY.
  ///
  /// In ar, this message translates to:
  /// **'اشتري x واحصل على y'**
  String get buyXGetY;

  /// No description provided for @defaultValue.
  ///
  /// In ar, this message translates to:
  /// **'القيمة الأفتراضية'**
  String get defaultValue;

  /// No description provided for @addOfferProducts.
  ///
  /// In ar, this message translates to:
  /// **'اضافة منتجات العرض'**
  String get addOfferProducts;

  /// No description provided for @searchProductNumberOrName.
  ///
  /// In ar, this message translates to:
  /// **'بحث عن رقم المنتج او اسمه'**
  String get searchProductNumberOrName;

  /// No description provided for @infoNotReached.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم الوصول الى المعلومات'**
  String get infoNotReached;

  /// No description provided for @login.
  ///
  /// In ar, this message translates to:
  /// **'تسجيل الدخول'**
  String get login;

  /// No description provided for @welcomeBack.
  ///
  /// In ar, this message translates to:
  /// **'أهلاً بك من جديد، لقد افتقدناك.'**
  String get welcomeBack;

  /// No description provided for @password.
  ///
  /// In ar, this message translates to:
  /// **'كلمة المرور'**
  String get password;

  /// No description provided for @forgotPassword.
  ///
  /// In ar, this message translates to:
  /// **'نسيت كلمة المرور؟'**
  String get forgotPassword;

  /// No description provided for @pleaseEnterPhoneNumber.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال رقم الجوال'**
  String get pleaseEnterPhoneNumber;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In ar, this message translates to:
  /// **'يرجى إدخال كلمة المرور'**
  String get pleaseEnterPassword;

  /// No description provided for @failedToShowVersion.
  ///
  /// In ar, this message translates to:
  /// **'فشل في عرض نسخه التطبيق'**
  String get failedToShowVersion;
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
