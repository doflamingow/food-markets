part of 'transaction_cubit.dart';

abstract class TransactionState extends Equatable{
  const TransactionState();

  @override
  List<Object> get props => [];
}

class TransactionInitial extends TransactionState {} // Untuk Initial State dari Transaction 

class TransactionLoaded extends TransactionState { // Untuk menerima data yang ke Load dan mengembalikannya
  final List<Transaction> transactions;

  TransactionLoaded(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class TransactionLoadingFailed extends TransactionState { // Untuk menerima pesan ketika gagal load yang mengembalikanya
  final String message;

  TransactionLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}