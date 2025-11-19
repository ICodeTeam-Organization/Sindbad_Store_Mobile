sealed class ExcellState {}

class ExcellInitial extends ExcellState {}

class ExcellLoadInProgress extends ExcellState {}

class ExcellLoadSuccess extends ExcellState {}

class ExcellLoadFailure extends ExcellState {
  final String message;
  ExcellLoadFailure(this.message);
}
