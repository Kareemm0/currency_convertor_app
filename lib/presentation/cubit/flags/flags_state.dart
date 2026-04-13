abstract class FlagsState {}

final class FlagsInitState extends FlagsState {}

final class GetFlagsSuccessState extends FlagsState {
  GetFlagsSuccessState(this.code);
  final String code;
}

final class GetFlagsFailureState extends FlagsState {}
