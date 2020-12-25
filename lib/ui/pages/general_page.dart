part of 'pages.dart'; // bagian dari

// General Page => Template page untku membuat page yang general(yang mirip2)

class GeneralPage extends StatelessWidget {
  //props
  final String title;
  final String subtitle;
  final Function onBackButtonPressed;
  final Widget child;
  final Color backColor;

  GeneralPage(
    {
      this.title = "Title", 
      this.subtitle = "subtitle", 
      this.onBackButtonPressed, 
      this.child, 
      this.backColor
    }
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack( // Stack jika wrap paling atas maka width.infinity dan height.infinity
        children: [
          // Stack child => background sampai ke atas(sinyal, jam dll)
          Container(
            color: Colors.white,
          ),
          // Stack child => background dengan custom color hanya untuk screen app
          SafeArea(
            child: Container(
              color: backColor ?? Colors.white,
            ), 
          ),
          // Stack child => Header(buttom back arrow (jika ada), title, subtitle), pembatas berwarna grey dan child untuk content page (jika ada)
          SafeArea(
            child: ListView(
              children: [
                Column(
                  children: [
                    // Header 
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: defaultMargin), // padding horizontal
                      color: Colors.white,
                      width: double.infinity,
                      height: 100,
                      child: Row(
                        children: [
                          // Backbutton jika ada
                          onBackButtonPressed != null ? (
                            GestureDetector(
                              onTap: onBackButtonPressed,
                              child: (
                                Container(
                                  width: defaultMargin,
                                  height: defaultMargin,
                                  margin: EdgeInsets.only(right: 26),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage('lib/assets/back_arrow.png')
                                    )
                                  ),
                                )
                              ),
                            )
                          ) : (
                            SizedBox()
                          ),
                          // Column Title dan Subtitle
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // title
                              Text(
                                title,
                                style: GoogleFonts.poppins(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              // subtitle
                              Text(
                                subtitle,
                                style: GoogleFonts.poppins(
                                  color: greyColor,
                                  fontWeight: FontWeight.w300
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Pembatas gray
                    Container(
                      height: defaultMargin,
                      width: double.infinity,
                      color: "FAFAFC".toColor()
                    ),
                    // child untuk content di page tersebut jika null maka dikasih SizedBox
                    child ?? SizedBox()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}