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
  final List<Role> roles;

  const UpdateGameDetails({
    required this.gameName,
    required this.typeOfGame,
    required this.typeOfController,
    required this.numberOfGamers,
    required this.gameId,
    required this.roles,
  });

  @override
  List<Object?> get props => <Object?>[
        gameName,
        typeOfGame,
        typeOfController,
        numberOfGamers,
        gameId,
        roles,
      ];
}

class EmptyGame extends GameEvent {
  const EmptyGame();

  @override
  List<Object?> get props => <Object?>[];
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
 final GameState gameState;

  const SendGameToFirebase({
    required this.gameState,
  });

  @override
  List<Object?> get props => <Object?>[
    gameState,
      ];
}

class SaveGame extends GameEvent {
  final GameState gameState;

  const SaveGame({
    required this.gameState,
  });

  @override
  List<Object?> get props => <Object?>[
    gameState,
  ];
}

class GetGames extends GameEvent {
  final DateTime dateTime;

  const GetGames({
    required this.dateTime,
  });

  @override
  List<Object?> get props => <Object?>[
    dateTime,
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

class KillGamer extends GameEvent {
  final Gamer gamer;
  final VoidCallback? onCompleted;

  const KillGamer({required this.gamer, this.onCompleted});

  @override
  List<Object?> get props => <Object?>[gamer, onCompleted];
}

class KillGamerByMafia extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const KillGamerByMafia({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class KillGamerByKiller extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const KillGamerByKiller({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class KillGamerBySheriff extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const KillGamerBySheriff({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}
class GiveAlibi extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const GiveAlibi({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class CleanGamersAfterNight extends GameEvent {
  final List<Gamer> gamers;

  const CleanGamersAfterNight({required this.gamers});

  @override
  List<Object?> get props => <Object?>[gamers];
}

class AddRoleToGamer extends GameEvent {
  final Gamer targetedGamer;

  const AddRoleToGamer({
    required this.targetedGamer,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
  ];
}

class ChangeRoleIndex extends GameEvent {
  final int roleIndex;

  const ChangeRoleIndex({
    required this.roleIndex,
  });

  @override
  List<Object?> get props => <Object?>[
    roleIndex,
  ];
}

class SecureGamer extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const SecureGamer({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class TakeAbilityFromGamer extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const TakeAbilityFromGamer({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class BoomerangGamer extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const BoomerangGamer({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
}

class HealGamer extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const HealGamer({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
    targetedGamer,
    gamerId,
  ];
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
  final Gamer voter;

  const AddVoteToGamer({required this.gamer, required this.voter});

  @override
  List<Object?> get props => <Object?>[gamer, voter];
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
  final bool isGamerExist;

  const UpdateGamer({required this.gamer, this.isGamerExist = false});

  @override
  List<Object?> get props => <Object?>[gamer, isGamerExist];
}

class ChangeAnimation extends GameEvent {
  final String gamerId;

  const ChangeAnimation({
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[gamerId];
}

class UpdateAnimation extends GameEvent {

  const UpdateAnimation();

  @override
  List<Object?> get props => <Object?>[];
}

class SetVoter extends GameEvent {
  final Gamer voter;

  const SetVoter({
    required this.voter,
  });

  @override
  List<Object?> get props => <Object?>[voter];
}

class ResetVoters extends GameEvent {
  const ResetVoters();

  @override
  List<Object?> get props => <Object?>[];
}

class ResetVoter extends GameEvent {
  const ResetVoter();

  @override
  List<Object?> get props => <Object?>[];
}
