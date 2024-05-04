import 'package:flutter/material.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class ConfirmOrderCancelingDialog extends StatelessWidget {
  const ConfirmOrderCancelingDialog(
      {super.key,
      required this.onYes,
      required this.onNo,
      this.message = "Are you sure that you want to cancel this order?"});
  final void Function() onYes;
  final void Function() onNo;
  final String message;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Are you sure that you want to cancel this order?",
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GeneralButton(onPressed: onYes, child: const Text("Yes")),
                GeneralButton(
                  onPressed: onNo,
                  child: const Text("No"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
