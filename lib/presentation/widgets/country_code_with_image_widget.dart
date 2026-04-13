import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../core/core.dart';
import '../presentation.dart';

class CountryCodeWithImageWidget<T> extends StatelessWidget {
  const CountryCodeWithImageWidget({
    super.key,
    required this.imageUrl,
    required this.items,
    this.onChanged,
    this.controller,
    this.value,
    this.onAmountChanged,
    this.isShown = false,
  });
  final String imageUrl;
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;
  final TextEditingController? controller;
  final dynamic value;
  final void Function(String)? onAmountChanged;
  final bool isShown;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        SvgPicture.string(imageUrl, width: 30, height: 30),
        DropdownButton(
          value: value,
          items: items,
          onChanged: onChanged,
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.black,
          ),
        ),
        if (isShown)
          Expanded(
            child: CustomTextFormFiled(
              controller: controller,
              onChanged: onAmountChanged,
            ),
          ),
      ],
    );
  }
}
