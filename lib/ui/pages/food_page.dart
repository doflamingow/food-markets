part of 'pages.dart';

class FoodPage extends StatefulWidget {
  @override
  _FoodPageState createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  int selectedIndex = 0; //* selectedIndex untuk index dari CustomTabbar ['New Taste', 'Popular, 'Recomended']
  @override
  Widget build(BuildContext context) {
    double listItemWidth = MediaQuery.of(context).size.width - 2 * defaultMargin; //* listItemWidth untuk width FoodListItem

    // todo: ------------------------------ SCREEN CONTENT -----------------------------------

    return ListView( // todo: ListView biar screen bisa di Scroll
      children: [

        // todo: Column untuk keseluruhan widget Isi Content
        Column(
          children: [

            // todo ------------------------------ HEADER ------------------------------------

            // todo: Container untuk HEADER
            Container(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              color: Colors.white, //* Background Color dari Container Header
              height: 100, //* height dari Header
              width: double.infinity,  //* width Header Container sesuai layar

              // todo: Row untuk Column(title, subtitle) dan Container(User.picturePath)
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween  
                children: [
                  
                  // todo: Text Row untuk Column(title, subtitle)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start, //* Column (CrossAxisAlignment/Horizontal) <=> start
                    mainAxisAlignment: MainAxisAlignment.center, //* Column (MainAxisAlignment/Vertical) <=> center
                    children: [

                      // todo: title Text("Food Market")
                      Text("Food Market", style: blackFontStyle1,),
                      
                      // todo: subtitle Text("Let's get some foods")
                      Text(
                        "Let's get some foods", 
                        style: greyFontStyle.copyWith(fontWeight: FontWeight.w300)
                      ),
                    ],
                  ),

                  // todo: Container untuk Image (User.picturePath)
                  Container(
                    width: 50,
                    height: 50,
                     //* Container decoration => BoxDecoration bisa punya background Image dengan DecorationImage
                    decoration: BoxDecoration( //* decoration -> BoxDecoration untuk style Box Container,
                      borderRadius: BorderRadius.circular(8), //* untuk Style Border Container
                      image: DecorationImage( //* decoration -> BoxDecoration -> DecorationImage
                        image: NetworkImage( //* decoration -> BoxDecoration -> DecorationImage -> NetworkImage (Image dari Internet)
                          // todo: Memanggil secara langsung User.picturePath melalui bloc apabila UserState sudah berada di UserLoaded
                          //* note: tidak perlu di cek UserState berada dimana karena sudah diload di Sign In / Address Page
                          (context.bloc<UserCubit>().state as UserLoaded).user.picturePath
                        ),
                        fit: BoxFit.cover //* ada contain, cover, fill dll
                      ),
                    ),
                  )
                ],
              ),
            ),

            // todo ------------------------------ LIST OF FOOD ----------------------------------

            // todo: Container untuk LIST FOOD Scrool Horizontal
            Container(
              height: 258, //* Container List Food dengan height 258
              width: double.infinity, //* width Container sesuai layar
              
              // todo: BlocBuilder untuk menghubungkan widget2 dengan BlocProvider, 
              //* menghubungkan widget dengan FoodCubit dan FoodState, Food telah diinisiasi (getFoods()) di Sign In PAge / Address Page
              child: BlocBuilder<FoodCubit, FoodState>( 
                
                // todo: cek Berada dimana FoodState parameter 'state' di builder adalah FoodState
                builder: (_, state) => (state is FoodLoaded) ? // todo: cek jika state sekarang adalah FoodLoaded dari FoodInitial maka
                ( 
                  // todo: menampilkan ListView scroll Horizontal dengan Widget Component FoodCard 
                  ListView(
                    scrollDirection: Axis.horizontal, //* scroll ke samping
                    children: [
                      // todo: Row untuk FoodCard
                      Row(
                        // todo: Memapping state.foods <=> FoodLoaded.foods ke FoodCard
                        children: state.foods.map((food) => Padding( //todo: FoodCard dibungkus Padding biar berjarak antar FoodCard
                          padding: EdgeInsets.only(
                            left: (food == state.foods.first) ? // todo: paddingLeft ditentukan apabila index ke [0] maka menggunakan defaultMargin
                            defaultMargin : 0, //! jika tidak maka 0
                            right: defaultMargin
                          ),

                          //todo: GestureDetector
                          child: GestureDetector( // todo: FoodCard dibungkus lagi dengan GestureDetector untuk navigasi ke FoodDetailPage
                            onTap: (){
                              Get.to(FoodDetailPage( //* FoodDetailPage membutuhkan parameter model Transaction yang ter-load dan onBackPreesed untuk kembali ke MainPage
                                transaction: Transaction( //* di model Transaction membutuhkan model Food dan User yang ter-load
                                  food: food,
                                  // todo: Memanggil secara langsung User melalui bloc/cubit apabila UserState sudah berada di UserLoaded
                                  user: (context.bloc<UserCubit>().state as UserLoaded).user
                                ),
                                onBackPressed: (){
                                  Get.back(); // todo: Navigasi kembali ke MainPage()
                                },
                              ));
                            },

                            //todo: FoodCard diisi state.foods
                            child: FoodCard(food) 
                            
                          ),
                        )).toList(), // todo: Mapping data toList()
                      ),
                    ],
                  )
                ) : Center(child: loadingIndicator,), // todo: jika masih tahap load/masih di FoodInitial maka menampilkan loadingIndicator 
              ),
            ),

            // todo -----------------------------LIST OF FOOD WITH TAB BAR---------------------------------

            // todo: Container untuk List Food dengan Custom Tabbar
            Container(
              width: double.infinity, //* width Container sesuai layar
              color: Colors.white, //* BackgroundColor Container berwarna putih

              // todo: Column untuk CustomTabBar dan FoodListItem
              child: Column(
                children: [
                  
                  // todo: CustomTabBar
                  CustomTabBar(
                    titles: ["New Taste", "Popular", "Recomended"],  //* Inisialisasi titles type [] 
                    onTap: (index){ //todo: untuk mendapatkan index dari props onTap di CustomTabBar kemudian di set ke selectedIndex untuk 
                      // todo: menentukan title active dan content body active di Builder
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    // todo: props selectedIndex di CustomTabBar di isi set selectedIndex yang telah mendapatkan nilai index dari onTap(index)
                    // todo: menentukan title active dan content body active di Builder
                    selectedIndex: selectedIndex,  
                  ),

                  // todo: Gap CustomTabBar sama FoodListItem
                  SizedBox(
                    height: 16,
                  ),

                  // todo: FoodListItem
                  // todo: BlocBuilder untuk menghubungkan widget2 dengan BlocProvider, 
                  //* menghubungkan widget dengan FoodCubit dan FoodState, Food telah diinisiasi (getFoods()) di Sign In / Address Page
                  BlocBuilder<FoodCubit, FoodState>(builder: (_, state) // Cara mengecek berada di state mana
                    {
                      // todo: cek Berada dimana FoodState parameter 'state' di builder adalah FoodState
                      if(state is FoodLoaded) { // todo: cek jika state sekarang adalah FoodLoaded dari FoodInitial maka

                        // todo: Menampilkan Content CustomTabBar
                        //* Content Custom Tab Bar berdasarkan selectedIndex yang didapatkan dari props onTap dari CustomTabBar
                        //* state.foods / FoodLoaded.foods di saring menggunakan query 'where' berdasarkan selectedIndex & Food.type [] dan disimpan ke 'foods'
                        List<Food> foods = state.foods.where(
                          (element) => element.types.contains(
                            (selectedIndex == 0) 
                              ? FoodType.new_food
                              :  (selectedIndex == 1)
                                ? FoodType.popular
                                : FoodType.recommended
                          )
                        ).toList();

                        return Column( // todo: Column untuk FoodListItem
                          children: 
                            foods.map( // todo: memapping foods yang telah disaring berdasarkan selectedIndex & Food.type []
                              (food) => 
                                Padding( //todo: FoodListItem dibungkus Padding biar berjarak antar FoodListItem
                                  padding: EdgeInsets.fromLTRB(defaultMargin, 0, defaultMargin, 16),
                                  child: FoodListItem( // todo: FoodListItem membutuhkan food dan itemWidth
                                    food: food, //* food di assign food[i]
                                    itemWidth: listItemWidth //* itemWidth di assign listItemWidth yang didefinisikan terlebih dahulu
                                  ),
                                )
                            ).toList(), // todo: Mapping data toList()
                        );
                      } else {
                        return Center(child: loadingIndicator,); // todo: jika masih tahap load/masih di FoodInitial maka menampilkan loadingIndicator 
                      }
                    }
                  ),
                ]
              )
            ),
            // todo: Gap CustomTabBar dengan bagian Bawah agar tidak tertutup CustomBottomNavBar
            SizedBox(height: 80)
          ]
        ),
      ],
    );

    // todo: --------------------------------- END OF : SCREEN CONTENT -------------------------------------
  }
}