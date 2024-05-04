import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_ecommerce_admin/controllers/try_controller.dart';
import 'package:my_ecommerce_admin/core/class/crud.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';
import 'package:my_ecommerce_admin/firebase_options.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: "Cairo",
        colorScheme: const ColorScheme.light(primary: AppColors.thirdColor10),
        scaffoldBackgroundColor: AppColors.mainColor60,
        appBarTheme: const AppBarTheme(color: AppColors.mainColor60),
        textTheme: const TextTheme(
          // Texts uses it
          bodyMedium: TextStyle(
            fontSize: 16,
            color: AppColors.thirdColor10,
          ),
          // TextForms uses it
          bodyLarge: TextStyle(fontSize: 15),
        ),
        useMaterial3: true,
      ),
      getPages: pages,
      // home: const LoginPage(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  List<File> files = [];

  void chooseImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (xFile != null) {
      files.add(File(xFile.path));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TryController());
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await CRUD.uploadMultipleFiles(files, {},
                  "https://mustafa2000.com/myecommerce/admin/upload_files.php");
              print("OKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK");
            },
            icon: const Icon(Icons.arrow_drop_up_outlined),
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: GeneralButton(
            onPressed: () {
              chooseImage();
            },
            child: Text("PICK IMAGE")),
      )),
    );
  }
}

class MyWidget2 extends StatelessWidget {
  const MyWidget2({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("data"),
      ),
    );
  }
}

class LoadingTry extends StatefulWidget {
  const LoadingTry({super.key});

  @override
  State<LoadingTry> createState() => _LoadingTryState();
}

class _LoadingTryState extends State<LoadingTry> {
  bool loading = true;
  void wait() async {
    await Future.delayed(Duration(milliseconds: 300));
    loading = false;
    setState(() {});
  }

  @override
  void initState() {
    wait();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(child: CircularProgressIndicator())
        : Center(child: Text("ENDED"));
  }
}

class KeepChildAlive extends StatefulWidget {
  const KeepChildAlive({super.key, required this.child, this.keepAlive = true});
  final Widget child;
  final bool keepAlive;
  @override
  State<KeepChildAlive> createState() => _KeepChildAliveState();
}

class _KeepChildAliveState extends State<KeepChildAlive>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return widget.child;
  }

  @override
  bool get wantKeepAlive => widget.keepAlive;
}
