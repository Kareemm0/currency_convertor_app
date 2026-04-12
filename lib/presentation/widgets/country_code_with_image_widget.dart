import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import '../../core/core.dart';
import '../presentation.dart';

class CountryCodeWithImageWidget<T> extends StatelessWidget {
  const CountryCodeWithImageWidget({
    super.key,
    required this.imageUrl,
    required this.items,
    this.onChanged,
    required this.controller,
    this.value,
    this.hint,
  });
  final String imageUrl;
  final List<DropdownMenuItem> items;
  final void Function(dynamic)? onChanged;
  final TextEditingController controller;
  final dynamic value;
  final Widget? hint;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        CachedNetworkImage(
          imageUrl: imageUrl,
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        DropdownButton(
          value: value,
          items: items,
          hint: hint,
          onChanged: onChanged,
          underline: const SizedBox(),
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: AppColors.black,
          ),
        ),
        Expanded(child: CustomTextFormFiled(controller: controller)),
      ],
    );
  }
}
