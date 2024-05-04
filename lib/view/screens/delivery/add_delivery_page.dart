import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/delivery/add_delivery_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class AddDeliveryPage extends StatelessWidget {
  const AddDeliveryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddDeliveryPageController());
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Delivery"),
        centerTitle: true,
      ),
      body: Form(
        key: controller.formState,
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: GetBuilder(
              init: controller,
              builder: (controller) {
                return RequestStatusView(
                  onErrorTap: () {},
                  requestStatus: controller.requestStatus,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyTextFormField(
                        labelText: "Email",
                        icon: const Icon(Icons.email),
                        controller: controller.emailController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Please enter the Email", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Username",
                        icon: const Icon(Icons.email),
                        controller: controller.usernameController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Please enter the Username", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Password",
                        icon: const Icon(Icons.email),
                        controller: controller.passwordController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Please enter the Password", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      GeneralButton(
                        onPressed: () {
                          controller.addDeliveryAccount();
                        },
                        child: const Text("Submit"),
                      ),
                    ],
                  ),
                );
              }),
        )),
      ),
    );
  }
}
