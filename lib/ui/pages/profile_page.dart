part of 'pages.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    // todo: ------------------------------ SCREEN CONTENT -----------------------------------

    return ListView(
      children: [

        // todo: Column untuk keseluruhan widget Isi Content
        Column(
          children: [

            // todo ------------------HEADER USER (picturePath, name, email) ----------------------------
            
            // todo: Container USER (picturePath, name, email)
            Container(
                padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                height: 220, //* height untuk (picturePath, name, email) 220 = 110 untuk User.picturePath, sisanya untuk name and email
                margin: EdgeInsets.only(bottom: defaultMargin),
                width: double.infinity, //* width Header Container sesuai layar
                color: Colors.white, //* Background Color Container white
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, //* Column (MainAxisAlignment/Vertical) <=> center
                  children: [

                    // todo: Container untuk Container User.picturePath
                    Container(
                      width: 110, //* width untuk (picturePath) = 110
                      height: 110, //* width untuk (picturePath) = 110
                      margin: EdgeInsets.only(bottom: 16),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration( //* Container decoration => BoxDecoration bisa punya background Image dengan DecorationImage
                          image: DecorationImage(
                              image: AssetImage('lib/assets/photo_border.png')
                        )
                      ),

                      // todo: Container -> BoxDecoration -> DecorationImage, Image berisi NetworkImage yang diisi User.picturePath
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, //* shape Container yaitu Circle
                            image: DecorationImage(
                                image: NetworkImage(
                                    // todo: Memanggil secara langsung User.picturePath melalui bloc apabila UserState sudah berada di UserLoaded
                                    //* note: tidak perlu di cek UserState berada dimana karena sudah diload di Sign In / Address Page
                                    (context.bloc<UserCubit>().state as UserLoaded).user.picturePath
                                ),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),

                    // todo: Text User.name
                    Text(
                      // todo: Memanggil secara langsung User.name melalui bloc apabila UserState sudah berada di UserLoaded
                      //* note: tidak perlu di cek UserState berada dimana karena sudah diload di Sign In / Address Page
                      (context.bloc<UserCubit>().state as UserLoaded).user.name,
                      style: GoogleFonts.poppins(
                          fontSize: 18, fontWeight: FontWeight.w500),
                    ),

                    // todo: Text User.email
                    Text(
                      (context.bloc<UserCubit>().state as UserLoaded).user.email,
                      style:
                          greyFontStyle.copyWith(fontWeight: FontWeight.w300),
                    )
                  ],
                )),
            
            // todo ------------------------------------------------ BODY ----------------------------------------------------

            // todo: Container untuk CustomTabBar & Profile Component
            Container(
              width: double.infinity, //* width Container sesuai layar
              color: Colors.white, //* Background Color Container white

              // todo: Column (CustomTabBar) & mapping Profile Component
              child: Column(
                children: [

                  // todo: CustomTabBar
                  CustomTabBar(
                    titles: ["Account", "FoodMarket"], //* Inisialisasi titles type []
                    // todo: props selectedIndex di CustomTabBar di isi set selectedIndex yang telah mendapatkan nilai index dari onTap(index)
                    // todo: menentukan title active dan content body active di Builder
                    selectedIndex: selectedIndex,
                    onTap: (index) { //todo: untuk mendapatkan index dari props onTap terklik di CustomTabBar kemudian di set ke selectedIndex
                      //todo: untuk menentukan title active dan content body active di Builder
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                  ),

                  // todo: Gap CustomTabBar sama Profile Component
                  SizedBox(
                    height: 16,
                  ),

                  // todo: Column Profile Component
                  Column(
                    children: ((selectedIndex == 0) //todo: mapping Titles Profile Component sesuai selectedIndex
                            ? [ 
                                'Edit Profile',
                                'Home Address', // todo: Titles => Profile Component selectedIndex 0
                                'Security',
                                'Payment'
                              ]
                            : [
                                'Rate App',
                                'Help Center', // todo: Titles => Profile Component selectedIndex 0
                                'Privacy & Policy',
                                'Term & Condition'
                              ])
                        .map((e) => Padding(
                              padding: EdgeInsets.only( //todo: Profile Component dibungkus Padding biar berjarak antar Component
                                  bottom: 16,
                                  left: defaultMargin,
                                  right: defaultMargin),

                              // todo: Profile Component
                              // todo: Row Untuk Text & Image(right_arrow.png)
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween, //* Row (MainAxisAlignment/Horizontal) <=> spaceBetween
                                children: [

                                  // todo: Text(Titles[i])
                                  Text(
                                    e,
                                    style: blackFontStyle3,
                                  ),

                                  // todo: SizedBox untuk Image(right_arrow.png)
                                  SizedBox(
                                    height: 24, //* height dan width untuk Image(right_arrow.png) 24x24
                                    width: 24,

                                    // todo: Image(right_arrow.png)
                                    child: Image.asset(
                                      'lib/assets/right_arrow.png',
                                      fit: BoxFit.contain,
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 80,
            )
          ],
        ),
      ],
    );

    // todo: --------------------------------- END OF : SCREEN CONTENT -------------------------------------
  }
}
