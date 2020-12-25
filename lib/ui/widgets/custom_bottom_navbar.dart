part of 'widgets.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int index) onTap;

  CustomBottomNavBar({
    this.selectedIndex = 0,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(0);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage((selectedIndex == 0) ? 'lib/assets/ic_home.png' : 'lib/assets/ic_home_normal.png' )
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(1);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              margin: EdgeInsets.symmetric(horizontal: 83),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage((selectedIndex == 1) ? 'lib/assets/ic_order.png' : 'lib/assets/ic_order_normal.png' )
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: (){
              if(onTap != null){
                onTap(2);
              }
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage((selectedIndex == 2) ? 'lib/assets/ic_profile.png' : 'lib/assets/ic_profile_normal.png' )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}