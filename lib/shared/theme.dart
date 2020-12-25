part of 'shared.dart';

Color mainColor = "FFC700".toColor(); // penggunaan color harus menambah supercharged: ^1.10.0 dan import 'package:supercharged/supercharged.dart';
Color greyColor = "8D92A3".toColor();

Widget loadingIndicator = SpinKitFadingCircle(size: 45, color: mainColor);

TextStyle greyFontStyle = GoogleFonts.poppins().copyWith(color: greyColor);
TextStyle blackFontStyle1 = GoogleFonts.poppins().copyWith(
  color: Colors.black, 
  fontSize: 22, 
  fontWeight: FontWeight.w500
);
TextStyle blackFontStyle2 = GoogleFonts.poppins().copyWith(
  color: Colors.black, 
  fontSize: 16, 
  fontWeight: FontWeight.w500
);
TextStyle blackFontStyle3 = GoogleFonts.poppins().copyWith(
  color: Colors.black
);

const double defaultMargin = 24;