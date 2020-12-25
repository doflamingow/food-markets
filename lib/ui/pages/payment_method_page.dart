part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentUrl;

  PaymentMethodPage(this.paymentUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IllustrationPage(
        title: "Finish Your Payment", 
        subtitle: "Please selected your favorite\npayment method", 
        picturePath: 'lib/assets/Payment.png', 
        buttonTitle1: 'Payment Method', 
        buttonTap1: () async { // melaunch payment url ke mi trans
          await launch(paymentUrl);
        },
        buttonTitle2: 'Continue', 
        buttonTap2: (){
          Get.to(SuccessOrderPage());
        }
      ),
    );
  }
}