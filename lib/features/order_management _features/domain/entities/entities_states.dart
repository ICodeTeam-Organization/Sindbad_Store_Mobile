enum PackageStatus {
  notApprovedYet,
  packageConfirmedByYemeniAccountant,
  packageInvoiceCreated,
  packageInvoicePaidByTheSaudiAccountant,
  packageShippedFromStore,
  packageReceivedToDeliveryMan,
  packageDeliveredToCustomer,
  canceled,
  all
}

extension PackageStatusExtension on PackageStatus {
  String get displayName {
    switch (this) {
      case PackageStatus.notApprovedYet:
        return "لم يتم التأكيد بعد من المحاسب اليمني";
      case PackageStatus.packageConfirmedByYemeniAccountant:
        return "تم التأكيد من المحاسب اليمني";
      case PackageStatus.packageInvoiceCreated:
        return "تم إنشاء الفاتورة";
      case PackageStatus.packageInvoicePaidByTheSaudiAccountant:
        return "تم تسديد الفاتورة من قبل المحاسب السعودي";
      case PackageStatus.packageShippedFromStore:
        return "تم تأكيد شحن الطلب";
      case PackageStatus.packageReceivedToDeliveryMan:
        return "تم استلام الطلب من قبل مندوب الاستلام اليمني";
      case PackageStatus.packageDeliveredToCustomer:
        return "تم تسليم الطلب للزبون";
      case PackageStatus.canceled:
        return "إلغاء الطلب";
      case PackageStatus.all:
        return "الكل";
    }
  }

  int get id {
    switch (this) {
      case PackageStatus.notApprovedYet:
        return 1;
      case PackageStatus.packageConfirmedByYemeniAccountant:
        return 2;
      case PackageStatus.packageInvoiceCreated:
        return 3;
      case PackageStatus.packageInvoicePaidByTheSaudiAccountant:
        return 4;
      case PackageStatus.packageShippedFromStore:
        return 5;
      case PackageStatus.packageReceivedToDeliveryMan:
        return 6;
      case PackageStatus.packageDeliveredToCustomer:
        return 7;
      case PackageStatus.canceled:
        return 8;
      case PackageStatus.all:
        return 9;
    }
  }

  static PackageStatus fromId(int id) {
    switch (id) {
      case 1:
        return PackageStatus.notApprovedYet;
      case 2:
        return PackageStatus.packageConfirmedByYemeniAccountant;
      case 3:
        return PackageStatus.packageInvoiceCreated;
      case 4:
        return PackageStatus.packageInvoicePaidByTheSaudiAccountant;
      case 5:
        return PackageStatus.packageShippedFromStore;
      case 6:
        return PackageStatus.packageReceivedToDeliveryMan;
      case 7:
        return PackageStatus.packageDeliveredToCustomer;
      case 8:
        return PackageStatus.canceled;
      case 9:
        return PackageStatus.all;
      default:
        throw Exception("Invalid PackageStatus id: $id");
    }
  }

  static int idFromDisplayName(String name) {
    for (var status in PackageStatus.values) {
      if (status.displayName == name) {
        return status.id;
      }
    }
    throw Exception("Invalid PackageStatus name: $name");
  }
}
