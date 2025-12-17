// part of 'sign_up_bloc.dart';

// @immutable
// sealed class SignUpState {}

// final class SignUpInitial extends SignUpState {}

part of 'sign_up_bloc.dart';

sealed class SignUpState extends Equatable {
  const SignUpState();
  
  @override
  List<Object> get props => [];
}

final class SignUpInitial extends SignUpState {}

class SignUpSuccess extends SignUpState {}
class SignUpFailure extends SignUpState {}
class SignUpProcess extends SignUpState {}