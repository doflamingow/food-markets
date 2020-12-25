import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_foodmarket/services/services.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState>{

  //todo: Inisialisasi initial "state" dari UserState yaitu UserInitial
  UserCubit() : super(UserInitial());

  //todo: ------------------------------------- SIGN IN --------------------------------------------------------

  //todo: Prosedur/void signIn untuk mengubungkan method signIn di UserServices ke UI untuk digunakan
  //todo: Parameter yang digunakan yaitu String email dan String Password yang juga akan diberikan
  //todo: ke method signIn,
  Future<void> signIn(String email, String password) async {

    //todo: menjalankan method signIn dari UserServies dan menyimpan hasil ke 'result' yang merupakan model User
    ApiReturnValue<User> result = await UserServices.signIn(email, password);
    
    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data User
    if(result.value != null){

      //todo: data result.value disimpan di state UserLoaded, perubahan UserState dari UserInitial => UserLoaded
      emit(UserLoaded(result.value)); //* note: state UserLoaded mempunyai props User user

    } else { //! jika data result.value tidak tersedia maka result.message yang tersedia berarti mengalami kegagalan

      //todo: data result.message disimpan di state UserLoadingFailed, perubahan UserState dari UserInitial => UserLoadingFailed
      emit(UserLoadingFailed(result.message)); //* note: state UserLoadingFailed mempunyai props String message
    }
  }

  //todo: ------------------------------------- SIGN UP --------------------------------------------------------

  //todo: Prosedur/void signUp untuk mengubungkan method signUp di UserServices ke UI untuk digunakan
  //todo: Parameter yang digunakan yaitu String email, String Password dan File pictureFile yang juga akan diberikan
  //todo: ke method signUp,
  Future<void> signUp(User user, String password, {File pictureFile}) async {

    //todo: menjalankan method signUp dari UserServies dan menyimpan hasil ke 'result' yang merupakan model User
    ApiReturnValue<User> result = await UserServices.signUp(user, password, pictureFile: pictureFile);

    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data User
    if(result.value != null){

      //todo: data result.value disimpan di state UserLoaded, perubahan UserState dari UserInitial => UserLoaded
      emit(UserLoaded(result.value)); //* note: state UserLoaded mempunyai props User user

    } else { //! jika data result.value tidak tersedia maka result.message yang tersedia berarti mengalami kegagalan
      
      //todo: data result.message disimpan di state UserLoadingFailed, perubahan UserState dari UserInitial => UserLoadingFailed
      emit(UserLoadingFailed(result.message)); //* note: state UserLoadingFailed mempunyai props String message
    }
  }

  //todo: ------------------------------------- UPLOAD PROFILE PICTURE ------------------------------------------------

  //todo: Prosedur/void uploadProfilePicture untuk mengubungkan method uploadProfilePicture di UserServices ke UI untuk digunakan
  //todo: Parameter yang digunakan yaitu File pictureFile yang juga akan diberikan
  //todo: ke method uploadProfilePicture,
  Future<void> uploadProfilePicture(File pictureFile) async {

    //todo: menjalankan method uploadProfilePicture dari UserServies dan menyimpan hasil ke 'result' yang merupakan String
    ApiReturnValue<String> result = await UserServices.uploadProfilePicture(pictureFile);

    //todo: cek jika data result.value tersedia, maka
    //*note: value merupakan data String Image Path
    if(result.value != null){

      //todo: data result.value disimpan di state UserLoaded dengan menambahkan result.value ke props UserLoaded User user dengan method copyWith di user.picturePath
      emit(UserLoaded((state as UserLoaded).user.copyWith(picturePath : "http://foodmarket-backend.buildwithangga.id/storage/" + result.value))); 

    } else { //! jika data result.value tidak tersedia maka result.message yang tersedia berarti mengalami kegagalan

      //todo: data result.message disimpan di state UserLoadingFailed, perubahan UserState dari UserInitial => UserLoadingFailed
      emit(UserLoadingFailed(result.message)); //* note: state UserLoadingFailed mempunyai props String message
      
    }
  }
  
}