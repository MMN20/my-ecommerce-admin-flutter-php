import 'package:flutter/material.dart';
import 'package:my_ecommerce_admin/api_links.dart';
import 'package:my_ecommerce_admin/data/model/promotion_model.dart';

class PromotionTile extends StatelessWidget {
  const PromotionTile(
      {super.key,
      required this.promotion,
      required this.onTap,
      required this.onLongPress});
  final PromotionModel promotion;
  final void Function() onTap;
  final void Function() onLongPress;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onLongPress,
      child: ListTile(
        onTap: onTap,
        title: Text(
          promotion.promotionsTitle!,
          style: const TextStyle(fontSize: 25),
        ),
        subtitle: Text(
          promotion.promotionsBody!,
          style: const TextStyle(fontSize: 20),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: SizedBox(
          height: 1500,
          width: 150,
          child: Image.network(
            "${APILinks.promotionImages}/${promotion.promotionsImageUrl!}",
            filterQuality: FilterQuality.low,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
