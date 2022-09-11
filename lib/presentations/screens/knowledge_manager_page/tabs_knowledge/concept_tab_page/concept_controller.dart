import 'package:demo_web/domain/auth_use_case.dart';
import 'package:demo_web/presentations/base/base_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConceptTabController extends BaseController {
  final AuthUseCase authUseCase;
  ConceptTabController(this.authUseCase);
}
