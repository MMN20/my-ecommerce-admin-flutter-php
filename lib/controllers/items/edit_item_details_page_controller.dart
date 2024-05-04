import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/controllers/items/add_images_page_controller.dart';
import 'package:my_ecommerce_admin/controllers/items/add_specs_page_controller.dart';
import 'package:my_ecommerce_admin/controllers/items/edit_item_specs_controller.dart';
import 'package:my_ecommerce_admin/core/class/request_status.dart';
import 'package:my_ecommerce_admin/core/functions/handle_request_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/categories_data.dart';
import 'package:my_ecommerce_admin/data/data_source/remote/sub_categories_data.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';
import 'package:my_ecommerce_admin/data/model/items_model.dart';
import 'package:my_ecommerce_admin/data/model/specification.dart';
import 'package:my_ecommerce_admin/data/model/sub_category_model.dart';
import 'package:my_ecommerce_admin/routes.dart';
import 'package:my_ecommerce_admin/view/widgets/general_button.dart';

class EditItemDetailsPageController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  TextEditingController discountController = TextEditingController();

  bool isActive = true;
  late ItemModel currentItem;

  // this will hold the data that will be sent to the next page
  Map<String, dynamic> data = {};
  late Map<String, dynamic> currentCat;
  late List<Specification> specs;

  List<CategoryModel> categories = [];
  List<SubCategoryModel> subCategories = [];
  RequestStatus requestStatus = RequestStatus.loading;

  CategoryModel? selectedCategory;
  SubCategoryModel? selectedSubCategory;

  void initData() async {
    nameController.text = currentItem.itemsName!;
    descController.text = currentItem.itemsDesc!;
    priceController.text = currentItem.itemsPrice!.toStringAsFixed(2);
    qtyController.text = currentItem.itemsQty!.toString();
    discountController.text = currentItem.discount!.toString();
    isActive = currentItem.isActive == 1;

    selectedCategory = CategoryModel.fromJson(currentCat);
    selectedSubCategory = SubCategoryModel.fromJson(currentCat);

    await getAllCategories();
    getAllSubCategories(selectedCategory!);
  }

  Future<void> getAllCategories() async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response = await CategoriesData.getAllCategories();
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        List responseData = response['data'];
        print(responseData);
        categories =
            responseData.map((e) => CategoryModel.fromJson(e)).toList();
        categories.forEach((element) {
          if (element.catId == selectedCategory!.catId) {
            selectedCategory = element;
          }
        });
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
  }

  Future<void> getAllSubCategories(CategoryModel category) async {
    requestStatus = RequestStatus.loading;
    update();
    dynamic response =
        await SubCategoriesData.getAllSubCategories(category.catId.toString());
    requestStatus = hanldeRequestData(response);
    if (requestStatus == RequestStatus.success) {
      if (response['status'] == 'success') {
        subCategories.clear();
        List responseData = response['data'];
        subCategories =
            responseData.map((e) => SubCategoryModel.fromJson(e)).toList();
        subCategories.forEach((element) {
          if (element.subcatId == selectedSubCategory!.subcatId) {
            selectedSubCategory = element;
          }
        });
      } else {
        requestStatus = RequestStatus.empty;
      }
    }
    update();
  }

  void changeActiveStatus(bool newVal) {
    isActive = newVal;
    update();
  }

  void selectSubCategory(SubCategoryModel subCategoryModel) {
    selectedSubCategory = subCategoryModel;
  }

  void allertAboutClosingCurrentTree() {
    Get.dialog(Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
                "If you close this page then you will lose all of the progress, Are you sure?",
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GeneralButton(
                  onPressed: () {
                    Get.back();
                    Get.back();
                  },
                  child: const Text("Yes"),
                ),
                GeneralButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text("Cancel")),
              ],
            )
          ],
        ),
      ),
    ));
  }

  bool isValidData() {
    if (selectedCategory == null || selectedSubCategory == null) {
      Get.snackbar("Category",
          "Please select the category and the subcategory for this item");
      return false;
    }
    data['id'] = currentItem.itemsId.toString();
    data['name'] = nameController.text;
    data['desc'] = descController.text;
    data['price'] = priceController.text;
    data['qty'] = qtyController.text;
    data['discount'] = discountController.text;
    data['isActive'] = isActive ? "1" : "0";
    data['catid'] = selectedCategory!.catId.toString();
    data['subcatid'] = selectedSubCategory!.subcatId.toString();
    return true;
  }

  void goToSpecsPage() {
    if (isValidData()) {
      Get.toNamed(AppRoutes.editItemSpecsPage,
          arguments: {'data': data, 'specs': specs});
    }
  }

  void changeCurrentCategory(CategoryModel cat) {
    if (selectedCategory != cat) {
      selectedCategory = cat;
      selectedSubCategory = null;
      getAllSubCategories(cat);
    }
  }

  @override
  void onClose() {
    Get.delete<EditItemSpecsPageController>(force: true);
    super.onClose();
  }

  @override
  void onInit() {
    currentItem = Get.arguments['item'];
    currentCat = Get.arguments['cat'];
    specs = Get.arguments['specs'];
    initData();
    super.onInit();
  }
}
