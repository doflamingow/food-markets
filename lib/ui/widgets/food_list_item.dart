part of 'widgets.dart';

class FoodListItem extends StatelessWidget {
  final Food food;
  final double itemWidth; // width FoodListItem

  FoodListItem({@required this.food, @required this.itemWidth});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Container Food Image
        Container(
          width: 60,
          height: 60,
          margin: EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: NetworkImage(food.picturePath),
              fit: BoxFit.cover
            ),
          ),
        ),
        // Column untuk Text(nama dan harga food)
        SizedBox( // SizedBox untuk width Text(nama dan harga food) agar fix
          width: itemWidth - 60 - 12 - 110, // itemWidth(lebar FoodItemList) - (width Container Food Image) - (margin dari gambar ke Container untuk Text) - (width RatingStar)
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                food.name,
                style: blackFontStyle2,
                maxLines: 1,
                overflow: TextOverflow.clip,
              ),
              Text( // Penggunaan intl untuk currency
                NumberFormat.currency(
                  symbol: 'IDR ',
                  decimalDigits: 0,
                  locale: 'id-ID'
                ).format(food.price),
                style: greyFontStyle.copyWith(fontSize: 13),
              )
            ],
          ),
        ),
        // Rating Star
        RatingStars(food.rate),
      ],
    );
  }
}