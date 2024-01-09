import 'package:isar/isar.dart';

part 'absent_attendee.g.dart';

@Collection()
class AbsentAttendee {
  Id id = Isar.autoIncrement;
  late String projectId;
  late String individualId;
  late String tenantId;
  late String registerId;
  late int entryTime;
  late int exitTime;
  late int eventStartDate;
  late int eventEndDate;
  late int status;
  late String name;
  late int currentDate;
  late String userName;
}
