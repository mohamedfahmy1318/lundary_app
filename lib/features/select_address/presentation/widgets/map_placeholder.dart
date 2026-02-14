import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Grey placeholder that stands in for a real map.
/// Replace the body with a Google Maps / Mapbox widget when the backend is ready.
class MapPlaceholder extends StatelessWidget {
  const MapPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFE0E0E0),
      child: Center(
        child: Icon(Icons.map_outlined, size: 64.sp, color: Colors.grey[400]),
      ),
    );
  }
}
