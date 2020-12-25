part of 'pages.dart';

class PaymentPage extends StatefulWidget {
  final Transaction transaction; //* PaymentPage() menerima data Transaction dari FoodDetailPage()

  PaymentPage({this.transaction});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  bool isLoading = false; //* Inisialisasi isLoading untuk menampilakan loadingIndicator

  @override
  Widget build(BuildContext context) {
    // todo: ----------------------------------- HEADER -------------------------------------------

    return GeneralPage(
      title: 'Payment',
      subtitle: 'You deserve better meal',
      onBackButtonPressed: () {
        Get.back();
      },
      backColor: 'FAFAFC'.toColor(),

      // todo: --------------------------------- BODY : SCREEN CONTENT -------------------------------------

      // todo: Column untuk keseluruhan content
      child: Column(
        children: [
          
          // todo: ------------------------ CONTAINER : PAYMENT ( DATA TRANSACTION & FOOD ) ----------------------------------

          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white, //* Background Color Container White

            // todo: ------------------------ COLUMN u/ content PAYMENT ( DATA TRANSACTION & FOOD ) ----------------------------------

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
              children: [

                // todo: title Text ('Item Ordered')
                Text(
                  'Item Ordered',
                  style: blackFontStyle3,
                ),

                // todo: Gap title Text ('Item Ordered') dan ROW [transaction.food.picturePath, transaction.food.name & transaction.food.price] dan |transaction.quantity|
                SizedBox(
                  height: 12,
                ),

                //todo:  ROW [[[transaction.food.picturePath, transaction.food.name & transaction.food.price]]] dan [[transaction.quantity]]
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  crossAxisAlignment: CrossAxisAlignment.center, //* Row (CrossAxisAlignment/Vertical) <=> center
                  children: [

                    // todo: ROW => transaction.food.picturePath dan (transaction.food.name & transaction.food.price)
                    Row(
                      children: [

                        // todo: Container dengan Background transaction.food.picturePath
                        Container(
                          width: 60, //* ukuran Container width x height <=> 30 x 30 <=> untuk transaction.food.picturePath
                          height: 60,
                          margin: EdgeInsets.only(right: 12), //* Jarak dengan Column (transaction.food.name & transaction.food.price)
                          decoration: BoxDecoration( //* Container => decoration => BoxDecoration => DecorationImage => NetworkImage (transaction.food.picturePath)
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(widget.transaction.food.picturePath),
                              fit: BoxFit.cover
                            ),
                          ),
                        ),

                        // todo: COLUMN (transaction.food.name & transaction.food.price)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                          children: [

                            //todo: SizedBox untuk pixel dari Text (transaction.food.name) agar tidak melebih width
                            SizedBox(
                              width: MediaQuery.of(context).size.width - //* lebar layar HP - 
                              2 * defaultMargin -  //* (2 * margin horizontal (24))
                              60 - //* (width FOOD IMAGE)
                              12 - //* (margin FOOD IMAGE ke SizedBox FOOD NAME)
                              78, //* (width QUANTITY)

                              //todo: Text transaction.food.name,
                              child: Text(
                                widget.transaction.food.name,
                                style: blackFontStyle2,
                                maxLines: 1,
                                overflow: TextOverflow.clip, //* jika melebihi SizedBox maka '...' 
                              ),
                            ),

                            // todo: Text Currency-ID 'transaction.food.price'
                            Text(
                              NumberFormat
                                .currency(
                                  locale: 'id-ID',
                                  symbol: 'IDR ', //* prefix dari format transaction.food.price
                                  decimalDigits: 0
                                )
                                .format(
                                  widget.transaction.food.price
                                ),
                              style: greyFontStyle.copyWith(fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),

                    // todo: Text 'transaction.quantity'
                    Text(
                      '${widget.transaction.quantity} item(s)',
                      style: greyFontStyle.copyWith(fontSize: 13),
                    ),

                  ],
                ),

                // todo: title Text "Details Transaction"
                Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 8), //todo: title Text "Details Transaction" dibungkus Padding untuk memberi jarak ke atas dan bawah

                  // todo: Text "Details Transaction"
                  child: Text(
                    "Details Transaction",
                    style: blackFontStyle3,
                  ),
                ),
                
                //todo: -------------------------------------- FOOD NAME & TOTAL TRANSACTION -----------------------------------------------

                // todo: ROW => Text transaction.food.name dan Text transaction.total
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text (transaction.food.name) agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text transaction.food.name,
                      child: Text(
                        widget.transaction.food.name,
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text (transaction.total) agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text Currency-ID 'transaction.total'
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ', //* prefix dari format transaction.total
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                //todo: -------------------------------------- DELIVERY FEE -----------------------------------------------

                // todo: ROW => Text 'Driver' dan Text 'Delivery Fee => 50.000'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Driver' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Driver',
                      child: Text(
                        "Driver",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'Delivery Fee' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text Currency-ID 'Delivery Fee => 50.000'
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ', //* prefix dari format Delivery Fee
                            decimalDigits: 0
                          )
                          .format(
                            50000 //* set Default
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ TAX 10% --------------------------------------------------------

                // todo: ROW => Text 'Tax 10%' dan Text 'Tax => transaction.total * 0.1'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Tax 10%' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Tax 10%',
                      child: Text(
                        "Tax 10%",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'Tax => transaction.total * 0.1' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text Currency-ID 'Tax => transaction.total * 0.1'
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ', //* prefix dari nilai Tax 10%
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total * 0.1 //* nilai Tax didapatkan dari transaction.total * 0.1 
                          ),
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ TOTAL --------------------------------------------------------

                // todo: ROW => Text 'Total' dan Text 'Total => transaction.total * 1.1 + 50000'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Total' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Total',
                      child: Text(
                        "Total",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.total * 1.1 + 50000' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text Currency-ID 'transaction.total * 1.1 + 50000'
                      child: Text(
                        NumberFormat
                          .currency(
                            locale: 'id-ID',
                            symbol: 'IDR ',//* prefix dari nilai Tax 10%
                            decimalDigits: 0
                          )
                          .format(
                            widget.transaction.total * 1.1 + 50000 //* nilai total diambil dari transaction.total * 1.1 + 50.000 => Delivery Fee
                          ),
                        style: blackFontStyle3.copyWith(fontWeight: FontWeight.w500, color: '1ABC9C'.toColor()),
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6), 
                  ],
                ),

              ],
            ),
          ),

          // todo: ------------------------ CONTAINER : PAYMENT ( DATA USER ) ----------------------------------

          Container(
            margin: EdgeInsets.only(bottom: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: defaultMargin, vertical: 16),
            color: Colors.white,

            // todo: ------------------------ COLUMN u/ content PAYMENT ( DATA USER ) ----------------------------------
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // todo: title Text ('Deliver to : ')
                Padding( //todo: Text ('Deliver to : ') untuk memberi jarak ke atas dan bawah
                  padding: EdgeInsets.only(top: 16, bottom: 8),

                  //todo: Text 'Deliver to : ',
                  child: Text(
                    "Deliver to : ",
                    style: blackFontStyle3,
                  ),
                ),

                //todo: ------------------------------------------------ NAME --------------------------------------------------------

                // todo: ROW => Text 'Name' dan Text 'transaction.food.name'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Name' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Name',
                      child: Text(
                        "Name",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.food.name' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'transaction.user.name',
                      child: Text(
                        widget.transaction.user.name,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ PHONE NUMBER --------------------------------------------------------

                // todo: ROW => Text 'Phone No. ' dan Text 'transaction.food.phoneNumber'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Phone No.' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Phone No.',
                      child: Text(
                        "Phone No.",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.food.phoneNumber' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'transaction.user.phoneNumber',
                      child: Text(
                        widget.transaction.user.phoneNumber,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ ADDRESS --------------------------------------------------------

                // todo: ROW => Text 'Address' dan Text 'transaction.food.address'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'Address' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'Address',
                      child: Text(
                        "Address",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.user.address' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'transaction.user.address',
                      child: Text(
                        widget.transaction.user.address,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ HOUSE NUMBER --------------------------------------------------------

                // todo: ROW => Text 'House No.' dan Text 'transaction.food.houseNumber'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'House No.' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'House No.',
                      child: Text(
                        "House No.",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.user.name' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'transaction.user.name',
                      child: Text(
                        widget.transaction.user.houseNumber,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

                SizedBox(height: 6),

                //todo: ------------------------------------------------ CITY --------------------------------------------------------

                // todo: ROW => Text 'City' dan Text 'transaction.food.city'
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start, //* Row (CrossAxisAlignment/Vertical) <=> start
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                  children: [

                    //todo: SizedBox untuk pixel dari Text 'City agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'City',
                      child: Text(
                        "City",
                        style: greyFontStyle,
                      ),
                    ),

                    //todo: SizedBox untuk pixel dari Text 'transaction.user.city' agar tidak melebihi batas width
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2 - defaultMargin - 5, //* (Lebar Layar HP / 2) - defaultMargin(margin Horizonotal) - 5 (untuk jarak)

                      //todo: Text 'transaction.user.city',
                      child: Text(
                        widget.transaction.user.city,
                        style: blackFontStyle3,
                        textAlign: TextAlign.end, //* Text ditaruh dibelakang/end secara horizontal
                      ),
                    ),
                    SizedBox(height: 6),
                  ],
                ),

              ],
            ),
          ),

          //todo: ------------------------------------------- BUTTON "CHECKOUT NOW"-------------------------------------------
          
          //todo: cek isLoading jika true maka
          (isLoading) ? (
            Center(child: loadingIndicator,) //todo: menampilkan loadingIndicator
          ) : (
            //todo: menampilkan Container untuk Button 'CHECKOUT NOW'
            Container(
              width: double.infinity,
              height: 45, //* height Container
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),

              //todo: RaisedButton 'Checkout Now'
              child: RaisedButton(
                onPressed: () async {

                  //todo: men-set isLoading true untuk menampilkan loadingIndicator selama menjalankan submitTransaction() dari TransactionCubit
                  setState(() {
                    isLoading = true;
                  });

                  //todo: menjalankan submitTransaction dari TransactionCubit dan mengembalikan String paymentUrl, 
                  String paymentUrl = await context.bloc<TransactionCubit>().
                    submitTransaction( //todo: submitTransaction membutuhkan parameter Transaction
                      widget.transaction.copyWith( //todo: melengkapi Transaction dengan dateTime dan total
                        dateTime: DateTime.now(),
                        total: (widget.transaction.total * 1.1).toInt() + 50000
                      )
                  );

                  if (paymentUrl != null){ //todo: Jika paymentUrl ter-load maka

                    Get.to(PaymentMethodPage(paymentUrl)); //todo: Navigasi ke PaymentMethodPage(), PaymentMethodPage() membutuhkan String paymentUrl

                  } else { //! Jika paymentUrl gagal ter-load maka

                    //todo: men-set isLoading false untuk menghentikan loadingIndicator
                    setState(() {
                      isLoading = false;
                    });

                    //! Notify/Pop Up Error dari Get snackbar
                    Get.snackbar(
                      "", "",
                      backgroundColor: "D9435E".toColor(),
                      icon: Icon(
                        MdiIcons.closeCircleOutline,
                        color: Colors.white
                      ),
                      titleText: Text(
                        "Transaction Failed",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                      messageText: Text(
                        "Please try again later",
                        style: GoogleFonts.poppins(
                          color: Colors.white
                        ),
                      )
                    );
                  }
                },
                elevation: 5, //* Jarak dari Backgroud ke RaisedButton 
                shape: RoundedRectangleBorder( //* shape Border dari RaisedButton
                  borderRadius: BorderRadius.circular(8) //* value Radius dari RaisedButton
                ),
                color: mainColor, //* Background Color RaisedButton

                // todo: isi child dari RaisedButton yaitu Widget Text('Checkout Now')
                child: Text(
                  'Checkout Now',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            )
          )
        ]
      ),

      // todo: --------------------------------- END OF : SCREEN CONTENT -------------------------------------
    );
  }
}