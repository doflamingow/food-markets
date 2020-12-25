part of 'pages.dart';

class MainPage extends StatefulWidget {
  final int initialPage; // Untuk navigation ke MainPage() dengan Custom Inisial Page yang ingin dituju 
  // ( 0 => food_page.dart, 1 => order_history_page.dart atau 2 => profile_page.dart)

  MainPage({this.initialPage = 0});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selectedPage = 0;
  PageController pageController = PageController(initialPage: 0);

  @override
  void initState(){
    super.initState();
    selectedPage = widget.initialPage;
    pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Stack child => Background sampai ke atas(sinyal, jam dll)
          Container(
            color: Colors.white,
          ),
          // Stack child => background dengan custom color hanya untuk screen app
          SafeArea(
            child: Container(
              color: 'FAFAFC'.toColor(),
            )
          ),
          SafeArea(
            child: PageView(
              controller: pageController,
              onPageChanged: (index){
                setState(() {
                  selectedPage = index;
                });
              },
              children: [
                Center(
                  child: FoodPage(),
                ),
                Center(
                  child: OrderHistoryPage(),
                ),
                Center(
                  child: ProfilePage(),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: CustomBottomNavBar(
              selectedIndex: selectedPage,
              onTap: (index){ // Cara menggunakan props Function dari widget dengan ANONYMOUS FUNCTION
                setState(() {
                  selectedPage = index;
                });
                pageController.jumpToPage(selectedPage);
              }, 
            ),
          ),
        ],
      ),
    );
  }
}