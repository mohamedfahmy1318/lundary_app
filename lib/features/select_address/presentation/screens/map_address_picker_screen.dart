import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:laundry/core/constants/app_colors.dart';
import 'package:laundry/core/widgets/app_bar_factory.dart';

class MapAddressPickerScreen extends StatefulWidget {
  final String title;

  const MapAddressPickerScreen({super.key, this.title = 'Select Address'});

  @override
  State<MapAddressPickerScreen> createState() => _MapAddressPickerScreenState();
}

class _MapAddressPickerScreenState extends State<MapAddressPickerScreen> {
  static const String _placesApiKey = String.fromEnvironment(
    'GOOGLE_MAPS_API_KEY',
    defaultValue: 'AIzaSyAb3p2UEDZuLOPokFUTwpHEkpORrayXig0',
  );

  static const CameraPosition _defaultCamera = CameraPosition(
    target: LatLng(30.0444, 31.2357),
    zoom: 13,
  );

  GoogleMapController? _mapController;
  CameraPosition _initialCameraPosition = _defaultCamera;

  LatLng? _selectedPoint;
  String _selectedAddress = '';
  bool _isResolving = false;
  bool _isSearching = false;
  bool _isLoadingSuggestions = false;
  bool _isInitializingLocation = true;

  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  final List<_PlaceSuggestion> _suggestions = [];
  Timer? _debounce;
  String _sessionToken = DateTime.now().millisecondsSinceEpoch.toString();

