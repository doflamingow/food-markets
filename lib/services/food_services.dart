part of 'services.dart';

class FoodServices {

  //todo: ------------------------------------- GET FOODS --------------------------------------------------------

  //todo: static method getFoods dan mengembalikan List/[] Food
  static Future<ApiReturnValue<List<Food>>> getFoods({http.Client client}) async {
    
    //todo: Jika http.Client null maka membuat http.Client yang baru
    client ??= http.Client();

    String url = baseUrl + 'food'; //* Inisialisasi baseUrl + food => Url API Food

    //todo: Initialisasi var 'response' untuk menampung respon dari API Food
    var response = await client.get(url); //* Method 'GET' untuk API Food
 
    //todo: cek jika response.statusCode selain 200 berarti gagal mendapatkan response yang sesuai
    if (response.statusCode != 200){
      return ApiReturnValue(message: 'Please try again'); //todo: mengembalikan String message
    } 

    //todo: Jika berhasil, mengubah response.body API Food menjadi json dan menyimpan ke var data
    var data = jsonDecode(response.body);

    // todo: RESPONSE API Food
    // {
    //   "data": {
    //      "current_page": 1,
    //       "data": [
    //           {
    //              "id": 1,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/Z8bVCbRMsuob0X7MVXNG5tfFptuSFG9OtN02IcCI.jpeg",
    //              "name": "Soup Bumil",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 289000,
    //              "rate": 4,
    //              "types": "new_food",
    //              "deleted_at": null,
    //              "created_at": 1600840945000,
    //              "updated_at": 1600840945000
    //           },
    //           {
    //              "id": 2,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/w0t9SoAvRvjmhGaoLzMcHAMsm9OuqGxEDsGL7gKv.jpeg",
    //              "name": "Chicken",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 4509000,
    //              "rate": 5,
    //              "types": "new_food,recommended",
    //              "deleted_at": null,
    //              "created_at": 1600841059000,
    //              "updated_at": 1600841059000
    //           },
    //           {
    //              "id": 3,
    //              "picturePath": "http://foodmarket-backend.buildwithangga.id/storage/assets/food/dqGSTKOJE5zZNNH0BTfZjt3ogxRjLuwVpvP6Drx4.jpeg",
    //              "name": "Shrimp",
    //              "description": "Makanan khas Bandung yang cukup sering dipesan oleh anak muda dengan pola makan yang cukup tinggi dengan mengutamakan diet yang sehat dan teratur.",
    //              "ingredients": "Seledri, telur, blueberry, madu",
    //              "price": 999000,
    //              "rate": 3,
    //              "types": "popular",
    //              "deleted_at": null,
    //              "created_at": 1600841118000,
    //              "updated_at": 1600841118000
    //           }
    //       ]
    //     }
    // }, jadi pengambilan food sebegai berikut :

    //todo: Food.fromJson, method dari model Food untuk mengubah Json menjadi Object dan menyimpan ke foods yang bertype Food
    //todo: Karena data masih berbentuk json Array/[] maka perlu di ubah menjadi Object List/[] dan disimpan di List<Food> foods
    List<Food> foods = (data["data"]["data"] as Iterable)
      .map((e) => Food.fromJson(e))
      .toList();

    //todo: mengembalikan foods yang telah diubah menjadi Object List/[]
    return ApiReturnValue(value: foods); 
  }
  
}