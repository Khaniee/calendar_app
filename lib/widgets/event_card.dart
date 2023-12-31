import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_project/models/event.dart';
import 'package:my_project/services/event_service.dart';
import 'package:my_project/utils/color.dart';
import 'package:my_project/utils/fontsize.dart';
import 'package:my_project/widgets/event_form.dart';
import 'package:my_project/widgets/text.dart';

class EventCard extends StatelessWidget {
  const EventCard({
    super.key,
    required this.event,
    required this.onEventModify,
  });
  final Event event;
  final Function onEventModify;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 20),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColor.divider, offset: Offset(0, 2), blurRadius: 3)
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 90,
            height: 90,
            padding: EdgeInsets.all(20),
            margin: EdgeInsets.only(right: 15),
            decoration: BoxDecoration(
              color: AppColor.lightPrimary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(image: AssetImage("assets/${event.type}.png")),
          ),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    AppText(
                      event.title,
                      isBold: true,
                    ),
                    const Expanded(child: SizedBox()),
                    AppText(
                        "${DateFormat('HH:mm').format(event.dateDebut)} - ${DateFormat('HH:mm').format(event.dateFin)}"),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColor.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                          child: AppText(
                        event.type,
                        color: AppColor.primary,
                        fontSize: AppFontSize.small,
                        isBold: true,
                      )),
                    ),
                    if (event.chosesApporter != null &&
                        event.chosesApporter!.isNotEmpty) ...[
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppText(
                            "N'oubliez pas",
                            fontSize: AppFontSize.small,
                            isBold: true,
                          ),
                          AppText(
                            event.chosesApporter!,
                            fontSize: AppFontSize.small,
                          ),
                        ],
                      )
                    ]
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(
                          Icons.location_on_sharp,
                          color: AppColor.textColor,
                          size: 16,
                        ),
                        AppText(
                          event.lieu,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              context: context,
                              builder: (BuildContext context) {
                                return EventForm(
                                  event: event,
                                  callback: onEventModify,
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.edit_note,
                            color: AppColor.divider,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text("Avertissement"),
                                content: const AppText(
                                    "Vous êtes sur de supprimer cet évènement?"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Annuler")),
                                  TextButton(
                                      onPressed: () {
                                        if (event.id != null) {
                                          EventService.deleteEvent(event.id!);
                                          onEventModify();
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: const Text("Supprimer")),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete_sweep,
                            color: AppColor.divider,
                          ),
                        )
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
