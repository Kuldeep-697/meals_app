import 'package:flutter/material.dart';
import 'package:meals_app/model/meal_model.dart';
import 'package:meals_app/screens/meal_item_detail.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealsScreen extends StatefulWidget {
  const MealsScreen({super.key, this.title, required this.meals});

  final String? title;
  final List<Meal> meals;
  
  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {

  void onSelectedItem(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => MealItemDetailsScreen(meal: meal))
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget content = Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            )
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a diffrent category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground
            )
          ),
        ],
      ),
    );

    if (widget.meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: widget.meals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: widget.meals[index], 
          onTapMeal: (meal) {
            onSelectedItem(context, meal);
          }
        )
      );
    }

    if (widget.title == 'Your Favorites') {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title!)),
        body: content,
      );
    } 
    else {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title!)),
        body: content,
      );
    }
  }
}
