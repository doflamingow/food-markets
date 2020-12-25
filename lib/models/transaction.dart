part of 'models.dart';

//* Transaction Status Type
enum TransactionStatus { 
  delivered, 
  on_delivery, 
  pending, 
  cancelled 
}

class Transaction extends Equatable{
  final int id;
  final Food food;
  final int quantity;
  final int total;
  final DateTime dateTime;
  final TransactionStatus status;
  final User user;
  final String paymentUrl;

  Transaction({
    this.id, 
    this.food,
    this.quantity,
    this.total,
    this.dateTime,
    this.status,
    this.user,
    this.paymentUrl
  });

  // todo: Method copyWith untuk mencopy Transaction agar bisa di edit, jadi jika ingin mengedit maka datanya masuk ke copyWith
  //* note: Transaction typenya Equatable dan atributenya final semua jadi tidak bisa didedit
  Transaction copyWith({
    int id,
    Food food,
    int quantity,
    int total,
    DateTime dateTime,
    TransactionStatus status,
    User user,
  }){
    return Transaction( //* bisa diedit tapi ??(jika kosong) maka menggunakan data lama
      id : id ?? this.id, 
      food: food ?? this.food,
      quantity: quantity ?? this.quantity,
      total: total ?? this.total,
      dateTime: dateTime ?? this.dateTime,
      status: status ?? this.status,
      user: user ?? this.user
    );
  }

  @override
  List<Object> get props => [id, food, quantity, total, dateTime, status, user];
  //

  //todo: Transaction.fromJson, method untuk mengubah Json menjadi Object, 
  //todo: parameter yang dibutuhkan adalah response API yang sudah diconvert menjadi Json
  //todo: dan mengembalikan ke value yang yang bertype Transaction
  //* note dynamic maksudnya jika ada type selain String.
  factory Transaction.fromJson(Map<String, dynamic> data) => Transaction(
    id: data['id'],
    quantity: data['quantity'],
    total: data['total'],
    dateTime: DateTime.fromMillisecondsSinceEpoch(data['created_at']), //* "created_at": 1600403217000, bertype milliseconds(since created) diubah ke DateTime()
    food: Food.fromJson(data['food']),
    status: (data['status'] == 'PENDING') 
              ? TransactionStatus.pending
              : (data['status'] == 'DELIVERED') 
                ? TransactionStatus.delivered
                : (data['status'] == 'CANCELLED')
                  ? TransactionStatus.cancelled
                  : TransactionStatus.on_delivery,
    paymentUrl: data['payment_url'] //* url payment dari backend Mi Trans
  );
}

List<Transaction> mockTransaction = [
  Transaction(
    id: 1,
    food: mockFoods[1],
    quantity: 10,
    total: (mockFoods[1].price * 10 * 1.1).round() + 50000, // 1.1 tax 50.000 delivery fee
    dateTime: DateTime.now(),
    status: TransactionStatus.on_delivery,
    user: mockUser
  ),
  Transaction(
    id: 2,
    food: mockFoods[2],
    quantity: 7,
    total: (mockFoods[2].price * 7 * 1.1).round() + 50000,
    dateTime: DateTime.now(),
    status: TransactionStatus.delivered,
    user: mockUser
  ),
  Transaction(
    id: 3,
    food: mockFoods[3],
    quantity: 5,
    total: (mockFoods[3].price * 5 * 1.1).round() + 50000,
    dateTime: DateTime.now(),
    status: TransactionStatus.cancelled,
    user: mockUser
  ),
]; 