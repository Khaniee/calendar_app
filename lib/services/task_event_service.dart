import 'package:my_project/models/event.dart';
import 'package:my_project/models/task.dart';

class TaskAndEventService {
  static List<dynamic> orderByHour(List<Task> tasks, List<Event> todayEvents) {
    var mergedList = [...tasks, ...todayEvents];
    mergedList.sort((a, b) {
      if (a is Task && b is Task) {
        if (a.hour.hour != b.hour.hour) {
          return a.hour.hour - b.hour.hour;
        } else {
          return a.hour.minute - b.hour.minute;
        }
      } else if (a is Task && b is Event) {
        if (a.hour.hour != b.dateDebut.hour) {
          return a.hour.hour - b.dateDebut.hour;
        } else {
          return a.hour.minute - b.dateDebut.minute;
        }
      } else if (a is Event && b is Event) {
        if (a.dateDebut.hour != b.dateDebut.hour) {
          return a.dateDebut.hour - b.dateDebut.hour;
        } else {
          return a.dateDebut.minute - b.dateDebut.minute;
        }
      }
      // Add a return statement for the case when a and b are equal
      return 0;
    });

    return mergedList;
  }

  static List<List<dynamic>> divideListByTime(List<dynamic> mergedList) {
    List<dynamic> morningList = [];
    List<dynamic> eveningList = [];

    for (var item in mergedList) {
      if (item is Task) {
        final hour = item.hour.hour;
        if (hour >= 0 && hour < 12) {
          morningList.add(item);
        } else {
          eveningList.add(item);
        }
      } else if (item is Event) {
        final hour = item.dateDebut.hour;
        if (hour >= 0 && hour < 12) {
          morningList.add(item);
        } else {
          eveningList.add(item);
        }
      }
    }

    return [morningList, eveningList];
  }

  static List<List<dynamic>> mergeAndDivideListByTime(
      List<Task> tasks, List<Event> todayEvents) {
    var mergedList = TaskAndEventService.orderByHour(tasks, todayEvents);
    return TaskAndEventService.divideListByTime(mergedList);
  }

  static int allCount(List<Task> tasks, List<Event> events) {
    return tasks.length + events.length;
  }
}
