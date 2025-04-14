import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.person),
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture and Username Section
              Center(
                child: Column(
                  children: [
                    Obx(() {
                      return CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade300,
                        backgroundImage:
                            controller.profileImg.value.isNotEmpty
                                ? NetworkImage(controller.profileImg.value)
                                : null,
                        child:
                            controller.profileImg.value.isEmpty
                                ? Image.asset(
                                  'assets/personn.png',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                )
                                : null,
                      );
                    }),
                    const SizedBox(height: 10),
                    // Username
                    Obx(
                      () => Text(
                        controller.username.value,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 30),

              // Account Setting Section
              Text(
                'Account Settings'.tr,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),
              Obx(
                () =>
                    controller.role.value == "provider"
                        ? SettingOption(
                          icon: Icons.home_repair_service,
                          label: 'Upload Service',
                          onTap: () {
                            Get.toNamed('/upload-service');
                          },
                        )
                        : SizedBox(),
              ),
              SettingOption(
                icon: Icons.person_outline,
                label: 'Edit Profile',
                onTap: () {
                  Get.toNamed('/edit-profile');
                },
              ),

              const Divider(height: 30),

              SettingOption(
                icon: Icons.privacy_tip_outlined,
                label: 'Privacy Policy',
                onTap: () {
                  Get.toNamed('/privacy-policy');
                },
              ),

              // Footer Section
              const SizedBox(height: 20),
              ListTile(
                title: Text(
                  Supabase.instance.client.auth.currentSession == null
                      ? 'Login'
                      : 'Logout',
                  style: TextStyle(color: ConstsConfig.primarycolor),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: ConstsConfig.primarycolor,
                ),
                onTap: () => controller.signOut(),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const SettingOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
