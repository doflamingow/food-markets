import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState>{

  //todo: Inisialisasi initial "state" dari TransactionState yaitu TransactionInitial
  TransactionCubit() : super(TransactionInitial());

  //todo: ------------------------------------- GET TRANSACTIONS --------------------------------------------------------

  //todo: Prosedur/void getTransactions untuk mengubungkan method getTransactions di TransactionServices ke UI untuk digunakan
  Future<void> getTransactions() async {

    //todo: menjalankan method getTransactions dari TransactionServices dan menyimpan hasil ke 'result' yang merupakan List<Transaction>
    ApiReturnValue<List<Transaction>> result = await TransactionServices.getTransactions();
    
    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data List<Transaction>
    if(result.value != null){

      //todo: data result.value disimpan di state FoodLoaded, perubahan TransactionState dari TransactionInitial => TransactionLoaded
      emit(TransactionLoaded(result.value)); //* note: state FoodLoaded mempunyai props List<Transaction> transactions

    } else { //! jika data result.value tidak tersedia maka result.message yang tersedia berarti mengalami kegagalan 

      //todo: data result.message disimpan di state TransactionLoadingFailed, perubahan TransactionState dari TransactionInitial => TransactionLoadingFailed
      emit(TransactionLoadingFailed(result.message)); //* note: state TransactionLoadingFailed mempunyai props String message
    }
  }

  //todo: ------------------------------------- GET TRANSACTIONS --------------------------------------------------------

  //todo: Prosedur/void submitTransaction untuk mengubungkan method submitTransaction di TransactionServices ke UI untuk digunakan
  //todo: Parameter yang digunakan yaitu Transaction(include, User & Food) yang juga akan diberikan
  //todo: ke method submitTransaction, submitTransaction mengembalikan String paymentUrl untuk Launch ke Midtrans di UI
  Future<String> submitTransaction(Transaction transaction) async {

    //todo: menjalankan method submitTransaction dari TransactionServices dan menyimpan hasil ke 'result' yang merupakan model Transaction
    ApiReturnValue<Transaction> result = await TransactionServices.submitTransaction(transaction);

    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data Transaction
    if(result.value != null){
      
      //todo: result.value ditambahkan ke TransactionLoaded, di props transaaction []/List
      emit(TransactionLoaded(
        (state as TransactionLoaded).transactions + [result.value]
      ));

      // todo: kemudian mengembalikan String result.value.paymentUrl (Transaction.paymentUrl) untuk Launch ke Midtrans di UI
      return result.value.paymentUrl;

    } else { //! cek jika result.value kosong berarti gagal mendapatkan response yang sesuai

      // todo: mengembalikan nilai null;
      return null;
    }
  }
  
}