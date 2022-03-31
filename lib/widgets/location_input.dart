import 'package:flutter/material.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  Future<void> _getCurrentUserLocation() async {
    final locData = await Location().getLocation();
    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: locData.latitude,
      longitude: locData.longitude,
    );
    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _selectOnMap() async {
    final selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MapScreen(),
        fullscreenDialog: true,
      ),
    );

    if (selectedLocation == null) return;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          child: _previewImageUrl == null
              ? Text('Localização não informada!')
              : Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: _getCurrentUserLocation,
              icon: Icon(Icons.location_on),
              label: Text(
                'Localização Atual',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            TextButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map),
              label: Text(
                'Selecione no Mapa',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
