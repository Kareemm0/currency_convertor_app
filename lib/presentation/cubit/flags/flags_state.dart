abstract class FlagsState {}

final class FlagsInitState extends FlagsState {}

final class GetFlagsLoadingState extends FlagsState {}

final class GetFlagsSuccessState extends FlagsState {
  GetFlagsSuccessState({required this.baseCode, required this.qoutesCode});
  final String baseCode;
  final String qoutesCode;
}

final class GetFlagsFailureState extends FlagsState {}
