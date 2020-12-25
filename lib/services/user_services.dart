part of 'services.dart';

class UserServices {

  //todo: ------------------------------------- SIGN IN --------------------------------------------------------

  //todo: static method signIn untuk Sign In dan mengembalikan model User
  //todo: dengan paramenter email dan password yang akan dilempar ke backend
  static Future<ApiReturnValue<User>> signIn(String email, String password, {http.Client client}) async {
    await Future.delayed(Duration(milliseconds: 500)); //todo: delay koneksi dalam proses signIn kira2, 0.5 detik
    
    //todo: Jika http.Client null maka membuat http.Client yang baru
    if (client == null){
      client = http.Client();
    }

    String url = baseUrl + 'login'; //* Inisialisasi baseUrl + login => Url API untuk Login

    //todo: Initialisasi var 'response' untuk menampung respon dari API Login
    var response = await client.post( //* Method 'POST' untuk API login
      url, //* url API Login
      headers: {"Content-Type" : "application/json"}, //* Header yang diperlukan dalam Akses API Login
      //* Body yang diperlukan dalam API Login, sesuaikan dengan body yang diperlukan oleh API Login
      body: jsonEncode(<String, String>{'email': email, 'password' : password}) 
    );
    
    //todo: cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again'); //todo: mengembalikan String message
    }

    //todo: Jika berhasil, mengubah response.body API Login menjadi json dan menyimpan ke data
    var data = jsonDecode(response.body);
    
    // todo: RESPONSE API Login
    //* Karena access_token berada di
    //* {
    //*  "data": {
    //*   "access_token": "4|Akd99dZcP3Ef8eRpzNitjqK0C29gjxn50Nuz4fbK",
    //*  }
    //* }, jadi pengambilan access_token sebegai berikut :

    //todo: mengambil data access_token, untuk akses API Login dan menyimpan ke model User.token
    User.token = data['data']['access_token']; //* cara menyimpan User.token yang bersifat static bukan final jadi tidak perlu method copyWith()

    // todo: RESPONSE API Login
    //* Karena Response User berada di
    //* {
    //*  "data": {
    //*    "user": {
    //*        "id": 8,
    //*        "name": "Jennie Kim",
    //*        "email": "jennie.kim@blackpink.co",
    //*        "email_verified_at": null,
    //*        "roles": "USER",
    //*        "current_team_id": null,
    //*        "picturePath": null,
    //*        "address": "Jalan Jenderal Sudirman",
    //*        "houseNumber": "1234",
    //*        "phoneNumber": "08123456789",
    //*        "city": "Bandung",
    //*        "created_at": "2020-09-18T11:51:44.000000Z",
    //*        "updated_at": "2020-09-18T11:51:44.000000Z",
    //*        "profile_photo_url": "https://ui-avatars.com/api/?name=Jennie+Kim&color=7F9CF5&background=EBF4FF"
    //*    },
    //*   }
    //* }, jadi pengambilan user sebegai berikut :

    //todo: User.fromJson, method dari model User untuk mengubah Json menjadi Object dan menyimpan ke value yang bertype User
    User value = User.fromJson(data['data']['user']);

