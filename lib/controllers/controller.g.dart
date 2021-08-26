// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$CobrasEscadas on _CobrasEscadasBase, Store {
  Computed<bool> _$equalDiceComputed;

  @override
  bool get equalDice =>
      (_$equalDiceComputed ??= Computed<bool>(() => super.equalDice,
              name: '_CobrasEscadasBase.equalDice'))
          .value;
  Computed<int> _$playerAtotalComputed;

  @override
  int get playerAtotal =>
      (_$playerAtotalComputed ??= Computed<int>(() => super.playerAtotal,
              name: '_CobrasEscadasBase.playerAtotal'))
          .value;
  Computed<int> _$playerBtotalComputed;

  @override
  int get playerBtotal =>
      (_$playerBtotalComputed ??= Computed<int>(() => super.playerBtotal,
              name: '_CobrasEscadasBase.playerBtotal'))
          .value;

  final _$overlayAtom = Atom(name: '_CobrasEscadasBase.overlay');

  @override
  bool get overlay {
    _$overlayAtom.reportRead();
    return super.overlay;
  }

  @override
  set overlay(bool value) {
    _$overlayAtom.reportWrite(value, super.overlay, () {
      super.overlay = value;
    });
  }

  final _$winnerAtom = Atom(name: '_CobrasEscadasBase.winner');

  @override
  bool get winner {
    _$winnerAtom.reportRead();
    return super.winner;
  }

  @override
  set winner(bool value) {
    _$winnerAtom.reportWrite(value, super.winner, () {
      super.winner = value;
    });
  }

  final _$playingAtom = Atom(name: '_CobrasEscadasBase.playing');

  @override
  bool get playing {
    _$playingAtom.reportRead();
    return super.playing;
  }

  @override
  set playing(bool value) {
    _$playingAtom.reportWrite(value, super.playing, () {
      super.playing = value;
    });
  }

  final _$playerAleftAtom = Atom(name: '_CobrasEscadasBase.playerAleft');

  @override
  int get playerAleft {
    _$playerAleftAtom.reportRead();
    return super.playerAleft;
  }

  @override
  set playerAleft(int value) {
    _$playerAleftAtom.reportWrite(value, super.playerAleft, () {
      super.playerAleft = value;
    });
  }

  final _$playerArightAtom = Atom(name: '_CobrasEscadasBase.playerAright');

  @override
  int get playerAright {
    _$playerArightAtom.reportRead();
    return super.playerAright;
  }

  @override
  set playerAright(int value) {
    _$playerArightAtom.reportWrite(value, super.playerAright, () {
      super.playerAright = value;
    });
  }

  final _$playerBleftAtom = Atom(name: '_CobrasEscadasBase.playerBleft');

  @override
  int get playerBleft {
    _$playerBleftAtom.reportRead();
    return super.playerBleft;
  }

  @override
  set playerBleft(int value) {
    _$playerBleftAtom.reportWrite(value, super.playerBleft, () {
      super.playerBleft = value;
    });
  }

  final _$playerBrightAtom = Atom(name: '_CobrasEscadasBase.playerBright');

  @override
  int get playerBright {
    _$playerBrightAtom.reportRead();
    return super.playerBright;
  }

  @override
  set playerBright(int value) {
    _$playerBrightAtom.reportWrite(value, super.playerBright, () {
      super.playerBright = value;
    });
  }

  final _$playerAmoveAtom = Atom(name: '_CobrasEscadasBase.playerAmove');

  @override
  int get playerAmove {
    _$playerAmoveAtom.reportRead();
    return super.playerAmove;
  }

  @override
  set playerAmove(int value) {
    _$playerAmoveAtom.reportWrite(value, super.playerAmove, () {
      super.playerAmove = value;
    });
  }

  final _$playerBmoveAtom = Atom(name: '_CobrasEscadasBase.playerBmove');

  @override
  int get playerBmove {
    _$playerBmoveAtom.reportRead();
    return super.playerBmove;
  }

  @override
  set playerBmove(int value) {
    _$playerBmoveAtom.reportWrite(value, super.playerBmove, () {
      super.playerBmove = value;
    });
  }

  final _$playerAplayingAtom = Atom(name: '_CobrasEscadasBase.playerAplaying');

  @override
  bool get playerAplaying {
    _$playerAplayingAtom.reportRead();
    return super.playerAplaying;
  }

  @override
  set playerAplaying(bool value) {
    _$playerAplayingAtom.reportWrite(value, super.playerAplaying, () {
      super.playerAplaying = value;
    });
  }

  final _$rollAsyncAction = AsyncAction('_CobrasEscadasBase.roll');

  @override
  Future roll() {
    return _$rollAsyncAction.run(() => super.roll());
  }

  final _$playAsyncAction = AsyncAction('_CobrasEscadasBase.play');

  @override
  Future play(int qtd) {
    return _$playAsyncAction.run(() => super.play(qtd));
  }

  final _$movePlayerAsyncAction = AsyncAction('_CobrasEscadasBase.movePlayer');

  @override
  Future movePlayer(int init, int finalVal) {
    return _$movePlayerAsyncAction.run(() => super.movePlayer(init, finalVal));
  }

  final _$restartAsyncAction = AsyncAction('_CobrasEscadasBase.restart');

  @override
  Future restart() {
    return _$restartAsyncAction.run(() => super.restart());
  }

  @override
  String toString() {
    return '''
overlay: ${overlay},
winner: ${winner},
playing: ${playing},
playerAleft: ${playerAleft},
playerAright: ${playerAright},
playerBleft: ${playerBleft},
playerBright: ${playerBright},
playerAmove: ${playerAmove},
playerBmove: ${playerBmove},
playerAplaying: ${playerAplaying},
equalDice: ${equalDice},
playerAtotal: ${playerAtotal},
playerBtotal: ${playerBtotal}
    ''';
  }
}
