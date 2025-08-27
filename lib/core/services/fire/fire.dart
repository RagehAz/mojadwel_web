library super_fire;

import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;

import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as f_a;
import 'package:cloud_firestore/cloud_firestore.dart' as cloud;
import 'package:firebase_database/firebase_database.dart' as f_db;
import 'package:firebase_storage/firebase_storage.dart' as f_s;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis_auth/auth_browser.dart';
import 'package:http/http.dart'as http;
// --------------------
/// OFFICIAL
part 'a_foundation/a_official_firebase_initializer.dart';
part 'a_foundation/b_official_authing.dart';
part 'a_foundation/c_official_fire.dart';
part 'a_foundation/d_official_real.dart';
part 'a_foundation/d_real_http.dart';
part 'a_foundation/e_official_storage.dart';

part 'c_helpers/helper_methods.dart';
part 'b_models/auth_model.dart';
part 'b_models/official_fire_modelling.dart';
part 'b_models/fire_query_model.dart';
