part of 'food_cubit.dart';

abstract class FoodState extends Equatable{
  const FoodState();

  @override
  List<Object> get props => [];
}

class FoodInitial extends FoodState {} // Untuk Initial State dari Food 

class FoodLoaded extends FoodState { // Untuk menerima data yang ke Load dan mengembalikannya
  final List<Food> foods;

  FoodLoaded(this.foods);

  @override
  List<Object> get props => [foods];
}

class FoodLoadingFailed extends FoodState { // Untuk menerima pesan ketika gagal load yang mengembalikanya
  final String message;

  FoodLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}