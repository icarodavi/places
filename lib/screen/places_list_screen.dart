import 'package:flutter/material.dart';
import 'package:places/providers/great_places.dart';
import 'package:places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Lugares'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM);
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false).loadPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? const Center(child: CircularProgressIndicator())
            : Consumer<GreatPlaces>(
                child: const Center(child: Text('Nenhum local cadastrado')),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.itemsCount == 0
                        ? child as Widget
                        : ListView.builder(
                            itemCount: greatPlaces.itemsCount,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage: FileImage(
                                    greatPlaces.itemByIndex(index).image),
                              ),
                              title: Text(greatPlaces.itemByIndex(index).title),
                              subtitle: Text(greatPlaces
                                  .itemByIndex(index)
                                  .location
                                  .address as String),
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                  AppRoutes.PLACE_DETAIL,
                                  arguments: greatPlaces.itemByIndex(index),
                                );
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
