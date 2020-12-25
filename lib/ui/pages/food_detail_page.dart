part of 'pages.dart';

class FoodDetailPage extends StatefulWidget {
  final Function onBackPressed; //* props Function onBackPressed untuk navigasi Back ke FoodPage()
  final Transaction transaction; //* Karena diinisialisasi Transaction jadi required/props Transaction.Food data saat pindah dari food_page.dart ke food_detail_page.dart

  FoodDetailPage({this.onBackPressed, this.transaction});
  @override
  _FoodDetailPageState createState() => _FoodDetailPageState();
}

class _FoodDetailPageState extends State<FoodDetailPage> {
  int quantity = 1; //* inisialisasi quantity untuk Transaction.quantity 

  @override
  Widget build(BuildContext context) {

    // todo: ------------------------------ SCREEN CONTENT -----------------------------------

    // todo: Scaffold disini untuk memberi backround screen sampai ke atas(sinyal, jam dll)
    return Scaffold(

      //todo:  STACK <=> LAYER 
      body: Stack(
        children: [

          //todo: ------------------------------- LAYER PERTAMA ------------------------------------------

          // todo: Stack Child => background MainColor sampai ke atas(sinyal, jam dll) (layer Pertama)
          Container(
            color: mainColor,
          ),

          //todo: ------------------------------- LAYER KEDUA ------------------------------------------

          // todo: Stack Child => SafeArea => hanya pada screen app (layer kedua)
          SafeArea(

            // todo: Container pada layer kedua untuk memberi custom background color
            child: Container( 
              color: Colors.white
            ),

          ),

          //todo: ------------------------------- LAYER KETIGA ------------------------------------------

          // todo: Stack Child => SafeArea => hanya pada screen app (layer ketiga)
          SafeArea(

            // todo: Container dengan background transaction.food.picturePath yang sudah di terima dari FoodPage()
            child: Container(
              height: 300, //* Container memiliki height 300 yang berarti transaction.food.picturePath juga mempunyai height 300
              width: double.infinity,
              decoration: BoxDecoration( //* Container => decoration => BoxDecoration => DecorationImage => NetworkImage
                image: DecorationImage(
                  image: NetworkImage(widget.transaction.food.picturePath), //todo widget.transaction dan widget.onBackPressed, it means memanggil transaction/onBackPressed yang didefinisikan (khusus statefull) karena ditaruh diatas hehe...
                  fit: BoxFit.cover
                ),
              ),
            ),
          ),

          //todo: ------------------------------- LAYER KE-EMPAT ------------------------------------------

          //todo: Stack Child =>SafeArea => hanya pada screen app (layer keempat)
          SafeArea(

            // todo: ListView biar screen bisa di Scroll
            child: ListView(
              children: [

                // todo: Column untuk keseluruhan widget Isi Content
                Column(
                  children: [

                    // todo: ------------------------------- HEADER WITH (BACK BUTTON) -----------------------------------
                    
                    // todo Container untuk Button onBackPressed
                    Container(
                      height: 100, //* height Container hanya 100 karena untuk Header
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),

                      // todo: Align merupakan widget untuk positioning component/widget terhadap parent/container
                      child: Align( 
                        alignment: Alignment.centerLeft, // todo set alignment widget child => centerleft 

                        //todo: GestureDetector, BACK BUTTON merupakan Container dengan child Image.assets, jadi biar bisa diklik menggunakan GestureDetector
                        child: GestureDetector(
                          onTap: () {
                            if(widget.onBackPressed != null){ //todo Jika props Function onBackPressed telah ada/diterima
                              widget.onBackPressed(); //todo: maka menggunakan onBackPressed
                            }
                          },

                          // todo: Container untuk Image Back(back_arrow_white.png')
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: 40,  //* height dan width Container 40x40
                            height: 40,
                            // color: Colors.grey, //* tidak bisa menggunakan color dan decoration secara bersamaan, gunakan "decoration: BoxDecoration(color: color)".
                            decoration: BoxDecoration( 
                              borderRadius: BorderRadius.circular(100),//* decoration => BoxDecoration => full Circular BorderRadius
                              color: Colors.grey, //* background Color Container Grey
                            ),
                            
                            // todo: child Image selain menggunakan Container => decoration => BoxDecoration => AssetImage
                            child: Image.asset('lib/assets/back_arrow_white.png'),
                          ),
                        ),
                      ),
                    ),

                    // todo: ------------------------------- BODY (FOOD DESCRIPTION) -----------------------------------
                    
                    //todo: Container untuk FOOD DECRIPTION
                    Container(
                      margin: EdgeInsets.only(top: 180), //* Untuk jarak agar tidak menimpa transaction.food.picturePath di Layer Ketiga, 100 height (header) + marginTop 180 = 280 (-20 untuk menutupi layer ketiga)
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 26),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20), //* BorderRadius hanya di topLeft dan topRight
                          topRight: Radius.circular(20)
                        ),
                        color: Colors.white //* background Color Container White
                      ),

                      // todo: Column untuk content FOOD DECRIPTION
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                        children: [
                          
                          // todo: -------------------------------------- NAME, RATING, COUNTER ---------------------------------

                          // todo: ROW untuk (transaction.food.name, transaction.food.rating) dan Counter(quantity)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                            children: [
                              
                              // todo: COLUMN untuk (transaction.food.name, transaction.food.rating)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                                children: [

                                  // todo: SizedBox untuk (transaction.food.name) agar tidak melebihi batas width
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width - 32 - 102, // 32 padding Horizontal Container Parent dan 102 dari total width Counter
                                    
                                    //todo: Text transaction.food.name,
                                    child: Text(
                                      widget.transaction.food.name,
                                      style: blackFontStyle2,
                                      overflow: TextOverflow.clip,
                                    ),
                                  ),

                                  //todo: Gap Text transaction.food.name dan transaction.food.rating
                                  SizedBox(height: 6),

                                  // todo: transaction.food.rating menggunakan widget/component RatingStars
                                  RatingStars(widget.transaction.food.rate)
                                ],
                              ),
                              
                              // todo: Row untuk 'Counter' quantity
                              Row(
                                children: [

                                  // todo: Gesture Detector, karena Minus Button Container dengan AssetImage jadi membutuhkan Gesture Detector untuk bisa diklik menggurangi quantity
                                  GestureDetector(
                                    onTap: (){
                                      setState(() { //todo: set quantity dengan mengurangi nilai quantity dengan maximal aksi pengurangan ketika 1 (minimal 1 pembelian)
                                        quantity = max(1, quantity - 1);
                                      });
                                    },

                                    // todo: Container untuk Minus Button,  decoration => BoxDecoration => DecorationImage => AssetImage (btn_min.png)
                                    child: Container(
                                      width: 26, //* height dan width Minus Button 26x26
                                      height: 26,
                                      decoration: BoxDecoration( //* decoration => BoxDecoration => DecorationImage => AssetImage (btn_min.png)
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1), //* border width 1
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "lib/assets/btn_min.png"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  //todo: SizedBox untuk Text quantity 
                                  SizedBox(
                                    width: 50,
                                    child: Text(
                                      quantity.toString(), //todo: Karena quatity bertype int jadi diconvert dulu ke String
                                      textAlign: TextAlign.center, //* TextAlign center
                                      style: blackFontStyle2
                                    ),
                                  ),

                                  // todo: Gesture Detector, karena Add Button Container dengan AssetImage jadi membutuhkan Gesture Detector untuk bisa diklik menambah quantity
                                  GestureDetector(
                                    onTap: () {
                                      setState(() { //todo: set quantity dengan menambah nilai quantity dengan maximal aksi penambahan ketika 99 (maksimal pembelian 99)
                                        quantity = min(99, quantity + 1); // 99 batas pembelian
                                      });
                                    },

                                    // todo: Container untuk Add Button, decoration => BoxDecoration => DecorationImage => AssetImage (btn_add.png)
                                    child: Container(
                                      width: 26, //* height dan width Add Button 26x26
                                      height: 26,
                                      decoration: BoxDecoration( //* decoration => BoxDecoration => DecorationImage => AssetImage (btn_add.png)
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1), //* border width 1
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "lib/assets/btn_add.png"
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // todo: --------------------------------------------- DESCRIPTION ---------------------------------------
                          
                          // todo: Container untuk Text transaction.food.description
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 14, 0, 16),
                            child: Text(
                              widget.transaction.food.description,
                              style: greyFontStyle
                            ),
                          ),

                          // todo: --------------------------------------------- INGREDIENTS ---------------------------------------
                          
                          // todo: Text 'Ingredients' title untuk Text transaction.food.ingredients
                          Text(
                            'Ingredients',
                            style: blackFontStyle3
                          ),
                          
                          //todo: Container untuk Text transaction.food.ingredients
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 4, 0, 41),

                            // todo: Text transaction.food.ingredients
                            child: Text(
                              widget.transaction.food.ingredients,
                              style: greyFontStyle,
                            ),
                          ),

                          // todo: --------------------------------------- ROW (TOTAL PRICE & BUTTON ORDER NOW) ------------------------------------------

                          // todo: Row untuk (Text "Total Price" & Text Currency-ID 'transaction.total') dan Button "Order Now"
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                            children: [
                              
                              // todo: Column untuk title Text "Total Price" dan Text Currency-ID 'transaction.total'
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                                children: [

                                  // todo: title Text "Total Price"
                                  Text(
                                    'Total Price',
                                    style: greyFontStyle.copyWith(fontSize: 13)
                                  ),

                                  // todo: Text Currency-ID 'transaction.total'
                                  Text(
                                    NumberFormat
                                      .currency(
                                        locale: 'id-ID',
                                        symbol: 'IDR ', //* prefix dari format transaction.total
                                        decimalDigits: 0
                                      ).format(quantity * widget.transaction.food.price), //* transaction.total didapatkan dari perjumlahan quantity (yang sudah didefnisikan) dan transaction.food.price
                                    style: blackFontStyle2.copyWith(fontSize: 18)
                                  )
                                ],
                              ),
                              
                              // todo: SizedBox untuk pixel RaisedButton "Order Now"
                              SizedBox(
                                width: 163, //* pixel SizedBox untuk pixel RaisedButton 163.h x 45.w 
                                height: 45,
                                child: RaisedButton(
                                  onPressed: () {
                                    Get.to(PaymentPage( //todo: Ketika diklik akan dinavigasikan ke PaymentPage dan melengkapi Transaction dengan transaction.quantity dan transaction.total
                                      transaction: widget.transaction.copyWith(
                                        quantity: quantity,
                                        total: quantity * widget.transaction.food.price
                                      )
                                    ));
                                  },
                                  color: mainColor, //* Background RaisedButton yaitu mainColor
                                  elevation: 5, //* Jarak RaisedButton ke Background
                                  shape: RoundedRectangleBorder( //* shape RaisedButton Rounded dengan BorderRadius 8
                                    borderRadius: BorderRadius.circular(8)
                                  ),

                                  // todo: isi child dari RaisedButton yaitu Widget Text('Order Now')
                                  child: Text(
                                    'Order Now',
                                    style: blackFontStyle3.copyWith(
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // todo: ------------------------------ END OF : SCREEN CONTENT -----------------------------------
  }
}