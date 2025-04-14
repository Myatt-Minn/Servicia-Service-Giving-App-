import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';

import '../controllers/author_controller.dart';

class AuthorView extends GetView<AuthorController> {
  const AuthorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: Text(
          'Providers',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildSearchBar(),
            const SizedBox(height: 15),
            Expanded(child: _buildauthorGrid()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      onChanged: (value) {
        controller.searchProducts(value);
      },
      decoration: InputDecoration(
        filled: true,
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        hintText: 'search'.tr,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildauthorGrid() {
    return Obx(
      () =>
          controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // Adjust for desired columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8, // Adjust for icon and text proportion
                ),
                itemCount: controller.filterauthors.length,
                itemBuilder: (context, index) {
                  final author = controller.filterauthors[index];
                  return _buildauthorIcon(author.profileImageUrl, author);
                },
              ),
    );
  }

  Widget _buildauthorIcon(String imagePath, ProviderModel author) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/author-profile', arguments: author);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(radius: 35, backgroundImage: NetworkImage(imagePath)),
          const SizedBox(height: 5),
          Text(
            author.name,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }
}
