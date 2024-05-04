import 'package:flutter/material.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';

class DeleteOrderDialog extends StatelessWidget {
  const DeleteOrderDialog(
      {super.key, required this.onDeleteTap, required this.controller});
  final void Function() onDeleteTap;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyTextFormField(
              controller: controller,
              icon: const Icon(Icons.message),
              labelText: "A message to the user",
            ),
            GeneralButton(
              onPressed: onDeleteTap,
              backgroundColor: Colors.red,
              child: const Text("Delete"),
            ),
          ],
        ),
      ),
    );
  }
}
