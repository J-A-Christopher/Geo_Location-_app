import 'package:flutter/material.dart';
import '../screens/add_place_screen.dart';
import 'package:provider/provider.dart';
import '../providers/great_places.dart';
import '../screens/place_detail_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddPlaceScreen.routename);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: FutureBuilder(
          future: Provider.of<GreatPlaces>(context, listen: false)
              .fetchAndSetPlaces(),
          builder: (context, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? const Center(child: CircularProgressIndicator())
              : Consumer<GreatPlaces>(
                  child: const Center(
                      child: Text('Got no places yet start adding some!')),
                  builder: (context, greatPlaces, ch) =>
                      greatPlaces.items.isEmpty
                          ? ch!
                          : ListView.builder(
                              itemBuilder: (context, index) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[index].image),
                                ),
                                title: Text(greatPlaces.items[index].title),
                                subtitle: Text(
                                    '${greatPlaces.items[index].location!.address}'),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routName,
                                      arguments: greatPlaces.items[index].id);
                                },
                              ),
                              itemCount: greatPlaces.items.length,
                            )),
        ));
  }
}
