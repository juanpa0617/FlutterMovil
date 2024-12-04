import 'package:bookedge/widget/utilities/card_component.dart';
import 'package:flutter/material.dart';

class Grid extends StatelessWidget {
  final List<Map<String, dynamic>> items;

  const Grid({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, 
        childAspectRatio: 0.79,  
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return CardComponent(data: items[index]);  
      },
    );
  }
}