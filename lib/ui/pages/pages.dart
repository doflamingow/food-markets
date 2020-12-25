import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_foodmarket/cubit/food_cubit.dart';
import 'package:flutter_foodmarket/cubit/transaction_cubit.dart';
import 'package:flutter_foodmarket/cubit/user_cubit.dart';
import 'package:flutter_foodmarket/models/models.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:supercharged/supercharged.dart';
import 'package:flutter_foodmarket/shared/shared.dart';
import 'package:flutter_foodmarket/ui/widgets/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

part 'general_page.dart'; // punya bagian
part 'sign_in_page.dart';
part 'sign_up_page.dart';
part 'address_page.dart';
part 'main_page.dart';
part 'food_page.dart';
part 'food_detail_page.dart';
part 'payment_page.dart';
part 'illustration_page.dart';
part 'success_order_page.dart';
part 'success_sign_up_page.dart';
part 'order_history_page.dart';
part 'profile_page.dart';
part 'payment_method_page.dart';