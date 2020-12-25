part of 'services.dart';

class TransactionServices {

  //todo: ------------------------------------- GET TRANSACTIONS --------------------------------------------------------

  //todo: static method getTransactions dan mengembalikan List/[] Transaction
  static Future<ApiReturnValue<List<Transaction>>> getTransactions({http.Client client}) async {

    //todo: Jika http.Client null maka membuat http.Client yang baru
    client ??= http.Client();

    // Inisialisasi base URL
    String url = baseUrl + 'transaction/?limit=1000'; //* Inisialisasi baseUrl + transaction => Url API transaction, 
    //*note: /?limit=1000 membatasi jumlah list/[] menjadi 1000

    //todo: Initialisasi var 'response' untuk menampung respon dari API Transaction
    var response = await client.get( //* Method 'GET' untuk API Transaction
      url, //* url API Transaction
      headers: { //* Header yang diperlukan dalam Akses API Transaction
        "Content-Type" : "application/json",
        "Authorization" : "Bearer ${User.token}" //* menggunakan User.token di headers dalam akses API Trasaction
      }
    );

    //todo: cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again'); //todo: mengembalikan String message
    } 

    //todo: Jika berhasil, mengubah response.body API Transaction menjadi json dan menyimpan ke var data
    var data = jsonDecode(response.body);

    // todo: RESPONSE API Transaction
    // {
    //   "data": {
    //     "current_page": 1,
    //     "data": [
    //       {
    //         "id": 1,
    //         "food_id": 1,
    //         "user_id": 1,
    //         "quantity": 1,
    //         "total": 100000,
    //         "status": "DELIVERED",
    //         "payment_url": "https://app.sandbox.midtrans.com/snap/v2/vtweb/bcd3e4b7-6d01-435c-88ab-b3da45b9c66a#/select-payment",
    //         "deleted_at": null,
    //         "created_at": "2020-09-18T18:18:23.000000Z",
    //         "updated_at": "2020-09-18T18:18:23.000000Z",
    //         "food": {
    //           "id": 1,
    //           "picturePath": "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    //           "name": "Sate Sayur Sultan",
    //           "description": "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    //           "ingredients": "Bawang Merah, Paprika, Bawang Bombay, Timun",
    //           "price": 150000,
    //           "rate": 4.2,
    //           "types": "recommended,popular",
    //           "deleted_at": null,
    //           "created_at": "2020-09-17T13:43:54.000000Z",
    //           "updated_at": "2020-09-17T13:43:54.000000Z"
    //         },
    //         "user": {
    //           "id": 1,
    //           "name": "Galih Pratama",
    //           "email": "hanamura.iost@gmail.com",
    //           "email_verified_at": null,
    //           "roles": "USER",
    //           "current_team_id": null,
    //           "picturePath": null,
    //           "address": null,
    //           "houseNumber": null,
    //           "phoneNumber": null,
    //           "city": null,
    //           "created_at": "2020-09-17T06:05:01.000000Z",
    //           "updated_at": "2020-09-17T06:05:01.000000Z",
    //           "profile_photo_url": "https://ui-avatars.com/api/?name=Galih+Pratama&color=7F9CF5&background=EBF4FF"
    //         }
    //       }
    //     ]
    //   }
    // }, jadi pengambilan transaction sebegai berikut :

    //todo: Transaction.fromJson, method dari model Transaction untuk mengubah Json menjadi Object dan menyimpan ke transaction yang bertype Transaction
    //todo: Karena data masih berbentuk json Array/[] maka perlu di ubah menjadi Object List/[] dan disimpan di List<Transaction> transactions
    List<Transaction> transactions = (data["data"]["data"] as Iterable)
      .map((e) => Transaction.fromJson(e))
      .toList();
    
