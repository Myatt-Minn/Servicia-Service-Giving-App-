import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/orders_controller.dart';

class OrdersView extends GetView<OrdersController> {
  const OrdersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings'), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.orders.isEmpty) {
          return const Center(child: Text('No bookings found.'));
        }

        return Obx(
          () =>
              controller.isCanceling.value
                  ? Center(child: CircularProgressIndicator())
                  : Column(
                    children: [
                      // Notice Box
                      Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(Icons.info, color: Colors.blue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                "You cannot cancel the booking on the servicing date.",
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: controller.orders.length,
                          itemBuilder: (context, index) {
                            final order = controller.orders[index];
                            return Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _orderStatus(order.status),

                                        order.status == 'cancelled'
                                            ? SizedBox()
                                            : ElevatedButton(
                                              onPressed: () {
                                                final today = DateTime.now();
                                                final servicingDate =
                                                    order.serviceingDate;

                                                // Check if the servicing date is today (same day)
                                                if (servicingDate.year ==
                                                        today.year &&
                                                    servicingDate.month ==
                                                        today.month &&
                                                    servicingDate.day ==
                                                        today.day) {
                                                  Get.snackbar(
                                                    "Cannot Cancel",
                                                    "You cannot cancel the booking on the servicing date.",
                                                    backgroundColor: Colors.red,
                                                    colorText: Colors.white,
                                                  );
                                                } else {
                                                  controller.deleteOrder(
                                                    order.id!,
                                                  );
                                                }
                                              },
                                              child: const Text(
                                                "Cancel Booking",
                                              ),
                                            ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      order.serviceTitle,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Serviceing Date: ${order.serviceingDate.toLocal()}",
                                    ),
                                    const SizedBox(height: 8),
                                    Text("Address: ${order.address}"),

                                    const SizedBox(height: 8),
                                    Text(
                                      "Total: ${order.totalPrice} MMK",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Booked on: ${order.createdAt.toLocal()}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    order.status == 'confirmed' ||
                                            order.status == 'cancelled'
                                        ? SizedBox()
                                        : controller.role.value == 'provider'
                                        ? Align(
                                          alignment: Alignment.center,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.confirmOrder(
                                                order.id!,
                                              );
                                            },

                                            child: Text("Confirm Booking"),
                                          ),
                                        )
                                        : SizedBox(),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
        );
      }),
    );
  }

  Widget _orderStatus(String status) {
    Color color;
    switch (status) {
      case 'pending':
        color = Colors.orange;
        break;
      case 'accepted':
        color = Colors.blue;
        break;
      case 'in_progress':
        color = Colors.deepPurple;
        break;
      case 'completed':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }
}
