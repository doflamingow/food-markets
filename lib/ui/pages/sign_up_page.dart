part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  User user;
  File pictureFile; //* untuk menyimpan file Image untuk nanti di proses ke AddressPage()
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    // todo: ----------------------------------- HEADER -------------------------------------------

    return GeneralPage(
      title: 'Sign Up',
      subtitle: 'Register and eat',
      onBackButtonPressed: () {
        Get.back();
      },

      // todo: --------------------------------- BODY : SCREEN CONTENT -------------------------------------

      // todo: Column untuk keseluruhan widget Isi Content
      child: Column(
        children: [

          // todo: -------------------------- UPLOAD USER AVATAR -----------------------------------

          // todo: Container untuk Container Upload Avatar User (dibungkus GetureDetector biar bisa diklik)
          GestureDetector(
            onTap: () async {

              // todo: Inisialisasi PickedFile yaitu pickedFile untuk menyimpan file yang terupload
              PickedFile pickedFile;
              
              // todo: mengupload Image dari Gallery HP dengan Package ImagePicker() lalu disimpan ke pickedFile
              pickedFile = await ImagePicker().getImage(source: ImageSource.gallery);

              if (pickedFile != null){ // todo: cek PickedFile pickedFile apaka sudah terisi/ belum
                setState(() {
                  //todo: untuk pickedFile bagian [path] convert menjadi File lalu disimpan ke state 'pictureFile'
                  pictureFile = File(pickedFile.path);
                });
              }
            },

            // todo: Container untuk Container Upload Avatar User
            child: Container(
              width: 110,
              height: 110,
              margin: EdgeInsets.only(top: 26),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration( //* Container decoration => BoxDecoration bisa punya background Image dengan DecorationImage
                image: DecorationImage(image: AssetImage('lib/assets/photo_border.png'))
              ),
              //* Widget Container yaitu Container dengan Background Image
              child: (pictureFile != null) ? // todo: cek picture, jika sudah terisi maka
              (

                // todo: Container -> BoxDecoration -> DecorationImage, Image berisi FileImage yang diisi pictureFile
                Container( //* Container decoration => BoxDecoration bisa punya background Image dengan DecorationImage
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: FileImage(pictureFile), // File Image jika image berasal dari file
                      fit: BoxFit.cover
                    ),
                  ),
                )

              ) : ( // todo: jika belum terisi (membutuhkan aksi) maka 

                // todo: Container -> BoxDecoration -> DecorationImage, Image berisi AssetImage yang diisi lib/assets/photo.png
                Container( 
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('lib/assets/photo.png'),
                      fit: BoxFit.cover
                    ),
                  ),
                )

              ),
            ),
          ),

          // todo: -------------------------- INPUT FULL NAME -----------------------------------

          // todo: Container Text "Full Name" for TextField "Full Name" title
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Full Name', style: blackFontStyle2),
          ),

          // todo: Container TextField "Full Name"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( //* Untuk dekorasi dari Border Container
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width untuk Container
            ),

            // todo: TextField "Full Name"
            child: TextField( 
              controller: nameController, //* Inisialisasi controller name
              decoration: InputDecoration( //* Decoration untuk TextField
                border: InputBorder.none, //* border dari TextField dihapus
                hintStyle: greyFontStyle, //* style untuk text placeholder
                hintText: "Type your full name" //* placeholder
              ),
            ),
          ),

          // todo: -------------------------- INPUT EMAIL ADDRESS -----------------------------------

          // todo: Container Text "Email Address" for TextField "Email Address" title
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.fromLTRB(defaultMargin, 16, defaultMargin, 6),
            child: Text('Email Addres', style: blackFontStyle2),
          ),

          // todo: Container TextField "Email Address"
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.symmetric(horizontal: defaultMargin),
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration( //* Untuk dekorasi dari Border Container
              borderRadius: BorderRadius.circular(8), //* BorderRadius untuk Container
              border: Border.all(color: Colors.black, width: 2) //* Color & Width untuk Container
            ),

            // todo: TextField "Email Address"
            child: TextField( 
              controller: emailController,  //* Inisialisasi controller email
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
              border: Border.all(color: Colors.black, width: 2) //* Color & Width untuk Container
            ),

            // todo: TextField "Password"
            child: TextField(
              obscureText: true, //* untuk menyembunyikan text yang tertulis
              controller: passwordController, //* Inisialisasi controller password
              decoration: InputDecoration( //* Decoration untuk TextField
                border: InputBorder.none, //* border dari TextField dihapus
                hintStyle: greyFontStyle, //* style text placeholder
                hintText: "Type your password" //* placeholder
              ),
            ),
          ),

          // todo: -------------------------- BUTTON "CONTINUE" -----------------------------------

          // todo: Container untuk BUTTON 'CONTINUE'
          Container(
            width: double.infinity, //* width Container sesuai layar
            margin: EdgeInsets.only(top: defaultMargin),
            height: 45, //* Height Container untuk Button 45
            padding: EdgeInsets.symmetric(horizontal: defaultMargin),

            // todo: child RaisedButton()
            child: RaisedButton(

              // todo: ke AddressPage() dengan membawa User.name & User.email, password dan pictureFile
              onPressed: () {
                Get.to(AddressPage( 
                  User( //* user in AddressPage()
                    name: nameController.text,
                    email: emailController.text
                  ),
                  passwordController.text, //* password in AddressPage()
                  pictureFile //* pictureFile in AddressPage()
                ));
              },

              elevation: 5, //* Jarak dari Backgroud ke RaisedButton 
              shape: RoundedRectangleBorder( //* shape Border dari RaisedButton
                borderRadius: BorderRadius.circular(8)
              ),
              color: mainColor, //* Background Color RaisedColor

              // todo: isi child dari RaisedButton yaitu Widget Text('Continue')
              child: Text(
                'Continue',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ),
        ],
      ),
      
      // todo: --------------------------------- END OF : SCREEN CONTENT -------------------------------------
    );
  }
}