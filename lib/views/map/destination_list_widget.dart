import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:partner/common/styles.dart';
import 'package:partner/controllers/map_controller.dart';

import '../../models/map_model.dart';
import '../../service/uidata.dart';
import 'delivery_receipt_screen.dart';

class DestinationListWidget extends StatelessWidget {
  final List<DestinationModel> destinations;
  const DestinationListWidget({super.key, required this.destinations});

  @override
  Widget build(BuildContext context) {
    final MapsController destinationController = Get.put(MapsController());
    destinationController.loadDestinations(destinations);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          const Text(
            "Theo dõi điểm đến",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: destinationController.destinations.length,
                itemBuilder: (context, index) {
                  final destination = destinationController.destinations[index];
                  final chamColor = destination.isSigned.value
                      ? const Color(0xFF007AFF)
                      : const Color(0xFF656565);
                  final ghiBienBanColor = destination.isSigned.value
                      ? const Color(0xFF656565)
                      : const Color(0xFF925BFE);

                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.circle, size: 10, color: chamColor),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(destination.companyName,
                                      style: AppTextStyles.titleMediumGery(
                                          context)),
                                  const SizedBox(height: 4),
                                  Text("+BD: ${destination.bd}",
                                      style:
                                          AppTextStyles.bodyTextSmall(context)),
                                  Text("+CC: ${destination.cc}",
                                      style:
                                          AppTextStyles.bodyTextSmall(context)),
                                  Text("+GOM: ${destination.gom}",
                                      style:
                                          AppTextStyles.bodyTextSmall(context)),
                                  const SizedBox(height: 4),
                                  Text(destination.note,
                                      style:
                                          AppTextStyles.bodyTextSmall(context)),
                                  Row(
                                    children: [
                                      Text(
                                        destination.contactName,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.blue),
                                        child: IconButton(
                                          icon: const Icon(Icons.phone,
                                              color: Colors.white),
                                          onPressed: () {
                                            // destinationController
                                            //     .callPhoneNumber(
                                            //         destination.contactPhone);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                  Obx(
                                    () => InkWell(
                                      onTap: destination.isSigned.value
                                          ? null
                                          : () async {
                                              final result = await Get.to(
                                                  () => DeliveryReceiptScreen(
                                                        deliveryReceipt:
                                                            deliveryReceiptList,
                                                      ));

                                              if (result == "done") {
                                                destinationController
                                                    .markAsSigned(index);
                                              }
                                            },
                                      child: Row(
                                        children: [
                                          Icon(Icons.edit_note,
                                              color: ghiBienBanColor, size: 18),
                                          const SizedBox(width: 4),
                                          Text(
                                            "Ghi biên bản",
                                            style: TextStyle(
                                              color: ghiBienBanColor,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
