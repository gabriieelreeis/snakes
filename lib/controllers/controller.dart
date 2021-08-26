import 'dart:math';

import 'package:mobx/mobx.dart';
part 'controller.g.dart';

class CobrasEscadas = _CobrasEscadasBase with _$CobrasEscadas;

abstract class _CobrasEscadasBase with Store {
  @observable
  bool overlay = true;

  @observable
  bool winner = false;

  @computed
  bool get equalDice => (playerAplaying
      ? (playerAleft == playerAright ? true : false)
      : (playerBleft == playerBright ? true : false));

  @observable
  bool playing = false;

  @observable
  int playerAleft = 1;

  @observable
  int playerAright = 2;

  @computed
  int get playerAtotal => playerAleft + playerAright;

  @observable
  int playerBleft = 1;

  @observable
  int playerBright = 2;

  @computed
  int get playerBtotal => playerBleft + playerBright;

  @observable
  int playerAmove = 0;
  @observable
  int playerBmove = 0;

  @observable
  bool playerAplaying = true;

  @action
  roll() async {
    overlay = false;
    await Future.delayed(Duration(seconds: 1));
    if (playerAplaying) {
      playerAleft = Random().nextInt(6) + 1;
      playerAright = Random().nextInt(6) + 1;
      playing = true;
      await play(playerAtotal);

      if (playerAleft != playerAright && !winner) {
        playerAplaying = false;
      }
    } else {
      playerBleft = Random().nextInt(6) + 1;
      playerBright = Random().nextInt(6) + 1;
      playing = true;
      await play(playerBtotal);

      if (playerAleft != playerAright && !winner) {
        playerAplaying = true;
      }
    }
    playing = false;

    await Future.delayed(Duration(seconds: 2));
    overlay = true;
  }

  @action
  play(int qtd) async {
    if (playerAplaying) {
      await Future.delayed(Duration(seconds: 2));
      playerAmove += qtd;
    } else {
      await Future.delayed(Duration(seconds: 2));
      playerBmove += qtd;
    }

    int position = playerAplaying ? playerAmove : playerBmove;

    if (position > 100) {
      var volta = (position - 100);
      if (playerAplaying) {
        playerAmove -= (volta * 2);
      } else {
        playerBmove -= (volta * 2);
      }

      winner = false;
    }

    if (position == 100) {
      winner = true;
    }

    // Escadas
    await movePlayer(7, 26);
    await movePlayer(30, 39);
    await movePlayer(22, 74);
    await movePlayer(48, 76);
    await movePlayer(71, 82);
    await movePlayer(68, 80);

    // Cobras
    await movePlayer(98, 55);
    await movePlayer(92, 75);
    await movePlayer(73, 51);
    await movePlayer(21, 4);
    await movePlayer(56, 19);
    await movePlayer(44, 15);
    await movePlayer(89, 49);

    if (playerAplaying) {
      if (playerAleft == playerAright) {
        playerAplaying = true;
      }
    } else {
      if (playerBleft == playerBright) {
        playerAplaying = false;
      }
    }
  }

  @action
  movePlayer(int init, int finalVal) async {
    if (((playerAplaying ? playerAmove : playerBmove)) == init) {
      await Future.delayed(Duration(seconds: 1), () {
        if (playerAplaying) {
          playerAmove = finalVal;
        } else {
          playerBmove = finalVal;
        }
      });
    }
  }

  @action
  restart() async {
    playerAleft = 1;
    playerAright = 2;
    playerBleft = 1;
    playerBright = 2;
    playerAmove = 0;
    playerBmove = 0;
    playerAplaying = true;
    winner = false;
  }
}
