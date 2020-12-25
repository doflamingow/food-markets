import 'dart:convert';
import 'dart:io';

import 'package:flutter_foodmarket/models/models.dart';
import 'package:http/http.dart' as http;

part 'user_services.dart';
part 'food_services.dart';
part 'transaction_services.dart';

// https://documenter.getpostman.com/view/7325/TVKBXJ24

String baseUrl = 'http://foodmarket-backend.buildwithangga.id/api/';