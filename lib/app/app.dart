import 'package:flutter_practice_application/screens/home/home_view.dart';
import 'package:flutter_practice_application/screens/user/user_details_views.dart';

import 'package:flutter_practice_application/services/user_db_service.dart';

import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(routes: [
  MaterialRoute(page: HomePage, initial: true),
  MaterialRoute(
    page: UserDetailsPage,
  ),
], dependencies: [
  Singleton(classType: NavigationService),
  LazySingleton(classType: UserDBService),
])
class App {}
