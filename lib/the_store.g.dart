// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'the_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TheStore on _TheStore, Store {
  Computed<Chair> _$chairComputed;

  @override
  Chair get chair => (_$chairComputed ??=
          Computed<Chair>(() => super.chair, name: '_TheStore.chair'))
      .value;

  final _$plankTypeAtom = Atom(name: '_TheStore.plankType');

  @override
  PlankType get plankType {
    _$plankTypeAtom.reportRead();
    return super.plankType;
  }

  @override
  set plankType(PlankType value) {
    _$plankTypeAtom.reportWrite(value, super.plankType, () {
      super.plankType = value;
    });
  }

  final _$nailTypeAtom = Atom(name: '_TheStore.nailType');

  @override
  NailType get nailType {
    _$nailTypeAtom.reportRead();
    return super.nailType;
  }

  @override
  set nailType(NailType value) {
    _$nailTypeAtom.reportWrite(value, super.nailType, () {
      super.nailType = value;
    });
  }

  final _$_TheStoreActionController = ActionController(name: '_TheStore');

  @override
  dynamic setPlankType(PlankType type) {
    final _$actionInfo =
        _$_TheStoreActionController.startAction(name: '_TheStore.setPlankType');
    try {
      return super.setPlankType(type);
    } finally {
      _$_TheStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNailType(NailType type) {
    final _$actionInfo =
        _$_TheStoreActionController.startAction(name: '_TheStore.setNailType');
    try {
      return super.setNailType(type);
    } finally {
      _$_TheStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic resetToDefaults() {
    final _$actionInfo = _$_TheStoreActionController.startAction(
        name: '_TheStore.resetToDefaults');
    try {
      return super.resetToDefaults();
    } finally {
      _$_TheStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
plankType: ${plankType},
nailType: ${nailType},
chair: ${chair}
    ''';
  }
}
