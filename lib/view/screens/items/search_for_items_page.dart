import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/controllers/items/search_for_items_page_controller.dart';
import 'package:my_ecommerce_admin/data/model/items_model.dart';
import 'package:my_ecommerce_admin/view/widgets/items/search_text_field.dart';

class SearhcForItemsPage extends StatelessWidget {
  const SearhcForItemsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearhcForItemsPageController());
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: const Size(double.infinity, 50),
            child: SearchTextField(
              controller: controller.searchController,
              onChanged: (p0) {
                controller.search();
              },
            )),
        title: const Text("Search"),
        centerTitle: true,
      ),
      body: GetBuilder(
          init: controller,
          builder: (controller) {
            return ListView.builder(
              itemCount: controller.searchItems.length,
              itemBuilder: (context, index) {
                ItemModel itemModel = controller.searchItems[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      controller.goToItemDetailsPage(itemModel);
                    },
                    title: Text(
                      itemModel.itemsName!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: SizedBox(
                      height: 60,
                      width: 60,
                      child: Image.network(
                          "${APILinks.itemImages}/${itemModel.imageUrl}"),
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
