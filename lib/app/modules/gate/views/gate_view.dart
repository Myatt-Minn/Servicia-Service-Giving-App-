import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/gate_controller.dart';

class GateView extends GetView<GateController> {
  const GateView({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
