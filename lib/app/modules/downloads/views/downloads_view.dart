
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:x_book_shelf/app/data/OrderModel.dart';

import '../controllers/downloads_controller.dart';

class DownloadsView extends GetView<DownloadsController> {
  const DownloadsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.download),
        title: Text(
          "Booked Services",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Obx(
          () =>
              controller.downloadedBooks.isEmpty
                  ? const Center(child: Text("No books downloaded"))
                  : ListView.builder(
                    itemCount: controller.downloadedBooks.length,
                    itemBuilder: (context, index) {
                      final bookData = controller.downloadedBooks[index];


                      return buildbookListItem(bookData, index);
                    },
                  ),
        ),
      ),
    );
  }

  Widget buildbookListItem(OrderModel book, int index) {
    return InkWell(
      onTap: () {
      
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 2.0,
              ),
            ],
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:Text(book.id)
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.serviceTitle,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        book.bookingDate.toString(),
                        style: const TextStyle(color: Colors.blue),
                      ),
                      const SizedBox(height: 4),
                     Text(
                        book.status,
                        style: const TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
