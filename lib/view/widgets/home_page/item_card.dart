import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  const ItemCard(
      {super.key,
      required this.assets,
      required this.name,
      required this.onTap});
  final String assets;
  final String name;
  final void Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: Image.asset(
                  assets,
                  fit: BoxFit.cover,
                ),
              ),
              Text(name)
            ],
          ),
        ),
      ),
    );
  }
}
