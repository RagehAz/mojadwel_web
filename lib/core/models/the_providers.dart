import 'package:flutter/material.dart';
import 'package:mojadwel_web/app/screens/b_dashboard_screen/controllers/dash_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class TheProviders extends StatelessWidget {
  // -----------------------------------------------------------------------------
  const TheProviders({
    required this.child,
    super.key
  });
  // --------------------
  final Widget child;
  // -----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<DashPro>(create: (BuildContext ctx) => DashPro()),
      ],
      child: child,
    );

  }
// -----------------------------------------------------------------------------
}
