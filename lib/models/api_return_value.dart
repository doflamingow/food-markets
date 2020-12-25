part of 'models.dart';

// Class yang akan digunakan sebagai type kembalian dari services2 yang dibuat
// dalam memanggil API kemungkinan ada 2 yaitu
// Berhasil => akan mendapatkan valuenya
// Gagal => tidak mendapatkan apa-apa dan menampilkan message kesalahan

class ApiReturnValue<T>{
  final T value;
  final String message;

  ApiReturnValue({this.message, this.value});
}