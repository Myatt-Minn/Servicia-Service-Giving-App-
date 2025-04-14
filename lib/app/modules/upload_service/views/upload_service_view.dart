import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

import '../controllers/upload_service_controller.dart';

class UploadServiceView extends GetView<UploadServiceController> {
  const UploadServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Service'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _label('Service Title'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                hintText: 'Enter service title',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Description'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                hintText: 'Enter service description',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 20),

            _label('Category'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.categoryController,
              decoration: const InputDecoration(
                hintText: 'Enter category (e.g., Car Repair)',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Price'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter price',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Pricing Type'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.pricingTypeController,
              decoration: const InputDecoration(
                hintText: 'fixed or hourly',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Location'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.locationController,
              decoration: const InputDecoration(
                hintText: 'Enter city or full address',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Phone Number'),
            const SizedBox(height: 10),
            TextField(
              controller: controller.phoneNumberController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                hintText: 'Enter phone number',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
            const SizedBox(height: 20),

            _label('Service Image'),
            const SizedBox(height: 4),
            Obx(() {
              return Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        controller.isImagePicked.value
                            ? FileImage(File(controller.imagePath.value))
                            : const AssetImage('assets/noImg.jpg')
                                as ImageProvider,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => controller.pickImage(),
                      child: CircleAvatar(
                        backgroundColor: ConstsConfig.primarycolor,
                        radius: 20,
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
            const SizedBox(height: 30),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ConstsConfig.primarycolor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () => controller.uploadService(),
                  child:
                      controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : const Text('Upload Service'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Text(
      text.tr,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }
}
