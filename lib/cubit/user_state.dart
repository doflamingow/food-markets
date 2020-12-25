part of 'user_cubit.dart';

abstract class UserState extends Equatable{
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {} // Untuk Initial State dari User 

class UserLoaded extends UserState { // Untuk menerima data yang ke Load dan mengembalikannya
  final User user;

  UserLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class UserLoadingFailed extends UserState { // Untuk menerima pesan ketika gagal load yang mengembalikanya
  final String message;

  UserLoadingFailed(this.message);

  @override
  List<Object> get props => [message];
}