import 'package:flutter/material.dart';
import 'package:mojadwel_web/core/layout/the_layout.dart';
import 'package:mojadwel_web/core/shared_components/super_text/super_text.dart';
import 'package:mojadwel_web/core/theme/colorz.dart';
import 'package:mojadwel_web/core/theme/fonts.dart';
import 'package:mojadwel_web/core/utilities/contextual.dart';

class DashBoardScreen extends StatefulWidget {
  // --------------------------------------------------------------------------
  const DashBoardScreen({
    required this.encryptedData,
    super.key,
  });
  // --------------------
  final String? encryptedData;
  // --------------------
  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
  // --------------------------------------------------------------------------
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  // --------------------------------------------------------------------------
  @override
  void initState() {

    super.initState();
  }
  // --------------------
  bool _isInit = true;
  @override
  void didChangeDependencies() {
    if (_isInit && mounted) {
      _isInit = false; // good

      // asyncInSync(() async {
      //
      // });

    }
    super.didChangeDependencies();
  }
  // --------------------
  @override
  void dispose() {

    super.dispose();
  }
  // --------------------------------------------------------------------------

  /// BOTTOM SHEET

  // --------------------
  /// TESTED : WORKS PERFECT
  Future<void> showTheBottomSheet({required List<Widget> tiles}) async {
    await showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (context) {
        return DecoratedBox(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: tiles,
            ),
          ),
        );
      },
    );
  }
  // --------------------------------------------------------------------------

  /// PICk QUALITY

  // --------------------
  /// TESTED : WORKS PERFECT
  // Future<void> _pickQuality() async {
  //   await showTheBottomSheet(
  //     tiles: <Widget>[
  //       // ...List.generate(_videoSources.length, (int index) {
  //       //   final VideoSourceModel _source = _videoSources[index];
  //       //
  //       //   return _qualityTile(
  //       //     source: _source,
  //       //     onTap: () async {
  //       //       blog('wiping');
  //       //
  //       //       if (mounted) {
  //       //         setState(() {
  //       //           _canBuildVideo = false;
  //       //           _selectedVideoSource = null;
  //       //         });
  //       //       }
  //       //
  //       //       await Routing.goBack(context: context);
  //       //
  //       //       if (mounted) {
  //       //         setState(() {
  //       //           _canBuildVideo = true;
  //       //           _selectedVideoSource = _source;
  //       //         });
  //       //       }
  //       //
  //       //       await _startPlayer();
  //       //
  //       //       blog('starting');
  //       //     },
  //       //   );
  //       // }),
  //     ],
  //   );
  // }
  // --------------------
  /// TESTED : WORKS PERFECT
  // Widget _qualityTile({
  //   required void Function() onTap,
  //   // required VideoSourceModel source,
  // }) {
  //   return RadioListTile(
  //     controlAffinity: ListTileControlAffinity.trailing,
  //     title: Text(
  //       source.quality,
  //       style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  //     ),
  //     subtitle: Text(
  //       '${source.size.totalMegaBytes.toStringAsFixed(2)} MB',
  //       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
  //     ),
  //     value: source,
  //     groupValue: 1,
  //     onChanged: (value) {
  //       onTap();
  //     },
  //   );
  // }
  // --------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    // --------------------
    return TheLayout(
      backgroundColor: Colorz.black255,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

              SuperText(
                boxWidth: context.screenWidth,
                text: 'The dashboard',
                textHeight: 30,
                margins: 10,
                font: InfinityFont.regular,
              ),

          ],
        ),
      ),
    );
    // --------------------
  }
  // --------------------------------------------------------------------------
}
