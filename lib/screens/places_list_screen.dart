import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meus lugares'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (ctx, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: Center(
                  child: Text('Nenhum local cadastrado!'),
                ),
                builder: (ctx, greatePlaces, ch) => greatePlaces.itemsCount == 0
                    ? ch!
                    : ListView.builder(
                        itemCount: greatePlaces.itemsCount,
                        itemBuilder: (ctx, index) => ListTile(
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                greatePlaces.itemByIndex(index).image),
                          ),
                          title: Text(greatePlaces.itemByIndex(index).title),
                          subtitle: Text(
                            greatePlaces.itemByIndex(index).location!.adress,
                          ),
                          onTap: () => Navigator.of(context).pushNamed(
                            AppRoutes.PLACE_DETAIL,
                            arguments: greatePlaces.itemByIndex(index),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
