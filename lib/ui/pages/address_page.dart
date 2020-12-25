part of 'pages.dart';

class AddressPage extends StatefulWidget {
  final User user; //* props/require yang bisa diberikan ke Address oleh Page lain => S
  final String password;
  final File pictureFile;

  AddressPage(this.user, this.password, this.pictureFile);
  @override
  _AddressPageState createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  TextEditingController phoneController = TextEditingController(); //* TextEditingController() untuk Controller dan getter Text di TextField
  TextEditingController addressController = TextEditingController();
  TextEditingController houseNumController = TextEditingController();
  bool isLoading = false; //* boolean untuk menamplkan loadingIndicator atau Tidak
  List<String> cities; //* List String City yang tersedia untuk memilih User.city di DropdownButton
  String selectedCity; //* Berisi String cities dengan Index terpilih

  @override
  void initState(){ //* Seperti componentDidMount/useEffect di React (Lificycle)
    super.initState();

    cities = ["Bandung", "Jakarta", "Surabaya", "Bengkulu"]; // todo: Inisialisasi List String untuk cities yang tersedia
    selectedCity = cities[0]; // todo: Inisialisasi String selectedCity dengan cities index pertama
  }

  @override
  Widget build(BuildContext context) {

    // todo: ------------------------------ HEADER -----------------------------------

    return GeneralPage(
      title: 'Address',
      subtitle: "Make sure it's valid",
      onBackButtonPressed: () {
        Get.back();
      },

      // todo: --------------------------------- BODY : SCREEN CONTENT -------------------------------------

      // todo: Column untuk keseluruhan widget Isi Content
      child: Column(
        children: [

          // todo: -------------------------- INPUT PHONE NUMBER -----------------------------------

          // todo: Container Text "Phone Number" for TextField "Phone Number" title
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text('Phone No.', style: blackFontStyle2),
          ),

          // todo: Container TextField "PHONE NUMBER"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( //* Untuk dekorasi dari Border Container
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width Border untuk Container
            ),
            child: TextField( 
              controller: phoneController, //* Inisialisasi controller phone
              decoration: InputDecoration( //* Decoration untuk TextField
                border: InputBorder.none, //* border dari TextField dihapus
                hintStyle: greyFontStyle, //* style untuk text placeholder
                hintText: "Type your phone number" //* placeholder
              ),
            ),
          ),

          // todo: -------------------------- INPUT ADDRESS -----------------------------------
          
          // todo: Container Text "Address" for TextField "Address" title
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Address', style: blackFontStyle2),
          ),

