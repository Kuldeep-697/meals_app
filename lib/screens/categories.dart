import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/model/category_model.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_item.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:meals_app/provider/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class CategoriesScreen extends ConsumerStatefulWidget {
  const CategoriesScreen({super.key});
  @override
  ConsumerState<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends ConsumerState<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        lowerBound: 0,
        upperBound: 1);

    _animationController.forward();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    void selectCategory(BuildContext context, Category category) {
      final filteredMeals = availableMeals
          .where((meal) => meal.categories.contains(category.id))
          .toList();

      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
              )));
    }

    void setMealsScreen(String identifier) async {
      if (identifier == 'Meals category') {
        Navigator.of(context).pop();
      } else {
        Navigator.of(context).pop();
        Navigator.of(context).push<Map<Filter, bool>>(
            MaterialPageRoute(builder: (context) => const FiltersScreen()));
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Category'),
      ),
      drawer: MainDrawer(onSelectScreen: setMealsScreen),
      body: AnimatedBuilder(
        animation: _animationController,
        child: GridView(
            padding: const EdgeInsets.all(20),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20),
            children: [
              for (final category in availableCategories)
                CategoryItem(
                    category: category,
                    onSelectCategory: () {
                      selectCategory(context, category);
                    })
            ]),
        builder: (context, child) => SlideTransition(
            position:
                Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.easeInOut)),
            child: child),
      ),
    );
  }
}
