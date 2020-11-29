import 'package:mobx/mobx.dart';

part 'the_store.g.dart';

class TheStore = _TheStore with _$TheStore;

abstract class _TheStore with Store {
  static const DEFAULT_NAIL = NailType.galvanized;
  static const DEFAULT_PLANK = PlankType.pine;
  static const DEFAULT_INVENTORY = 5;

  _TheStore() {
    setUpReactions();
  }

  void setUpReactions() {
    reaction(
      (_) => plankType,
      (newType) => plankInventory = DEFAULT_INVENTORY,
    );

    when(
      (_) => nailInventory == 0,
      () => nailInventory = DEFAULT_INVENTORY,
    );

    // when a nail or plank is added to the user purchases, adjust the inventory
    reaction(
      (_) => userPurchases.where((element) => element is NailType).length,
      (_) => nailInventory--,
    );
    reaction(
      (_) => userPurchases.where((element) => element is PlankType).length,
      (_) => plankInventory--,
    );
  }

  @observable
  var plankType = DEFAULT_PLANK;

  @observable
  var plankInventory = DEFAULT_INVENTORY;

  @observable
  var nailType = DEFAULT_NAIL;

  @observable
  var nailInventory = DEFAULT_INVENTORY;

  // userPurchases vs. computedPurchases: one is its own observable list / the other is computed depending on the value of the type stored in the Store

  @observable
  ObservableList<dynamic> userPurchases = ObservableList();

  @computed
  List<dynamic> get computedPurchases => userPurchases.map((element) => element is NailType ? nailType : element is PlankType ? plankType : chair).toList();

  @computed
  Chair get chair => Chair(plankType, nailType);

  @computed
  ObservableList<dynamic> get forSale => ObservableList.of([plankType, nailType, chair]);

  @computed
  bool get canBuyPlank => plankInventory > 0;

  @computed
  bool get canBuyNail => nailInventory > 0;


  @action
  setPlankType(PlankType type) => plankType = type;

  @action
  setNailType(NailType type) => nailType = type;

  @action
  resetToDefaults() {
    nailType = DEFAULT_NAIL;
    plankType = DEFAULT_PLANK;
  }

}

enum PlankType { cedar, pine, redwood }
enum NailType { galvanized, stainless }

class Chair {
  final PlankType plankType;
  final NailType nailType;

  Chair(this.plankType, this.nailType);

  @override
  String toString() {
    return 'A handmade chair of ${plankName(plankType)} planks and ${nailName(nailType)} nails';
  }
}



String plankName(PlankType type) {
    switch (type) {
      case PlankType.cedar:
        return 'cedar';
        break;
      case PlankType.pine:
        return 'pine';
        break;
      case PlankType.redwood:
        return 'redwood';
        break;
    }
  }

String nailName(NailType type) {
    switch (type) {
      case NailType.galvanized:
        return 'galvanized';
        break;
      case NailType.stainless:
        return 'stainless';
        break;
    }
  }