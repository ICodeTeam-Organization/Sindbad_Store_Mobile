part of 'counter_quntity_cubit.dart';

@immutable
sealed class CounterQuntityState {}

final class CounterQuntityInitial extends CounterQuntityState {}

class CounterIncrementState extends CounterQuntityState {}

class CounterDecrementState extends CounterQuntityState {}
