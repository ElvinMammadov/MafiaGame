part of game;

abstract class GameEvent extends Equatable {
  const GameEvent();
}

class UpdateGameDetails extends GameEvent {
  final String gameName;
  final String typeOfGame;
  final String typeOfController;
  final int numberOfGamers;
  final String gameId;

  const UpdateGameDetails({
    required this.gameName,
    required this.typeOfGame,
    required this.typeOfController,
    required this.numberOfGamers,
    required this.gameId,
  });

  @override
  List<Object?> get props => <Object?>[
        gameName,
        typeOfGame,
        typeOfController,
        numberOfGamers,
        gameId,
      ];
}

class ChangeGameStartValue extends GameEvent {
  final bool isGameCouldStart;

  const ChangeGameStartValue({
    required this.isGameCouldStart,
  });

  @override
  List<Object?> get props => <Object?>[isGameCouldStart];
}

class SendGameToFirebase extends GameEvent {
  final String gameName;
  final int numberOfGamers;
  final String gameId;
  final List<Gamer> gamers;
  final DateTime gameStartTime;

  const SendGameToFirebase({
    required this.gameName,
    required this.numberOfGamers,
    required this.gameId,
    required this.gamers,
    required this.gameStartTime,
  });

  @override
  List<Object?> get props => <Object?>[
        gameName,
        numberOfGamers,
        gameId,
        gamers,
        gameStartTime,
      ];
}

class AddDayNumber extends GameEvent {
  const AddDayNumber();

  @override
  List<Object?> get props => <Object?>[];
}

class AddNightNumber extends GameEvent {
  const AddNightNumber();

  @override
  List<Object?> get props => <Object?>[];
}

class EndDiscussion extends GameEvent {
  final bool isDiscussionStarted;

  const EndDiscussion({
    required this.isDiscussionStarted,
  });

  @override
  List<Object?> get props => <Object?>[isDiscussionStarted];
}

class EndVoting extends GameEvent {
  final bool isVotingStarted;

  const EndVoting({
    required this.isVotingStarted,
  });

  @override
  List<Object?> get props => <Object?>[isVotingStarted];
}

class ChangeDiscussionTime extends GameEvent {
  final int discussionTime;

  const ChangeDiscussionTime({
    required this.discussionTime,
  });

  @override
  List<Object?> get props => <Object?>[discussionTime];
}

class ChangeVotingTime extends GameEvent {
  final int votingTime;

  const ChangeVotingTime({
    required this.votingTime,
  });

  @override
  List<Object?> get props => <Object?>[votingTime];
}

class AddVoteToGamer extends GameEvent {
  final Gamer gamer;

  const AddVoteToGamer({required this.gamer});

  @override
  List<Object?> get props => <Object?>[gamer];
}

class RemoveVote extends GameEvent {
  final Gamer gamer;

  const RemoveVote({required this.gamer});

  @override
  List<Object?> get props => <Object?>[gamer];
}

class AddFaultToGamer extends GameEvent {
  final int gamerId;

  const AddFaultToGamer({required this.gamerId});

  @override
  List<Object?> get props => <Object?>[gamerId];
}

class RearrangeGamersPosition extends GameEvent {
  final int newPosition;

  const RearrangeGamersPosition({
    required this.newPosition,
  });

  @override
  List<Object?> get props => <Object?>[
        newPosition,
      ];
}

class RemoveFault extends GameEvent {
  final Gamer gamer;

  const RemoveFault({required this.gamer});

  @override
  List<Object?> get props => <Object?>[gamer];
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
