part of 'widgets.dart';

class FoodCard extends StatelessWidget {
  final  Food food;

  FoodCard(this.food);
  @override
  Widget build(BuildContext context) {
    // Container Card
    return Container(
      width: 200,
      height: 210,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [ // Decoration for SHADOW
          BoxShadow(
            spreadRadius: 3, 
            blurRadius: 15, 
            color: Colors.black12
          )
        ]
      ),
      // ISI CONTAINER
      child: Column(
        children: [
          //Container dengan Backgroud Image Food
          Container(
            height: 140,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              image: DecorationImage(
                image: NetworkImage(food.picturePath), 
                fit: BoxFit .cover
              )
            ),
          ),
          // Container untuk Name Food
          Container(
            margin: EdgeInsets.fromLTRB(12, 12, 12, 6),
            width: 200,
            child: Text(
              food.name,
              style: blackFontStyle2,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
          // Rating Widget
          Padding( // Padding langsung ke Reusable Widget
            padding: EdgeInsets.only(left: 12),
            child: RatingStars(food.rate),
          )
        ],
      ),
    );
  }
}