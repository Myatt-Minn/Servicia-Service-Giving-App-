import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/privacy_policy_controller.dart';

class PrivacyPolicyView extends GetView<PrivacyPolicyController> {
  const PrivacyPolicyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PrivacyPolicy'), centerTitle: true),
      body: const Center(
        child: Text(
          'There is no Privacy and Policy Yet XD',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
