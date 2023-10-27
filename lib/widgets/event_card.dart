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
  });
  final Event event;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 15),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
              color: AppColor.divider, offset: Offset(0, 2), blurRadius: 3)
        ],
        color: AppColor.white,
        borderRadius: BorderRadius.circular(10),
      ),
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
                  "${DateFormat('HH:mm').format(event.date_debut)} - ${DateFormat('HH:mm').format(event.date_fin)}"),
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
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText(
                    "N'oubliez pas",
                    fontSize: AppFontSize.small,
                    isBold: true,
                  ),
                  AppText(
                    event.choses_apporter,
                    fontSize: AppFontSize.small,
                  ),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Icon(
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
                                      child: Text("Annuler")),
                                  TextButton(
                                      onPressed: () {
                                        if (event.id != null) {
                                          EventService.deleteEvent(event.id!);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              elevation: 0,
                                              backgroundColor: Colors.green,
                                              content: AppText(
                                                "Evenement supprimé !",
                                                color: AppColor.white,
                                              ),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: AppText(
                                                "Erreur lors du supression!",
                                                color: AppColor.white,
                                              ),
                                            ),
                                          );
                                        }
                                        Navigator.pop(context);
                                      },
                                      child: Text("Supprimer")),
                                ],
                              ));

                      // _selectedEvents.value = _getEventsForDay(_selectedDay);
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
    );
  }
}
