import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField(
      {super.key, required this.controller, required this.onChanged});
  final TextEditingController controller;
  final Function(String) onChanged;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: const InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(width: 0.1),
          ),
          hintText: "Search",
          suffixIcon: Icon(Icons.search),

          // icon: const Icon(Icons.search),
          prefix: Padding(padding: EdgeInsets.only(left: 10))),
    );
  }
}
