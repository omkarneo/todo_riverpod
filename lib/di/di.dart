import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../Provider/todoprovider.dart';

final TodoProvider = ChangeNotifierProvider((ref) => TodoModel());

final DropdownProvider = ChangeNotifierProvider((ref) => DropdownModel());
