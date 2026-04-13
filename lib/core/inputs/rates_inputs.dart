import '../core.dart';

class RatesInputs extends BaseInput {
  const RatesInputs({this.base, this.qoutes, this.to, this.from});

  final String? base;
  final String? qoutes;
  final String? to;
  final String? from;
  @override
  Map<String, dynamic> toJson() {
    return {"base": base, "quotes": qoutes, "to": to, "from": from};
  }
}
