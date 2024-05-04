import 'package:flutter/material.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';

class DeliveryPageCard extends StatelessWidget {
  const DeliveryPageCard(
      {super.key,
      required this.onTap,
      required this.text,
      required this.trailing});

  final void Function() onTap;
  final String text;
  final Widget trailing;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        onTap: onTap,
        splashColor: AppColors.thirdColor10.withOpacity(0.4),
        title: Text(text),
        trailing: trailing,
      ),
    );
  }
}
