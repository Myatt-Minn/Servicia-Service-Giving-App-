import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/ServiceModel.dart';
import 'package:x_book_shelf/app/data/consts_config.dart';

import '../controllers/book_details_controller.dart';

class BookDetailsView extends GetView<BookDetailsController> {
  const BookDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Retrieve the passed book data (ensure book.id exists for Hero animations)
    ServiceModel book = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,

        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          book.title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Book Header Section with elevated card & Hero animation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue.shade800, Colors.blue.shade600],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Hero(
                        tag: book.id, // Make sure book.id is unique
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: FancyShimmerImage(
                            imageUrl: book.imageUrl,
                            width: 120,
                            height: 170,
                            boxFit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.description,
                              style: const TextStyle(
                                fontSize: 16,

                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),

                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.price_change,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Pricing Type - ${book.pricingType} ',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                Icon(
                                  Icons.location_city,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  book.location,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money_outlined,
                                  color: Colors.white,
                                  size: 18,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  "${book.price}MMK",
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Author & Actions Section
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        book.provider.profileImageUrl.isEmpty
                            ? 'https://static.vecteezy.com/system/resources/thumbnails/054/078/108/small_2x/cartoon-character-of-a-construction-worker-vector.jpg'
                            : book.provider.profileImageUrl,
                      ),
                    ),
                    title: Text(
                      book.provider.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    trailing: GestureDetector(
                      onTap: () {
                        Get.toNamed(
                          '/author-profile',
                          arguments: book.provider.uid,
                        );
                      },
                      child: Text(
                        "Check Profile >",
                        style: TextStyle(color: ConstsConfig.primarycolor),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            if (controller.role.value == 'provider') {
                              Get.snackbar(
                                "Sorry",
                                "You can't book a service with the provider account!",
                                backgroundColor: Colors.yellow,
                              );
                              return;
                            }
                            Get.dialog(
                              AlertDialog(
                                title: const Text('Enter Address'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: controller.addressController,
                                      decoration: InputDecoration(
                                        hintText:
                                            "12th, Fifth Floor, Kyouk Myaung, Tamwe, Yangon",
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    ElevatedButton(
                                      onPressed:
                                          () => controller.selectServiceDate(
                                            context,
                                          ),
                                      child: const Text(
                                        'Select Serviceing Date',
                                      ),
                                    ),
                                    Obx(
                                      () => Text(
                                        controller.serviceingDate.value
                                            .toLocal()
                                            .toString()
                                            .split(' ')[0],
                                      ),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: const Text('Cancel'),
                                  ),
                                  const SizedBox(width: 10),
                                  ElevatedButton(
                                    onPressed: () async {
                                      if (controller
                                          .addressController
                                          .text
                                          .isNotEmpty) {
                                        await controller.addOrder();
                                      } else {
                                        return;
                                      }
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ],
                              ),
                              // Dialog won't close on outside tap
                            );
                          },
                          icon: const Icon(
                            Icons.contact_phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Book This Service",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue.shade700,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () {
                            controller.shareservice(book);
                          },
                          icon: const Icon(Icons.share, size: 20),
                          label: Text("Share This Service"),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.blue.shade700,
                            side: BorderSide(color: Colors.blue.shade700),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            textStyle: const TextStyle(fontSize: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Recommended Books Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Related Services",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Obx(
              () => SizedBox(
                height: 214,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: controller.recommendedservices.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 16),
                  itemBuilder: (context, index) {
                    var recommended = controller.recommendedservices[index];
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          () => const BookDetailsView(),
                          arguments: recommended,
                        );
                      },

                      child: Container(
                        width: 130,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                              child: FancyShimmerImage(
                                imageUrl: recommended.imageUrl,
                                height: 160,
                                width: 130,
                                boxFit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Text(
                                recommended.title,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue.shade800,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
