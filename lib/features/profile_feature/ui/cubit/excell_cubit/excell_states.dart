sealed class ExcelState {}

class ExcellInitial extends ExcelState {}

class ExcellLoadInProgress extends ExcelState {}

class ExcellLoadSuccess extends ExcelState {
  final String directoryPath;

  ExcellLoadSuccess(this.directoryPath);
}

class ExcellLoadFailure extends ExcelState {
  final String message;
  ExcellLoadFailure(this.message);
}

class ExcellUploadSuccess extends ExcelState {
  final Map<String, dynamic> data;
  ExcellUploadSuccess(this.data);
}
