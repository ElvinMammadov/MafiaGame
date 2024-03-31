part  of game;

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class UpdateGameDetails extends GameEvent {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;

  const UpdateGameDetails({
    required this.gameName,
    required this.typeOfGame,
    required this.typeOfController,
    required this.numberOfGamers,
  });

  @override
  List<Object?> get props =>
      <Object?>[gameName, typeOfGame, typeOfController, numberOfGamers];
}

class ChangeGameStartValue extends GameEvent {
  final bool isGameStarted;


  const ChangeGameStartValue({
    required this.isGameStarted,
  });

  @override
  List<Object?> get props =>
      <Object?>[isGameStarted];
}

class AddGamer extends GameEvent {
  final Gamer gamer;

  const AddGamer({required this.gamer});


  @override
  List<Object?> get props => <Object?>[gamer];
}

class CleanGamers extends GameEvent {
  final List<Gamer> gamers;

  const CleanGamers({required this.gamers});


  @override
  List<Object?> get props => <Object?>[gamers];
}

class UpdateGamer extends GameEvent {
  final Gamer gamer;

  const UpdateGamer({required this.gamer});


  @override
  List<Object?> get props => <Object?>[gamer];
}


