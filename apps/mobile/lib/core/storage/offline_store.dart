import 'package:hive/hive.dart';

class OfflineStore {
  OfflineStore._();

  static const motorcyclesBox = 'motorcycles';
  static const serviceRecordsBox = 'service_records';
  static const maintenanceTasksBox = 'maintenance_tasks';
  static const accessoriesBox = 'accessories';
  static const tourPlansBox = 'tour_plans';
  static const groupRidesBox = 'group_rides';
  static const diagnosticsBox = 'diagnostics';
  static const mediaBox = 'media_items';
  static const mutationQueueBox = 'mutation_queue';

  static Future<void> open() async {
    await Future.wait([
      Hive.openBox<Map>(motorcyclesBox),
      Hive.openBox<Map>(serviceRecordsBox),
      Hive.openBox<Map>(maintenanceTasksBox),
      Hive.openBox<Map>(accessoriesBox),
      Hive.openBox<Map>(tourPlansBox),
      Hive.openBox<Map>(groupRidesBox),
      Hive.openBox<Map>(diagnosticsBox),
      Hive.openBox<Map>(mediaBox),
      Hive.openBox<Map>(mutationQueueBox),
    ]);
  }
}

