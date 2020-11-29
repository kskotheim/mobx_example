import 'package:eg_2/the_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider<TheStore>(
      create: (_) => TheStore(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MobXExamplePage(),
      ),
    );
  }
}

class MobXExamplePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var store = context.watch<TheStore>();

    return Scaffold(
      body: Observer(
        builder: (_) => Column(
          children: [
            // the top of this page is the 'store', below the divider is the 'user inventory'

            // a list of what is for sale at the store:
            Container(height: 30),
            Text('For Sale:'),
            Container(
              width: 300,
              child: ListView(
                shrinkWrap: true,
                children: store.forSale
                    .map(
                      (type) => ListTile(
                        title: Text(type.toString()),

                        // show inventory for planks and nails
                        trailing: Text(
                          type is PlankType
                              ? store.plankInventory.toString()
                              : type is NailType
                                  ? store.nailInventory.toString()
                                  : '',
                        ),

                        // disable button if computed values 'can buy [type of thing]' are false
                        onTap: (type is PlankType && !store.canBuyPlank)
                            ? null
                            : (type is NailType && !store.canBuyNail)
                                ? null
                                : () => store.userPurchases.add(type),
                      ),
                    )
                    .toList(),
              ),
            ),

            Container(height: 20),

            // select current types offered:
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Plank Type:'),

                    // a dropdown button to select the plank type

                    DropdownButton<PlankType>(
                      value: store.plankType,
                      items: PlankType.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: store.setPlankType,
                    ),
                  ],
                ),

                // A dropdown button to select the nail type at the store

                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Nail Type:'),
                    DropdownButton<NailType>(
                      value: store.nailType,
                      items: NailType.values
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(e.toString()),
                            ),
                          )
                          .toList(),
                      onChanged: store.setNailType,
                    ),
                  ],
                )
              ],
            ),

            Divider(),
            // A list of what the user has selected for purchase:

            Text('User Purchases: '),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView(
                  shrinkWrap: true,

                  // get userPurchases or computedPurchases
                  // userPurchases is its own observableList, computedPurchases computes a list depending on what is currently at the store
                  children: store.userPurchases
                      // children: store.computedPurchases
                      .map(
                        (element) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            element.toString(),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
