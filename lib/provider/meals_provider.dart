import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/data/dummy_data.dart';

// we use Provider when we have have static dummy data which never changes in the future
final mealsProvider = Provider((ref) {
  return dummyMeals;
});
