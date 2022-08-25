import 'package:fox_delivery_owner/Models/PackageModels.dart';

import '../../Models/ProblemModel.dart';

bool internetConnection = true;
List<PackageModel> selectedOrders = [];
List<PackageModel> orders = [];
List<String> packagesID = [];
List<String> selectedPackagesID = [];
List<ProblemModel> problems = [];