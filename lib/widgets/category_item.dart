import 'package:flutter/material.dart';
import 'package:meals_app/model/category_model.dart';

class CategoryItem extends StatelessWidget {

  const CategoryItem({
    super.key, 
    required this.category, 
    required this.onSelectCategory
  });

  final Category category;
  final void Function() onSelectCategory;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelectCategory,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.55),
              category.color.withOpacity(0.9),
            ], 
            begin: Alignment.topLeft, 
            end: Alignment.bottomRight
          ),
        ),
        child: Center(
          child: Text(
            category.title,
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20
                ),
          ),
        ),
      ),
    );
  }
}