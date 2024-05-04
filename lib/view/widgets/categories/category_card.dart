import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/core/constants/colors.dart';
import 'package:my_ecommerce_admin/data/model/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {super.key,
      required this.categoryModel,
      required this.onTap,
      required this.onDeleteTap,
      required this.onInfoTap});
  final CategoryModel categoryModel;
  final void Function() onTap;
  final void Function() onInfoTap;
  final void Function() onDeleteTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      splashColor: AppColors.thirdColor10.withOpacity(0.4),
      title: Text(
        categoryModel.catName!,
        style: const TextStyle(
            fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
      ),
      subtitle: Text(
        categoryModel.catDesc!,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      leading: categoryModel.catImageUrl == null
          ? null
          : SizedBox(
              height: 70,
              width: 70,
              child: categoryModel.catImageUrl!.toLowerCase().endsWith("svg")
                  ? SvgPicture.network(
                      "${APILinks.categoriesImages}/${categoryModel.catImageUrl}",
                    )
                  : Image.network(
                      "${APILinks.categoriesImages}/${categoryModel.catImageUrl}"),
            ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
              onPressed: onInfoTap,
              icon: const Icon(
                Icons.info,
                color: AppColors.thirdColor10,
              )),
          IconButton(
              onPressed: onDeleteTap,
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
