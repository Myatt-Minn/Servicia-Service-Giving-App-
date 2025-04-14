import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/ProviderModel.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

import '../controllers/instructor_profile_controller.dart';

class AuthorProfileView extends GetView<AuthorProfileController> {
  const AuthorProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    ProviderModel instructor = Get.arguments;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),

                child: Icon(Icons.arrow_back),
              ),
            ),
            expandedHeight: 200,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset('assets/service.jpg', fit: BoxFit.fill),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                          instructor.profileImageUrl.isEmpty
                              ? 'https://static.vecteezy.com/system/resources/thumbnails/054/078/108/small_2x/cartoon-character-of-a-construction-worker-vector.jpg'
                              : instructor.profileImageUrl,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                instructor.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 40),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.yellow),
                              Text(instructor.rating.toString()),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    instructor.bio,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 16),
                  Divider(),
                  Text(
                    "My Services",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () =>
                        controller.books.isEmpty
                            ? Padding(
                              padding: const EdgeInsets.only(top: 60.0),
                              child: Center(
                                child: Text(
                                  "No Services Yet",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            )
                            : ListView.builder(
                              padding: const EdgeInsets.all(4.0),
                              itemCount: controller.books.length,
                              shrinkWrap: true,
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable scrolling if inside another scrollable view
                              itemBuilder: (context, index) {
                                return _buildBookCard(controller.books[index]);
                              },
                            ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBookCard(ServiceModel book) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/book-details', arguments: book);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  FancyShimmerImage(
                    imageUrl: book.imageUrl,
                    height: 200,
                    boxFit: BoxFit.fill,
                  ),
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child: Obx(() {
                  //     return IconButton(
                  //       icon: Icon(
                  //         controller.savedStatusMap[book.id]?.value == true
                  //             ? Icons.bookmark
                  //             : Icons.bookmark_border,
                  //         color: Constsconfig.secondarycolor,
                  //         size: 28,
                  //       ),
                  //       onPressed: () => controller.toggleSaveStatus(book),
                  //     );
                  //   }),
                  // ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: ConstsConfig.secondarycolor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.library_books_outlined, size: 16),
                          const SizedBox(width: 4),
                          Text(book.pricingType),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                book.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(book.provider.name),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(book.category),
                    backgroundColor: Colors.grey[200],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(width: 4),
                      Text(book.location),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(book.rating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
