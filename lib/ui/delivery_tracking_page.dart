import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'store_map_page.dart';

/// DeliveryTrackingPage reuses StoreMapPage UI
class DeliveryTrackingPage extends StoreMapPage {
  const DeliveryTrackingPage({
    super.key,
    String storeName = 'Ombe Coffee Shop',
    String address = 'Franklin Avenue 2263',
    String note = 'Sent at 08:23 AM',
    LatLng center = const LatLng(28.6139, 77.2090),
    double zoom = 13.0,
  }) : super(
          storeName: storeName,
          address: address,
          note: note,
          center: center,
          zoom: zoom,
        );

  static const String routeName = '/delivery-tracking';
}


