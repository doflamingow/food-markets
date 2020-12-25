import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'food_state.dart';

class FoodCubit extends Cubit<FoodState>{

  //todo: Inisialisasi initial "state" dari FoodState yaitu FoodInitial
  FoodCubit() : super(FoodInitial());

  //todo: ------------------------------------- GET FOODS --------------------------------------------------------

  //todo: Prosedur/void getFoods untuk mengubungkan method getFoods di FoodServices ke UI untuk digunakan
  Future<void> getFoods() async {

    //todo: menjalankan method getFoods dari FoodServices dan menyimpan hasil ke 'result' yang merupakan List<Food>
    ApiReturnValue<List<Food>> result = await FoodServices.getFoods();

    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data List<Food>
    if(result.value != null){

      //todo: data result.value disimpan di state FoodLoaded, perubahan FoodState dari FoodInitial => FoodLoaded
      emit(FoodLoaded(result.value)); //* note: state FoodLoaded mempunyai props List<Food> foods

    } else { //! jika data result.value tidak tersedia maka result.message yang tersedia berarti mengalami kegagalan 
      
      //todo: data result.message disimpan di state FoodLoadingFailed, perubahan FoodState dari FoodInitial => FoodLoadingFailed
      emit(FoodLoadingFailed(result.message)); //* note: state FoodLoadingFailed mempunyai props String message
    }
  }
  
}