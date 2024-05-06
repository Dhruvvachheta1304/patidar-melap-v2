part of 'salary_bloc.dart';

@immutable
sealed class SalaryEvent extends Equatable {
  const SalaryEvent();

  @override
  List<Object?> get props => [];
}

final class FetchSalaryEvent extends SalaryEvent {
  const FetchSalaryEvent();
}
