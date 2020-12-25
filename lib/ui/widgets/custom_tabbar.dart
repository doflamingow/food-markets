part of 'widgets.dart';

class CustomTabBar extends StatelessWidget {

  //* props CustomTabBar required for Widget Component
  final int selectedIndex;
  final Function(int index) onTap;
  final List<String> titles;

  CustomTabBar({
    this.selectedIndex = 0,
    this.onTap,
    @required this.titles
  });

  @override
  Widget build(BuildContext context) {

    // todo: --------------------------------- BODY : COMPONENT / WIDGET CONTENT -------------------------------------

    return Container(
      height: 50, //* height CustomTabBar
      child: Stack( //* STACK <=> LAYER
        children: [

          // todo: Stack Child => Container dengan garis dibawah (layer Pertama)
          Container(
            margin: EdgeInsets.only(top: 48), //* height 50 marginTop 48 berarti Container berada di bawah
            height: 1,
            color: "F2F2F2".toColor(), //* warna
          ),

          // todo: Stack Child => Row untuk Text titles [] & garis Horizontal (layer Kedua)
          Row(
            children: titles.map((title) => //todo: memapping Text titles[] & garis Horizontal 

              Padding( //todo: Column (Text titles [] & garis Horizontal) dibungkus Padding untuk jarak antar title
                padding: EdgeInsets.only(left: defaultMargin),
                child: Column( // todo: Column untuk (Text titles [] & garis Horizontal)
                  mainAxisAlignment: MainAxisAlignment.end, //* Column (MainAxisAlignment/Vertical) <=> (end) Menaruh ke paling bawah Stack
                  children: [

                    // todo: Text titles[] dibungkus GestureDetector untuk mengklik Text titles[]
                    GestureDetector( 
                      onTap: (){ //todo: Jika Text titles[] diklik maka akan mengubah onTap(index) sesuai index si titles[i]
                        if(onTap != null){
                          onTap(titles.indexOf(title));
                        }
                      },

                      // todo: Text titles[]
                      child: Text(
                        title,
                        style: (titles.indexOf(title) == selectedIndex) // todo: Style Text titles[], jika index titles[index] yang terpilih (index = selectedIndex)
                          ? (
                              blackFontStyle3.copyWith(fontWeight: FontWeight.w500) // todo: Style Text titles[] active
                            ) : (
                              greyFontStyle //! Style Text titles[] inactive
                          )
                      ),
                    ),

                    // todo: garis Horizontal sesuai OnTab(index), index titles[index] yang terpilih (index = selectedIndex)
                    Container(
                      width: 40,
                      height: 3, //* height 3 untuk garis Horizontal
                      margin: EdgeInsets.only(top: 13),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(1.5),
                        color: (titles.indexOf(title) == selectedIndex) ? ( // todo: Style(Background Color Container) garis horizontal, jika index titles[index] yang terpilih (index = selectedIndex)
                          "020202".toColor()  //todo: Background Color Container (kehitaman) active
                        ) : (
                          Colors.transparent //! Background Color Container (transparent) inactive
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ).toList(),  // todo: Mapping data toList()
          ),
        ],
      ),
    );

    // todo: --------------------------------- BODY : COMPONENT / WIDGET CONTENT -------------------------------------// todo: --------------------------------- END OF : COMPONENT / WIDGET CONTENT -------------------------------------
  }
}