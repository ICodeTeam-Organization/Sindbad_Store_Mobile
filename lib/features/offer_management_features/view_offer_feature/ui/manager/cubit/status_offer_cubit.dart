import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'status_offer_state.dart';

class StatusOfferCubit extends Cubit<StatusOfferState> {
  StatusOfferCubit() : super(StatusOfferInitial());

  void toggleOfferStatus(int offerId, bool currentStatus) {
    emit(StatusOfferLoading());
    try {
      // Simulate an API call or business logic
      final updatedStatus = !currentStatus;

      // Emit success with updated status
      emit(StatusOfferSuccess(offerId: offerId, newStatus: updatedStatus));
    } catch (e) {
      emit(StatusOfferFailure(errorMessage: e.toString()));
    }
  }
}
