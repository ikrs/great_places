import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place_screen.dart';
import '../providers/great_places.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Places'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
          ),
        ],
      ),
      body: FutureBuilder(
        // load places, notify will then trigger Consumer so we dont need to listen here
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.waiting
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Consumer<GreatPlaces>(
                    child: Center(child: Text('Got no places yet!')),
                    // if no images it will display child Center widget
                    builder: (context, greatPlaces, child) =>
                        greatPlaces.items.length <= 0
                            ? child
                            : ListView.builder(
                                itemCount: greatPlaces.items.length,
                                itemBuilder: (context, index) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundImage: FileImage(
                                        greatPlaces.items[index].image,
                                      ),
                                    ),
                                    title: Text(greatPlaces.items[index].title),
                                    onTap: () {
                                      // TODO : Go to detail page ..
                                    })),
                  ),
      ),
    );
  }
}
