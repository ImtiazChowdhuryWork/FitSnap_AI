import 'package:provider/provider.dart';

import '../provider/navigation_provider.dart';

var providers = [
  ChangeNotifierProvider<NavigationProvider>(
      create: ((context) => NavigationProvider())),
];
