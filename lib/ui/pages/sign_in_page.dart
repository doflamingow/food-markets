part of 'pages.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {

    // todo: ----------------------------------- HEADER -------------------------------------------

    return GeneralPage(
      title: 'Sign In',
      subtitle: 'Find your best ever meal',

      // todo: --------------------------------- BODY : SCREEN CONTENT -------------------------------------

      child: Column(
        children: [

          // todo: -------------------------- INPUT EMAIL ADDRESS-----------------------------------

          // todo: Container Text "Email Address" for TextField "Email Address" title
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.fromLTRB(defaultMargin, 26, defaultMargin, 6),
            child: Text('Email Addres', style: blackFontStyle2),
          ),

          // todo: Container TextField "Email Address"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( //* Untuk dekorasi dari Border Container
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width Border untuk Container
            ),

            // todo: TextField "Email Address"
            child: TextField(  
              controller: emailController, //* Inisialisasi controller email
              decoration: InputDecoration( //* Decoration untuk TextField
                border: InputBorder.none, //* border dari TextField dihapus
                hintStyle: greyFontStyle, //* style untuk text placeholder
                hintText: "Type your email address" //* placeholder
              ),
            ),

          ),

          // todo: -------------------------- INPUT PASSWORD -----------------------------------

          // todo: Container Text "Password" for TextField "Password" title
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Password', style: blackFontStyle2),
          ),

          // todo: Container TextField "Password"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( //* Untuk dekorasi dari Border Container
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width Border untuk Container
            ),

            // todo: TextField "Password"
            child: TextField(
              obscureText: true, //* untuk menyembunyikan text yang tertulis
              controller: passwordController, //* Inisialisasi controller password
              decoration: InputDecoration( //* Decoration untuk TextField
                border: InputBorder.none, //* border dari TextField dihapus
                hintStyle: greyFontStyle, //* style untuk text placeholder
                hintText: "Type your password" //* placeholder
              ),
            ),

          ),

          // todo: -------------------------- BUTTON "SIGN IN" -----------------------------------

          // todo: Container untuk BUTTON 'SIGN IN'
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45, //* Height Container untuk Button 45
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: isLoading ? //* Jika bool isLoading true maka menampilkan loadingIndicator
            (
              loadingIndicator
            ) : (
              // todo: child RaisedButton()
              RaisedButton(
                onPressed: () async {
                  setState(() { // todo: set true isLoading untuk menampilkan loadingIndicaotr
                    isLoading = true;
                  });
                  
                  // todo: memanggil method signIn di cubit UserCubit 
                  //* tidak perlu variable return karena hanya aksi untuk mengubah UserState dari UserInitial ke UserLoaded atau UserLoadingFailed 
                  await context.bloc<UserCubit>().signIn(emailController.text, passwordController.text);

                  // todo: cek keberadaan UserState sekarang (UserLoaded/UserLoadingFailed)
                  UserState state = context.bloc<UserCubit>().state;
                  
                  // todo: cek jika state UserCubit di UserLoaded / data berhasil didapatkan maka
                  if (state is UserLoaded){

                    // todo: memanggil method getFoods di cubit FoodCubit untuk men-load data Food
                    context.bloc<FoodCubit>().getFoods(); 

                    // todo: memanggil getTransactions di TransactionCubit untuk menLoad data Transaction
                    context.bloc<TransactionCubit>().getTransactions();

                    // todo: dan Navigation ke MainPage();
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

                // todo: isi child dari RaisedButton yaitu Widget Text('Sign In')
                child: Text( //* Isi WIDGET
                  'Sign In',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w500
                  ),
                ),

              )
            )
          ),

          // todo: -------------------------- BUTTON "SIGN UP" -----------------------------------

          // todo: Container untuk BUTTON 'SIGN UP'
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45, //* Height Container untuk Button 45
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),
            child: isLoading ? //* Jika bool isLoading true maka menampilkan loadingIndicator
            (
              loadingIndicator
            ) : (
              // todo: child RaisedButton()
              RaisedButton(
                onPressed: () {
                  Get.to(SignUpPage()); // todo: dan Navigation ke SignUpPage();
                },
                elevation: 5, //* Jarak dari Backgroud ke RaisedButton 
                shape: RoundedRectangleBorder( //* shape Border dari RaisedButton
                  borderRadius: BorderRadius.circular(8)
                ),
                color: greyColor, //* Background Color RaisedColor

                // todo: isi child dari RaisedButton yaitu Widget Text('Create New Account')
                child: Text(
                  'Create New Account',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.w500
                  ),
                ),
              )
            )
          )
        ],
      ),

      // todo: --------------------------------- END OF : SCREEN CONTENT -------------------------------------
      
    );
  }
}