    //todo: mengembalikan transaction yang telah diubah menjadi Object List/[]
    return ApiReturnValue(value: transactions); 
  }

  //todo: ------------------------------------- SUBMIT TRANSACTIONS / CHECKOUT --------------------------------------------------------

  //todo: static method submitTransaction untuk untuk menginput transaction terbaru dari User
  //todo:parameter yang diperlukan yaitu Transaction(include, User dan Food)
  static Future<ApiReturnValue<Transaction>> submitTransaction(Transaction transaction, {http.Client client}) async {

    //todo: Jika http.Client null maka membuat http.Client yang baru
    client ??= http.Client();

    //* Inisialisasi baseUrl + checkout => Url API untuk Checkout
    String url = baseUrl + 'checkout';

    //todo: Initialisasi var 'response' untuk menampung respon dari API Checkout
    var response = await client.post( //* Method 'POST' untuk API Checkout
      url, //* url API Checkout
      headers: { //* Header yang diperlukan dalam Akses API Checkout
        "Content-Type" : "application/json",
        "Authorization" : "Bearer ${User.token}" //* menggunakan User.token di headers dalam akses API Checkout
      },
      body: //* Body yang diperlukan dalam API Checkout, sesuaikan dengan body yang diperlukan oleh API Checkout
        jsonEncode(<String, dynamic>{ //* jsonEncode mengubah object ke json lagi
          'food_id' : transaction.food.id,
          'user_id' : transaction.user.id,
          'quantity' : transaction.quantity,
          'total' : transaction.total,
          'status' : 'PENDING' //*default
        }
      )
    );

    //todo: cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again'); //todo: mengembalikan String message
    }

    //todo: Jika berhasil, mengubah response.body API Checkout menjadi json dan menyimpan ke data
    var data = jsonDecode(response.body);

    // todo: RESPONSE API Checkout
    // {
    //   "meta": {
    //     "code": 200,
    //     "status": "success",
    //     "message": "Transaksi berhasil"
    //   },
    //   "data": {
    //     "id": 5,
    //     "food_id": 1,
    //     "user_id": 1,
    //     "quantity": 1,
    //     "total": 200,
    //     "status": "PENDING",
    //     "payment_url": "https://app.sandbox.midtrans.com/snap/v2/vtweb/0feb4251-37d0-42b0-bea8-9147f75d29d9",
    //     "deleted_at": null,
    //     "created_at": "2020-09-20T10:55:12.000000Z",
    //     "updated_at": "2020-09-20T10:55:12.000000Z",
    //     "food": {
    //       "id": 1,
    //       "picturePath": "https://i.pinimg.com/736x/06/7b/28/067b2879e5c9c42ec669bf639c3fbffc.jpg",
    //       "name": "Sate Sayur Sultan",
    //       "description": "Sate Sayur Sultan adalah menu sate vegan paling terkenal di Bandung. Sate ini dibuat dari berbagai macam bahan bermutu tinggi. Semua bahan ditanam dengan menggunakan teknologi masa kini sehingga memiliki nutrisi yang kaya.",
    //       "ingredients": "Bawang Merah, Paprika, Bawang Bombay, Timun",
    //       "price": 150000,
    //       "rate": 4.2,
    //       "types": "recommended,popular",
    //       "deleted_at": null,
    //       "created_at": "2020-09-17T13:43:54.000000Z",
    //       "updated_at": "2020-09-17T13:43:54.000000Z"
    //     },
    //     "user": {
    //       "id": 1,
    //       "name": "Galih Pratama",
    //       "email": "hanamura.iost@gmail.com",
    //       "email_verified_at": null,
    //       "roles": "USER",
    //       "current_team_id": null,
    //       "picturePath": null,
    //       "address": null,
    //       "houseNumber": null,
    //       "phoneNumber": null,
    //       "city": null,
    //       "created_at": "2020-09-17T06:05:01.000000Z",
    //       "updated_at": "2020-09-17T06:05:01.000000Z",
    //       "profile_photo_url": "https://ui-avatars.com/api/?name=Galih+Pratama&color=7F9CF5&background=EBF4FF"
    //     }
    //   }
    // } jadi pengambilan transaction sebegai berikut :
    
    //todo: Transaction.fromJson, method dari model Transaction untuk mengubah Json menjadi Object dan menyimpan ke value yang bertype Transaction
    Transaction value = Transaction.fromJson(data['data']);

    //todo: mengembalikan value yang telah menjadi Object
    return ApiReturnValue(value: value);
  }
  
}