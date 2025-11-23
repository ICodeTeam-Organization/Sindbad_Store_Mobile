sealed class ExcelState {}

class ExcellInitial extends ExcelState {}

class ExcellLoadInProgress extends ExcelState {}

class ExcellLoadSuccess extends ExcelState {}

class ExcellLoadFailure extends ExcelState {
  final String message;
  ExcellLoadFailure(this.message);
}