    //todo: mengembalikan value yang telah diubah menjadi Object
    return ApiReturnValue(value: value);
  }

  //todo: ------------------------------------- SIGN UP --------------------------------------------------------

  //todo: method: Sign Up / Register untuk Sign Up dan mengembalikan model User
  //todo: dengan paramenter model User yang sudah terisi sebelumnya (dengan method copyWith) 
  //todo: password dan pictureFile untuk method uploadProfilePicture dengan API Upload Photo 
  //todo: yang akan dilempar ke backend
  static Future<ApiReturnValue<User>> signUp(User user, String password, {File pictureFile, http.Client client}) async {
    
    //todo: cek jika http.Client null maka membuat http.Client yang baru
    if (client == null){
      client = http.Client();
    }

    //* Inisialisasi baseUrl + register => Url API untuk Register
    String url = baseUrl + 'register';

    //todo: Initialisasi var 'response' untuk menampung respon dari API Register
    var response = await client.post( //* Method 'POST' untuk API Register
      url, //* url API Register
      headers: { //* Header yang diperlukan dalam Akses API Register
        "Content-Type" : "application/json"
      },
      //* Body yang diperlukan dalam API Register, sesuaikan dengan body yang diperlukan oleh API Register
      body: jsonEncode(<String, String>{
        'name' :  user.name,
        'email' :  user.email,
        'password' :  password,
        'password_confirmation' :  password,
        'address' :  user.address,
        'city' :  user.city,
        'houseNumber' :  user.houseNumber,
        'phoneNumber' :  user.phoneNumber,
      })
    );

    //todo: cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again'); //todo: mengembalikan String message
    }

    //todo: Jika berhasil, mengubah response.body API menjadi json dan menyimpan ke data
    var data = jsonDecode(response.body);
    
    //* Karena token berada di
    //* {
    //*  "data": {
    //*   "access_token": "4|Akd99dZcP3Ef8eRpzNitjqK0C29gjxn50Nuz4fbK",
    //*  }
    //* }, jadi pengambilan access_token sebegai berikut :

    //todo: mengambil data access_token, untuk akses API lain dan menyimpan ke model User.token
    User.token = data['data']['access_token'];  //* cara menyimpan User.token yang bersifat static bukan final jadi tidak perlu method copyWith()

    // todo: RESPONSE API Register
    //* Karena user berada di
    //* {
    //*  "data": {
    //*    "user": {
    //*        "id": 8,
    //*        "name": "Jennie Kim",
    //*        "email": "jennie.kim@blackpink.co",
    //*        "email_verified_at": null,
    //*        "roles": "USER",
    //*        "current_team_id": null,
    //*        "picturePath": null,
    //*        "address": "Jalan Jenderal Sudirman",
    //*        "houseNumber": "1234",
    //*        "phoneNumber": "08123456789",
    //*        "city": "Bandung",
    //*        "created_at": "2020-09-18T11:51:44.000000Z",
    //*        "updated_at": "2020-09-18T11:51:44.000000Z",
    //*        "profile_photo_url": "https://ui-avatars.com/api/?name=Jennie+Kim&color=7F9CF5&background=EBF4FF"
    //*    },
    //*   }
    //* }, jadi pengambilan user sebegai berikut :

    //todo: fromJson, method dari model User untuk mengubah Json menjadi Object dan menyimpan ke value yang yang bertype User
    User value = User.fromJson(data['data']['user']);

    // todo: Upload pictureFile,
    if (pictureFile != null){ //todo: cek dulu jika pictureFile masih kosong maka,
      //todo: harus melakukan Upload Foto oleh Function UI dan menjalankan method uploadProfilePicture() dengan parameter File pictureFile
      //todo: result untuk menampung return dari result uploadProfilePicture() yaitu String path dari API Upload Photo
      ApiReturnValue<String> result = await uploadProfilePicture(pictureFile); 
      if(result.value != null){ //todo: cek jika result sudah ada maka,
        //todo: value merupakan result User dari response API Register kemudian di edit/tambahkan di 
        //todo: value.picturePath result dari UploadProfilePicture() dengan method copyWith
        value = value.copyWith( 
          //* karena kembalian dari UploadProfilePicture() adalah String path, maka perlu ditambahkan baseUrl storage 
          //* di depan String Path, agar bisa diakses di UI NetworkImage
          picturePath: "http://foodmarket-backend.buildwithangga.id/storage/" + result.value
        );
      }
    }

    // limk picturePath
    // http://foodmarket-backend.buildwithangga.id/storage/assets/user/OSm5hmSmjiCMR2lq1tS3hPljeVC9nFBLVeuhanPS.jpeg

    //todo: mengembalikan value yang telah menjadi Object dan sudah ditambahkan picturePath
    return ApiReturnValue(value: value);
  }

  //todo: ------------------------------------- UPLOAD PROFILE PICTURE ------------------------------------------------

  //todo: method uploadProfilePicture mengembalikan String Path dari storage API, 
  //todo: API yang digunakan yaitu API Upload Photo, method uploadProfilePicture()
  //todo: membutuhkan parameter File pictureFile yang diberikan method signUp()
  static Future<ApiReturnValue<String>> uploadProfilePicture(File pictureFile, {http.MultipartRequest request}) async {
    
    //todo: Inisialisasi baseUrl + 'user/photo' => Url API untuk Upload Photo
    String url = baseUrl + 'user/photo';

    //todo: parse url(baseUrl + 'user/photo') menjadi Uri dan disimpan di var 'Uri'
    //* note: Karena url masih berupa String, Yg diperlukan di Multipart adalah objek dari Uri, Jadi harus diubah dulu dari String ke Uri.
    var uri =  Uri.parse(url);

    //todo: cek Jika request == null maka,
    if (request == null){
      // todo: maka membuat baru request http.MultipartRequest dengan header
      //* note: kenapa menggunakan MultipartRequest karena data pictureFile bersifat 
      //* binary content (images, various documents, etc)
      request = http.MultipartRequest("POST", uri) //* Method 'POST' untuk API Upload Photo
      ..headers["Content-Type"] = "application/json" //* penggunaan header di MultipartRequest
      ..headers["Authorization"] = "Bearer ${User.token}"; //* menggunakan User.token di headers dalam akses API
    }

    //todo: Membuat MultipartFile dari parameter File pictureFile menggunakan filepath
    var multipartFile = await http.MultipartFile.fromPath('file', pictureFile.path);

    //todo: Menambahkan multipartFile ke request yang sudah dibuat sebelumnya
    request.files.add(multipartFile);

    //todo: mengirim request yang sudah dibuat sebelumnya berdasarkan API Upload Photo
    //todo: kemudian menyimpan response dari API tersebut ke var 'response'
    //* note response masih berbentuk ByteStream
    var response = await request.send();
    
    //todo: cek jika response.statusCode 200 berarti berhasil mendapatkan response yang sesuai
    if (response.statusCode == 200){
      
      //todo: menconvert response API Upload Photo dari berbentuk ByteStream ke String dan menyimpan ke var 'responseBody'
      String responseBody = await response.stream.bytesToString();

      //todo: mengubah responseBody API menjadi json dan menyimpan ke data
      var data = jsonDecode(responseBody);
      
      // todo: RESPONSE API Upload Photo
      //* Untuk mendapatkan picture, var data yang berbentuk json sbg berikut
      //* {
      //*   "meta": {
      //*     "code": 200,
      //*     "status": "success",
      //*     "message": "File successfully uploaded"
      //*   },
      //*   "data": [
      //*     "assets/user/ATanl6hpJ0TjWOGQg06VhFQkwgqszk3S1TTIxQVe.png"
      //*   ]
      //* }, untuk mengambil sebegai berikut :
      
      //todo: mendapatkan data image path di data['data'][0] dan disimpan di imagePath
      String imagePath = data['data'][0]; 

      //todo: mengembalikan value String imagePath, nanti dipakai di Sign Up
      return ApiReturnValue(value: imagePath);

    } else { //! cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai

      // todo: mengembalikan String pesan error
      return ApiReturnValue(message: 'Uploading Profile Picture Failed');
    }

  }
}