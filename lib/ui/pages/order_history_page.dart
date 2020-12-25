part of 'pages.dart';

class OrderHistoryPage extends StatefulWidget {
  @override
  _OrderHistoryPageState createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  int selectedIndex = 0;

  //* Semacam Query dimana mencari dari mockTransaction TransactionStatus sesuai dengan enum/type yang didefinisikan
  //* List<Transaction> inProgress = mockTransaction
  //*   .where((element) => 
  //*     element.status == TransactionStatus.on_delivery || 
  //*     element.status == TransactionStatus.pending 
  //*   ).toList();

  //* List<Transaction> past = mockTransaction
  //*   .where((element) => 
  //*     element.status == TransactionStatus.delivered || 
  //*     element.status == TransactionStatus.cancelled 
  //*   ).toList();

  
  @override
  Widget build(BuildContext context) {

    // todo: ------------------------------ SCREEN CONTENT -----------------------------------

    // todo: BlocBuilder untuk menghubungkan widget2 dengan BlocProvider, 
    //* menghubungkan widget dengan TransactionCubit dan TransactionState, Transaction telah diinisiasi (getTransactions()) di Sign In Page / Address Page
    return BlocBuilder<TransactionCubit, TransactionState>(builder: (_, state){ // todo: parameter 'state' di builder adalah TransactionState
      if(state is TransactionLoaded){ // todo: cek jika state sekarang adalah TransactionLoaded dari TransactionInitial maka
        if (state.transactions.length == 0 ){ // todo: cek jika TransactionLoaded.transactions = tidak berisi / kosong

          // todo: ------------------------------ ILLUSTRATION PAGE --------------------------------------

          return IllustrationPage(
            title: "Ouch! Hungry",
            subtitle: 'Seems you like have not\nordered any food yet',
            picturePath: 'lib/assets/love_burger.png',
            buttonTap1: (){
              Get.offAll(MainPage(initialPage: 0)); //todo: Navigasi ke FoodPage()
            },
            buttonTitle1: 'Finds Foods',
          );

          // todo: --------------------------- END OF : ILLUSTRATION PAGE -----------------------------------

        } 
        else {

          // todo: ------------------------------ ORDER HISTORY CONTENT --------------------------------------

          double listItemWidth = MediaQuery.of(context).size.width - 2 * defaultMargin; //* inisialisasi listItemWidth untuk dipakai di props itemWidth (OrderListItem)
          return RefreshIndicator( // todo: RefreshIndicator, screen bisa tarik kebawah

            // todo: onRefesh, untuk jika screen di tarik kebawah maka menjalankan function tertentu
            onRefresh: () async{
              // todo: saat refresh memanggil function getTransaction di TransactionsCubit, untuk mengambil kembali data Transaction
              await context.bloc<TransactionCubit>().getTransactions();
            },

            // todo: -------------------------- SCREEN : ORDER HISTORY CONTENT ------------------------------------

            child: ListView(
              children: [
                
                // todo: Column untuk keseluruhan content
                Column(
                  children: [

                    // todo: ----------------------------------- HEADER ------------------------------------------
                    Container(
                      height: 100, //* Container Header dengan height 100
                      width: double.infinity, //* width Container sesuai layar
                      margin: EdgeInsets.only(bottom: defaultMargin),
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                      color: Colors.white, //* Background Color Container white
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                        mainAxisAlignment: MainAxisAlignment.center, //* Column (MainAxisAlignment/Vertical) <=> center
                        children: [

                          // todo: title Text("Your Orders")
                          Text('Your Orders', style: blackFontStyle1),

                          // todo: subtitle Text("Wait for the best meal")
                          Text('Wait for the best meal', style: greyFontStyle.copyWith(fontWeight: FontWeight.w300))
                        ],
                      ),
                    ),
                    
                    // todo: ------------------------------------- BODY ------------------------------------------
                    Container(
                      width: double.infinity,  //* width Container sesuai layar
                      color: Colors.white, //* Background Color Container white

                      // todo: Column (CustomTabBar) & mapping (OrderListItem)
                      child: Column(
                        children: [

                          // todo: CustomTabBar
                          CustomTabBar(
                            titles: ['In Progress', 'Past Orders'], //* Inisialisasi titles type []
                            // todo: props selectedIndex di CustomTabBar di isi set selectedIndex yang telah mendapatkan nilai index dari onTap(index)
                            // todo: menentukan title active dan content body active di Builder
                            selectedIndex: selectedIndex,
                            onTap: (index){ //todo: untuk mendapatkan index dari props onTap terklik di CustomTabBar kemudian di set ke selectedIndex
                              //todo: untuk menentukan title active dan content body active di Builder
                              setState(() {
                                selectedIndex = index;
                              });
                            },
                          ),

                          // todo: Gap CustomTabBar sama OrderListItem
                          SizedBox(height: 16),

                          // todo: OrderListItem
                          // todo: BlocBuilder untuk menghubungkan widget2 dengan BlocProvider dan Pengecekan 'state' telah di lakukan di atas,
                          //* maka data List<Transaction> sudah tidak null, dan dilakukan Builder untuk Content Transaction
                          Builder(builder: (_){

                            // todo: Menampilkan Content CustomTabBar
                            //* Content Custom Tab Bar berdasarkan selectedIndex yang didapatkan dari props onTap dari CustomTabBar
                            //* List<Transaction> di saring menggunakan query 'where' berdasarkan selectedIndex & Transaction.status [] dan disimpan ke 'transaction'
                            List<Transaction> transaction = (selectedIndex == 0) ?
                              state.transactions.where((element) => 
                                element.status == TransactionStatus.on_delivery || 
                                element.status == TransactionStatus.pending 
                              ).toList() 
                              :
                              state.transactions.where((element) => 
                                element.status == TransactionStatus.delivered || 
                                element.status == TransactionStatus.cancelled 
                              ).toList();

                            return Column( // todo: Column untuk OrderListItem
                              children: transaction
                                .map((e) => Padding( // todo: memapping transactions yang telah disaring berdasarkan selectedIndex & Transaction.status []
                                  padding: const EdgeInsets.only( //todo: OrderListItem dibungkus Padding biar berjarak antar OrderListItem
                                    right: defaultMargin,
                                    left: defaultMargin,
                                    bottom: 16
                                  ),
                                  child: GestureDetector( //todo: untuk mengklik pending transaction ke MIdTrans untuk dilanjutkan pembayaran
                                    onTap: () async {
                                      if(e.status == TransactionStatus.pending){ // todo: Jika Transaction.status =  TransactionStatus.pending
                                        await launch(e.paymentUrl); // todo: maka diarahkan/launch halaman web MidTrans
                                      }
                                    },
                                    child: OrderListItem( // todo: FoodListItem membutuhkan transction yang telah disaring dan itemWidth
                                      transaction: e, //* transaction di assign e[i]
                                      itemWidth: listItemWidth //* itemWidth di assign listItemWidth yang didefinisikan
                                    ),
                                  ),
                                ))
                                .toList(), // todo: Mapping data toList()
                            );
                          }),
                          
                          // todo: Gap CustomTabBar dengan bagian Bawah agar tidak tertutup CustomBottomNavBar
                          SizedBox(height: 60)
                        ]
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );

          // todo: --------------------------- END OF : ORDER HISTORY CONTENT ----------------------------

        }
      } else {

        // todo: ------------------------------ LOADING INDICATOR --------------------------------------

        return Center(
          child: loadingIndicator
        );

        // todo: -------------------------- END OF : LOADING INDICATOR --------------------------------
      }
    });

    // todo: ------------------------------ END OF : SCREEN CONTENT -----------------------------------

  }
}