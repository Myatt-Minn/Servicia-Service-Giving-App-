import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';
import 'package:x_book_shelf/app/modules/provider_profile/controllers/instructor_profile_controller.dart';

class AuthorProfileView extends GetView<AuthorProfileController> {
  const AuthorProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () =>
            controller.isLoading.value
                ? Center(child: CircularProgressIndicator())
                : CustomScrollView(
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
                        background: Image.asset(
                          'assets/service.jpg',
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage(
                                    controller
                                            .instructor
                                            .value!
                                            .profileImageUrl
                                            .isEmpty
                                        ? 'https://static.vecteezy.com/system/resources/thumbnails/054/078/108/small_2x/cartoon-character-of-a-construction-worker-vector.jpg'
                                        : controller
                                            .instructor
                                            .value!
                                            .profileImageUrl,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          controller.instructor.value!.name,
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
                                        Text(
                                          controller.instructor.value!.rating
                                              .toString(),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              controller.instructor.value!.bio,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black54,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Divider(),
                            Text(
                              "My Services",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Obx(
                              () =>
                                  controller.services.isEmpty
                                      ? Padding(
                                        padding: const EdgeInsets.only(
                                          top: 60.0,
                                        ),
                                        child: Center(
                                          child: Text(
                                            "No Services Yet",
                                            style: TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                      )
                                      : ListView.builder(
                                        padding: const EdgeInsets.all(4.0),
                                        itemCount: controller.services.length,
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(), // Disable scrolling if inside another scrollable view
                                        itemBuilder: (context, index) {
                                          return _buildserviceCard(
                                            controller.services[index],
                                          );
                                        },
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }

  Widget _buildserviceCard(ServiceModel service) {
    return GestureDetector(
      onTap: () {
        Get.toNamed('/service-details', arguments: service);
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              service.provider.uid ==
                      Supabase.instance.client.auth.currentSession!.user.id
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          controller.deleteServiceById(service.id);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    ],
                  )
                  : SizedBox(),
              Stack(
                children: [
                  FancyShimmerImage(
                    imageUrl: service.imageUrl,
                    height: 200,
                    boxFit: BoxFit.fill,
                  ),
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child: Obx(() {
                  //     return IconButton(
                  //       icon: Icon(
                  //         controller.savedStatusMap[service.id]?.value == true
                  //             ? Icons.servicemark
                  //             : Icons.servicemark_border,
                  //         color: Constsconfig.secondarycolor,
                  //         size: 28,
                  //       ),
                  //       onPressed: () => controller.toggleSaveStatus(service),
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
                          const Icon(Icons.home_repair_service, size: 16),
                          const SizedBox(width: 4),
                          Text(service.pricingType),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                service.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Text(service.provider.name),
                  const SizedBox(width: 8),
                  Chip(
                    label: Text(service.category),
                    backgroundColor: Colors.grey[200],
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(width: 4),
                      Text(service.location),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text(service.rating.toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