  @override
  void initState() {
    super.initState();
    _initializeCurrentLocation();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    _mapController?.dispose();
    _dio.close(force: true);
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();

    final query = value.trim();
    if (query.length < 2) {
      if (mounted) {
        setState(() {
          _isLoadingSuggestions = false;
          _suggestions.clear();
        });
      }
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 350),
      () => _fetchSuggestions(query),
    );
  }

  Future<void> _fetchSuggestions(String query) async {
    if (!mounted) {
      return;
    }

    setState(() {
      _isLoadingSuggestions = true;
    });

    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': query,
          'key': _placesApiKey,
          'sessiontoken': _sessionToken,
          'language': 'en',
          'components': 'country:ae',
        },
      );

      final data = response.data;
      final status = data is Map ? data['status']?.toString() : null;
      if (status != 'OK' && status != 'ZERO_RESULTS') {
        if (!mounted) return;
        setState(() {
          _isLoadingSuggestions = false;
          _suggestions.clear();
        });
        return;
      }

      final predictions =
          data is Map && data['predictions'] is List
              ? data['predictions'] as List<dynamic>
              : <dynamic>[];

      final nextSuggestions =
          predictions
              .whereType<Map>()
              .map(
                (item) => _PlaceSuggestion(
                  description: item['description']?.toString() ?? '',
                  placeId: item['place_id']?.toString() ?? '',
                ),
              )
              .where(
                (item) =>
                    item.description.isNotEmpty && item.placeId.isNotEmpty,
              )
              .toList();

      if (!mounted || _searchController.text.trim() != query) {
        return;
      }
      setState(() {
        _isLoadingSuggestions = false;
        _suggestions
          ..clear()
          ..addAll(nextSuggestions);
      });
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _isLoadingSuggestions = false;
        _suggestions.clear();
      });
    }
  }

  Future<void> _selectSuggestion(_PlaceSuggestion suggestion) async {
    setState(() {
      _isSearching = true;
    });

    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': suggestion.placeId,
          'key': _placesApiKey,
          'sessiontoken': _sessionToken,
          'fields': 'formatted_address,geometry',
        },
      );

      final data = response.data;
      final status = data is Map ? data['status']?.toString() : null;
      if (status != 'OK') {
        _showMessage('Unable to resolve selected place.');
        return;
      }

      final result = data['result'];
      final geometry = result is Map ? result['geometry'] : null;
      final location = geometry is Map ? geometry['location'] : null;
      final lat =
          location is Map ? (location['lat'] as num?)?.toDouble() : null;
      final lng =
          location is Map ? (location['lng'] as num?)?.toDouble() : null;
      final formattedAddress =
          result is Map ? result['formatted_address']?.toString() : null;

      if (lat == null || lng == null || formattedAddress == null) {
        _showMessage('Invalid place details.');
        return;
      }

      final target = LatLng(lat, lng);
      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(target, 16),
      );

      if (!mounted) return;
      _searchController.text = formattedAddress;
      _sessionToken = DateTime.now().millisecondsSinceEpoch.toString();
      setState(() {
        _selectedPoint = target;
        _selectedAddress = formattedAddress;
        _isResolving = false;
        _suggestions.clear();
      });
    } catch (_) {
      _showMessage('Unable to select this place right now.');
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  Future<void> _initializeCurrentLocation() async {
    try {
      await _moveToCurrentLocation(selectAddress: false);
    } finally {
      if (mounted) {
        setState(() {
          _isInitializingLocation = false;
        });
      }
    }
  }

  Future<bool> _ensureLocationPermission() async {
    final isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      _showMessage('Please enable location services.');
      return false;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      _showMessage('Location permission is required to use current location.');
      return false;
    }

    return true;
  }

  Future<void> _moveToCurrentLocation({required bool selectAddress}) async {
    final hasPermission = await _ensureLocationPermission();
    if (!hasPermission) return;

    try {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final target = LatLng(position.latitude, position.longitude);
      final camera = CameraPosition(target: target, zoom: 16);

      if (!mounted) return;

      setState(() {
        _initialCameraPosition = camera;
      });

      await _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(camera),
      );

      if (selectAddress) {
        await _onMapTap(target);
      }
    } catch (_) {
      _showMessage('Unable to access current location.');
    }
  }

  Future<void> _searchAddress() async {
    final query = _searchController.text.trim();
    if (query.isEmpty) {
      _showMessage('Type an address to search.');
      return;
    }

    if (_suggestions.isNotEmpty) {
      await _selectSuggestion(_suggestions.first);
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await locationFromAddress(query);
      if (results.isEmpty) {
        _showMessage('No results found for this address.');
        return;
      }

      final location = results.first;
      final target = LatLng(location.latitude, location.longitude);

      await _mapController?.animateCamera(
        CameraUpdate.newLatLngZoom(target, 16),
      );

      await _onMapTap(target);
      if (mounted) {
        setState(() {
          _suggestions.clear();
        });
      }
    } catch (_) {
      _showMessage('Unable to search this address.');
    } finally {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    }
  }

  void _showMessage(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  Future<void> _onMapTap(LatLng latLng) async {
    setState(() {
      _selectedPoint = latLng;
      _isResolving = true;
      _suggestions.clear();
    });

    String resolvedAddress;
    try {
      final placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isEmpty) {
        resolvedAddress = _fallbackLatLng(latLng);
      } else {
        final place = placemarks.first;
        final chunks = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
        ];
        final filtered =
            chunks
                .where((part) => part != null && part.trim().isNotEmpty)
                .map((part) => part!.trim())
                .toList();

        resolvedAddress =
            filtered.isEmpty ? _fallbackLatLng(latLng) : filtered.join(', ');
      }
    } catch (_) {
      resolvedAddress = _fallbackLatLng(latLng);
    }

    if (!mounted) return;

    setState(() {
      _selectedAddress = resolvedAddress;
      _isResolving = false;
    });
  }

  String _fallbackLatLng(LatLng point) {
    return '${point.latitude.toStringAsFixed(6)}, ${point.longitude.toStringAsFixed(6)}';
  }

  void _confirmSelection() {
    if (_selectedAddress.trim().isEmpty) {
      _showMessage('Tap on the map or search to choose an address.');
      return;
    }
    Navigator.of(context).pop(_selectedAddress.trim());
  }

  @override
  Widget build(BuildContext context) {
    final markers =
        _selectedPoint == null
            ? <Marker>{}
            : {
              Marker(
                markerId: const MarkerId('selected_address'),
                position: _selectedPoint!,
              ),
            };

    return Scaffold(
      appBar: AppBarFactory.build(context, title: widget.title),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: _initialCameraPosition,
                  onMapCreated: _onMapCreated,
                  markers: markers,
                  onTap: _onMapTap,
                  mapType: MapType.normal,
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: false,
                  myLocationEnabled: true,
                ),
                Positioned(
                  top: 12,
                  left: 12,
                  right: 12,
                  child: Column(
                    children: [
                      Material(
                        elevation: 3,
                        borderRadius: BorderRadius.circular(12),
                        child: TextField(
                          controller: _searchController,
                          textInputAction: TextInputAction.search,
                          onChanged: _onSearchChanged,
                          onSubmitted: (_) => _searchAddress(),
                          decoration: InputDecoration(
                            hintText: 'Search address...',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon:
                                _isSearching
                                    ? const Padding(
                                      padding: EdgeInsets.all(12),
                                      child: SizedBox(
                                        width: 18,
                                        height: 18,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                    : IconButton(
                                      icon: const Icon(Icons.arrow_forward),
                                      onPressed: _searchAddress,
                                    ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      if (_isLoadingSuggestions || _suggestions.isNotEmpty)
                        Container(
                          margin: const EdgeInsets.only(top: 8),
                          constraints: const BoxConstraints(maxHeight: 220),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x14000000),
                                blurRadius: 8,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child:
                              _isLoadingSuggestions
                                  ? const SizedBox(
                                    height: 56,
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  )
                                  : ListView.separated(
                                    shrinkWrap: true,
                                    padding: EdgeInsets.zero,
                                    itemCount: _suggestions.length,
                                    separatorBuilder:
                                        (_, __) => const Divider(height: 1),
                                    itemBuilder: (context, index) {
                                      final suggestion = _suggestions[index];
                                      return ListTile(
                                        dense: true,
                                        leading: const Icon(Icons.location_on),
                                        title: Text(
                                          suggestion.description,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        onTap:
                                            () => _selectSuggestion(suggestion),
                                      );
                                    },
                                  ),
                        ),
                    ],
                  ),
                ),
                Positioned(
                  right: 12,
                  bottom: 18,
                  child: FloatingActionButton.small(
                    heroTag: 'current_location_fab',
                    onPressed:
                        _isInitializingLocation
                            ? null
                            : () => _moveToCurrentLocation(selectAddress: true),
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    child:
                        _isInitializingLocation
                            ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                            : const Icon(Icons.my_location),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            top: false,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x14000000),
                    blurRadius: 10,
                    offset: Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Selected Address',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isResolving
                        ? 'Resolving address...'
                        : (_selectedAddress.isEmpty
                            ? 'Tap anywhere on the map'
                            : _selectedAddress),
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _isResolving ? null : _confirmSelection,
                      icon: const Icon(Icons.check_circle_outline),
                      label: const Text('Use This Address'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceSuggestion {
  final String description;
  final String placeId;

  const _PlaceSuggestion({required this.description, required this.placeId});
}
