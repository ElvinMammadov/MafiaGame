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

class AddGamer extends GameEvent {
  final Gamer gamer;

  const AddGamer({required this.gamer});


  @override
  List<Object?> get props => <Object?>[gamer];
}

class UpdateGamer extends GameEvent {
  final Gamer gamer;

  const UpdateGamer({required this.gamer});


  @override
  List<Object?> get props => <Object?>[gamer];
}


