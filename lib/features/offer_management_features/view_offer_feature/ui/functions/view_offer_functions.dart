class ViewOfferFunctions {
  static offerActiveTitleButton(bool isActive, String isActiveTitleButton) {
    if (isActive == true) {
      isActiveTitleButton = 'ايقاف عرض';
    } else {
      isActiveTitleButton = 'تنشيط عرض';
    }
  }

  static offerTypetitle(String typeName, String offerTypeTitle,
      num discountRate, num numberToBuy, num numberToGet) {
    if (typeName == 'Percent') {
      offerTypeTitle = '$discountRate% من إجمالي الخصم';
    } else if (typeName == 'Bonus') {
      offerTypeTitle = ' اشتري $numberToBuy واحصل على $numberToGet';
    }
  }

  static calculateRemainigDays(
      DateTime endOffer, bool isRemainingDays, int result) {
    DateTime dateNow = DateTime.now();
    dateNow = dateNow.toUtc();
    if (dateNow.year <= endOffer.year) {
      if (dateNow.day == 31) {
        result = ((31 + endOffer.day) - dateNow.day) +
            (30 * ((11 + endOffer.month) - dateNow.month)) +
            (360 * ((endOffer.year - 1) - dateNow.year));
      }
      result = ((30 + endOffer.day) - dateNow.day) +
          (30 * ((11 + endOffer.month) - dateNow.month)) +
          (360 * ((endOffer.year - 1) - dateNow.year));
      isRemainingDays = true;
      if (result <= 0) {
        isRemainingDays = false;
      }
    }
  }

  static specialCasesInRemainigDays(
      int result, String specialCase, dynamic remainingDays) {
    if (result == 1) {
      specialCase = '';
      remainingDays = 'يوم واحد ';
    } else if (result == 2) {
      specialCase = '';
      remainingDays = 'يومين ';
    } else if (result > 2 && result < 11) {
      specialCase = ' أيام ';
      remainingDays = result;
    } else if (result > 10) {
      specialCase = ' يوم ';
      remainingDays = result;
    }
  }
}
