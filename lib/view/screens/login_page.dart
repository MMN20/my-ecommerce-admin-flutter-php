import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/login_page_controller.dart';
import 'package:my_ecommerce_admin/core/functions/validator.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:my_ecommerce_admin/view/widgets/my_text_form_field.dart';
import 'package:my_ecommerce_admin/view/widgets/request_status_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginPageController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GetBuilder(
            init: controller,
            builder: (controller) {
              return RequestStatusView(
                onErrorTap: () {},
                requestStatus: controller.requestStatus,
                child: Form(
                  key: controller.globalKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Admin login page",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Email",
                        icon: const Icon(Icons.email),
                        controller: controller.emailController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Enter the email", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      MyTextFormField(
                        labelText: "Password",
                        icon: const Icon(Icons.lock_outline_rounded),
                        controller: controller.passwordController,
                        validator: (s) {
                          return validator(
                              s!, 1, s.length, "Enter the password", "");
                        },
                      ),
                      const SizedBox(height: 10),
                      GeneralButton(
                        onPressed: () {
                          controller.login();
                        },
                        minSize: const Size(130, 40),
                        child: const Text("Login"),
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