          // todo: Container TextField "PHONE NUMBER"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField( 
              controller: addressController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your address" //placeholder
              ),
            ),
          ),

          // todo: -------------------------- INPUT HOUSE NUMBER -----------------------------------
          
          // todo: Container Text "House No." for TextField "House Number" title
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('House No.', style: blackFontStyle2),
          ),

          // todo: Container TextField "HOUSE NUMBER"
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( // untuk dekorasi dari border TextField
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.black, width: 2)
            ),
            child: TextField(
              controller: houseNumController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: greyFontStyle, // style text placeholder
                hintText: "Type your house number" //placeholder
              ),
            ),
          ),


          // todo: -------------------------- INPUT (DROP DOWN) CITY -----------------------------------

          // todo: Container Text "City." for DropDown "House Number" title
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('City.', style: blackFontStyle2),
          ),

          //todo: Container Dropdown "House Number"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(//* Untuk dekorasi dari Container Border
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width Border untuk Container
            ),

            // todo: child DropDown Button
            child: DropdownButton(
              value: selectedCity, //* inisialisasi selectedCity sebagai value yang akan diambil di DropDownButton
              isExpanded: true, //* width DropDown button mengikuti width Container
              underline: SizedBox(), //* mengganti underline dengan SizedBox()
              items: cities.map( //todo: memapping cities [] yang telah didefinikan ke DropdownMenuItem
                (city) => 
                DropdownMenuItem(
                  value: city, //todo: initialisasi value dari DropdownMenuItem yaitu String cities[index] yang sesuai dengan mapping
                  //todo: DropdownMenuItem memakai Text untuk menampilkan itemsnya
                  child: Text( 
                    city,
                    style: blackFontStyle3,
                  ),
                )
              ).toList(),

              onChanged: (item){  //* method onChanged mempunyai value DropdownMenuItem yaitu item
                setState(() {
                  selectedCity = item; //todo: set selectedCity dengan value DropdownMenuItem yaitu item yang terpilih
                });
              },
            ),
          ),


          // todo: -------------------------- BUTTON "SIGN UP NOW" -----------------------------------
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45, //* Height Container untuk Button 45
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: (isLoading == true) ? //todo: cek jika bool isLoading true maka menampilkan loadingIndicator
              (
                Center(
                  child: loadingIndicator,
                )
              ):( //todo: cek jika bool isLoading flase maka menampilkan RaisedButton

                // todo: child RaisedButton()
                RaisedButton(
                  onPressed: () async {
                    // todo: menerima data user dari sign_up_page.dart dan menambahkan dari TextField address_page.dart (phoneNumber, address, houseNumber & city)
                    User user = widget.user.copyWith(
                      phoneNumber: phoneController.text,
                      address: addressController.text,
                      houseNumber: houseNumController.text,
                      city: selectedCity
                    );

                    // todo: set true isLoading untuk menampilkan loadingIndicaotr
                    setState(() { 
                      isLoading = true;
                    });

                    //todo: memanggil method signUp di cubit UserCubit dengan parameter( user dan (password dan pictureFile) dari Sign Up Page)
                    await context.bloc<UserCubit>().signUp(user, widget.password, pictureFile: widget.pictureFile);
                    
                    //todo memanggil berada dimana UserState saat ini dan disimpan di state
                    UserState state = context.bloc<UserCubit>().state;
                      
                    //todo: cek jika state UserCubit di UserLoaded / response berhasil didapatkan maka
                    if (state is UserLoaded){

                      //todo: memanggil method getFoods di cubit FoodCubit untuk men-load data Food
                      context.bloc<FoodCubit>().getFoods();

                      //todo: memanggil method getTransactions di TransactionCubit untuk men-load data Transaction
                      context.bloc<TransactionCubit>().getTransactions();

                      //todo: Navigation ke MainPage();
                      Get.to(MainPage());

                    } else { //! jika state UserCubit di UserLoadingFailed / gagal mendapatkan data maka

                      //! Notify/Pop Up Error dari Get snackbar serta
                      Get.snackbar(
                        "", "",
                        backgroundColor: "D9435E".toColor(),
                        icon: Icon( // Icon X
                          MdiIcons.closeCircleOutline,
                          color: Colors.white
                        ),
                        titleText: Text(
                          "Sign In Failed",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight : FontWeight.w600
                          ),
                        ),
                        messageText: Text(
                          //todo: mengambil response message jika UserState berada di UserLoadingFailed(UserLoadingFailed.message)
                          (state as UserLoadingFailed).message,
                          style: GoogleFonts.poppins(color: Colors.white),
                        )
                      );

                      // todo: menghentikan loadingIndicator dengan set isLoading false
                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                  elevation: 5, //* Jarak dari Backgroud ke RaisedButton
                  shape: RoundedRectangleBorder( //* shape Border dari RaisedButton
                    borderRadius: BorderRadius.circular(8) //* value Radius dari RaisedButton
                  ),
                  color: mainColor, //* Background Color RaisedButton

                  // todo: isi child dari RaisedButton yaitu Widget Text('Sign Up Now')
                  child: Text(
                    'Sign Up Now',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                )
              )
          ),
        ],
      ),

      // todo: ------------------------------ END OF: BODY SCREEN CONTENT -----------------------------------

    );
  }
}