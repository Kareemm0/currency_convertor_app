import '../core.dart';

class RatesInputs extends BaseInput {
  const RatesInputs({required this.base, required this.qoutes});

  final String base;
  final String qoutes;
  @override
  Map<String, dynamic> toJson() {
    return {"base": base, "quotes": qoutes};
  }
}
