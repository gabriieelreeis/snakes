import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:snakes/controllers/controller.dart';

class Tabuleiro extends StatefulWidget {
  @override
  _TabuleiroState createState() => _TabuleiroState();
}

class _TabuleiroState extends State<Tabuleiro> {
  final controller = GetIt.I.get<CobrasEscadas>();

  List<GlobalKey> list;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  Size size;
  double width = 700;
  double height = 700;

  @override
  void initState() {
    super.initState();
    list = List<GlobalKey>.generate(100, (_) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Observer(
        builder: (_) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.all(0),
                        height: height,
                        width: width,
                        child: Stack(
                          children: [
                            GridView.builder(
                              itemCount: 100,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 10,
                                mainAxisSpacing: 0,
                                crossAxisSpacing: 0,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return new Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0.0),
                                  ),
                                  margin: EdgeInsets.all(0),
                                  key: list[index],
                                  color: (10 <= index && index <= 19) ||
                                          (30 <= index && index <= 39) ||
                                          (50 <= index && index <= 59) ||
                                          (70 <= index && index <= 79) ||
                                          (90 <= index && index <= 99)
                                      ? index.isOdd
                                          ? Color.fromRGBO(255, 204, 182, 1)
                                          : Color.fromRGBO(154, 214, 215, 1)
                                      : index.isEven
                                          ? Color.fromRGBO(255, 158, 65, 1)
                                          : Color.fromRGBO(189, 145, 218, 1),
                                  child: Stack(
                                    children: [
                                      (100 - index) == controller.playerAmove
                                          ? Align(
                                              alignment: index == 99
                                                  ? Alignment.topLeft
                                                  : Alignment.center,
                                              child: AnimatedOpacity(
                                                opacity: controller.pinAVisible
                                                    ? 1.0
                                                    : 0.4,
                                                duration: const Duration(
                                                  milliseconds: 500,
                                                ),
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: new BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.rectangle,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      (100 - index) == controller.playerBmove
                                          ? Align(
                                              alignment: index == 99
                                                  ? Alignment.bottomRight
                                                  : Alignment.center,
                                              child: AnimatedOpacity(
                                                opacity: controller.pinBVisible
                                                    ? 1.0
                                                    : 0.4,
                                                duration: const Duration(
                                                  milliseconds: 500,
                                                ),
                                                child: Container(
                                                  width: 50.0,
                                                  height: 50.0,
                                                  decoration: new BoxDecoration(
                                                    color: Colors.black,
                                                    shape: BoxShape.circle,
                                                  ),
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            ((99 - index) + 1).toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 10,
                        width: (width - 10),
                        height: (height - 10),
                        child: Image.asset(
                          'assets/snaker-ladders.png',
                          width: width,
                          height: height,
                        ),
                      ),

                      // Condição para exibir mensagem caso não haja ninguem jogando e haja um vencedor no momento
                      if (!controller.playing && controller.winner)
                        Positioned(
                          top: 0,
                          left: 0,
                          width: width,
                          height: height,
                          child: Container(
                            width: width,
                            height: height,
                            color: Color.fromRGBO(0, 0, 0, .8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "GANHADOR!",
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Parabéns Jogador  ' +
                                          (controller.playerAplaying
                                              ? '1'
                                              : '2') +
                                          ', você é o grande ganhador, que tal tentar novamente?',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.restart(),
                                      child: Container(
                                        child: new Text(
                                          "REINICIAR",
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF000000),
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Roboto"),
                                        ),
                                        color: const Color(0xFFffffff),
                                        padding: const EdgeInsets.all(0.0),
                                        alignment: Alignment.center,
                                        width: 130.0,
                                        height: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Condição para exibir mensagem caso ambos os dados do Jogador X sejam iguais
                      if (controller.equalDice &&
                          !controller.playing &&
                          !controller.winner)
                        Positioned(
                          top: 0,
                          left: 0,
                          width: width,
                          height: height,
                          child: Container(
                            width: width,
                            height: height,
                            color: Color.fromRGBO(0, 0, 0, .8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Dados Iguais",
                                      style: TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Você tirou dados iguais Jogador ' +
                                          (controller.playerAplaying
                                              ? '1'
                                              : '2') +
                                          ', você pode jogar novamente!',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    GestureDetector(
                                      onTap: () => controller.roll(),
                                      child: Container(
                                        child: new Text(
                                          "JOGAR",
                                          style: new TextStyle(
                                              fontSize: 12.0,
                                              color: const Color(0xFF000000),
                                              fontWeight: FontWeight.w200,
                                              fontFamily: "Roboto"),
                                        ),
                                        color: const Color(0xFFffffff),
                                        padding: const EdgeInsets.all(0.0),
                                        alignment: Alignment.center,
                                        width: 130.0,
                                        height: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Condição para exibir dados caso o botão JOGAR tenha sido clicado
                      if (!controller.overlay &&
                          controller.playing &&
                          !controller.winner)
                        Positioned(
                          top: 0,
                          left: 0,
                          width: width,
                          height: height,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/dado-' +
                                    (controller.playerAplaying
                                        ? controller.playerAleft.toString()
                                        : controller.playerBleft.toString()) +
                                    '-1.png',
                                width: 100,
                                height: 100,
                              ),
                              Image.asset(
                                'assets/dado-' +
                                    (controller.playerAplaying
                                        ? controller.playerAright.toString()
                                        : controller.playerBright.toString()) +
                                    '-1.png',
                                width: 100,
                                height: 100,
                              ),
                            ],
                          ),
                        ),
                      // Condição para exibir mensagem informado a vez do jogador atual
                      if (controller.overlay &&
                          !controller.equalDice &&
                          !controller.winner)
                        Positioned(
                          top: 0,
                          left: 0,
                          width: width,
                          height: height,
                          child: Container(
                            width: width,
                            height: height,
                            color: Color.fromRGBO(0, 0, 0, .8),
                            child: Observer(builder: (_) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Vez do Jogador " +
                                        (controller.playerAplaying ? "1" : "2"),
                                    style: TextStyle(
                                      fontSize: 32,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.roll(),
                                    child: Container(
                                      child: new Text(
                                        "JOGAR",
                                        style: new TextStyle(
                                            fontSize: 12.0,
                                            color: const Color(0xFF000000),
                                            fontWeight: FontWeight.w200,
                                            fontFamily: "Roboto"),
                                      ),
                                      color: const Color(0xFFffffff),
                                      padding: const EdgeInsets.all(0.0),
                                      alignment: Alignment.center,
                                      width: 130.0,
                                      height: 40.0,
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Row(
                          children: [
                            Container(
                              child: new Text(
                                "Jogador 1",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto"),
                              ),
                              color: Colors.red,
                              padding: const EdgeInsets.all(5),
                            ),
                            Container(
                              child: new Text(
                                "Jogador 2",
                                style: new TextStyle(
                                    fontSize: 12.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w200,
                                    fontFamily: "Roboto"),
                              ),
                              color: Colors.black,
                              padding: const EdgeInsets.all(5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
