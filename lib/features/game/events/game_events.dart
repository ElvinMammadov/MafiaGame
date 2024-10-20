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
  const ChangeGameStartValue();

  @override
  List<Object?> get props => <Object?>[];
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

class UpdateGamerPoints extends GameEvent {
  final String gamerId;
  final String gameId;
  final Map<String, int> points;

  const UpdateGamerPoints({
    required this.gamerId,
    required this.gameId,
    required this.points,
  });

  @override
  List<Object?> get props => <Object?>[
        gamerId,
        gameId,
        points,
      ];
}

class GameStatus extends GameEvent {
  final bool isGameFinished;

  const GameStatus({
    required this.isGameFinished,
  });

  @override
  List<Object?> get props => <Object?>[
        isGameFinished,
      ];
}

class CalculatePoints extends GameEvent {
  final GameState gameState;
  final VoidCallback finished;

  const CalculatePoints({
    required this.gameState,
    required this.finished,
  });

  @override
  List<Object?> get props => <Object?>[
        gameState,
        finished,
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

class ChangeGamerCounts extends GameEvent {
  final bool isMafia;

  const ChangeGamerCounts({
    required this.isMafia,
  });

  @override
  List<Object?> get props => <Object?>[
        isMafia,
      ];
}

class NightAction extends GameEvent {
  final Function(List<Gamer> newKilledGamers) showKilledGamers;

  const NightAction({
    required this.showKilledGamers,
  });

  @override
  List<Object?> get props => <Object?>[
        showKilledGamers,
      ];
}

class VotingAction extends GameEvent {
  final Function(Gamer killedGamer) showKilledGamers;
  final Function(List<Gamer> pickedGamers)? showPickedNumber;
  final Function(Gamer killedGamer)? gamerHasAlibi;
  final VoidCallback? showFailureInfo;

  const VotingAction({
    required this.showKilledGamers,
    this.showPickedNumber,
    this.showFailureInfo,
    this.gamerHasAlibi,
  });

  @override
  List<Object?> get props => <Object?>[
        showKilledGamers,
        showPickedNumber,
        showFailureInfo,
        gamerHasAlibi,
      ];
}

class KillGamer extends GameEvent {
  final Gamer gamer;

  const KillGamer({required this.gamer});

  @override
  List<Object?> get props => <Object?>[gamer];
}

class KillInfectedGamers extends GameEvent {
  final List<Gamer> infectedGamers;

  const KillInfectedGamers({required this.infectedGamers});

  @override
  List<Object?> get props => <Object?>[infectedGamers];
}

class KillGamerByMafia extends GameEvent {
  final Gamer targetedGamer;
  final Gamer mafiaGamer;

  const KillGamerByMafia({
    required this.targetedGamer,
    required this.mafiaGamer,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        mafiaGamer,
      ];
}

class KillGamerByKiller extends GameEvent {
  final Gamer targetedGamer;
  final Gamer killer;

  const KillGamerByKiller({
    required this.targetedGamer,
    required this.killer,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        killer,
      ];
}

class ChangeWerewolf extends GameEvent {
  @override
  List<Object?> get props => <Object?>[];
}

class KillGamerBySheriff extends GameEvent {
  final Gamer targetedGamer;
  final Gamer sheriff;

  const KillGamerBySheriff({
    required this.targetedGamer,
    required this.sheriff,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        sheriff,
      ];
}

class GiveAlibi extends GameEvent {
  final Gamer targetedGamer;
  final Gamer advocate;

  const GiveAlibi({
    required this.targetedGamer,
    required this.advocate,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        advocate,
      ];
}

class CleanGamersAfterNight extends GameEvent {
  const CleanGamersAfterNight();

  @override
  List<Object?> get props => <Object?>[];
}

class CleanGamersAfterDay extends GameEvent {
  const CleanGamersAfterDay();

  @override
  List<Object?> get props => <Object?>[];
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

class ChameleonChangeRole extends GameEvent {
  final RoleType chameleonRoleType;

  const ChameleonChangeRole({
    required this.chameleonRoleType,
  });

  @override
  List<Object?> get props => <Object?>[
        chameleonRoleType,
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
  final Gamer madam;

  const TakeAbilityFromGamer({
    required this.targetedGamer,
    required this.madam,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        madam,
      ];
}

class MediumChecked extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const MediumChecked({
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
  final Gamer boomerang;

  const BoomerangGamer({
    required this.targetedGamer,
    required this.boomerang,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        boomerang,
      ];
}

class InfectGamer extends GameEvent {
  final Gamer targetedGamer;
  final bool infect;

  const InfectGamer({
    required this.targetedGamer,
    required this.infect,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        infect,
      ];
}

class InfectedCount extends GameEvent {
  final int infectedCount;

  const InfectedCount({
    required this.infectedCount,
  });

  @override
  List<Object?> get props => <Object?>[
        infectedCount,
      ];
}

class HealGamer extends GameEvent {
  final Gamer targetedGamer;
  final Gamer doctor;

  const HealGamer({
    required this.targetedGamer,
    required this.doctor,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        doctor,
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
  const EndVoting();

  @override
  List<Object?> get props => <Object?>[];
}

class CheckGamerBySheriff extends GameEvent {
  final Gamer targetedGamer;
  final int gamerId;

  const CheckGamerBySheriff({
    required this.targetedGamer,
    required this.gamerId,
  });

  @override
  List<Object?> get props => <Object?>[
        targetedGamer,
        gamerId,
      ];
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
  const CleanGamers();

  @override
  List<Object?> get props => <Object?>[];
}

class UpdateGamer extends GameEvent {
  final Gamer gamer;
  final bool isGamerExist;
  final Function(String)? showErrorMessage;
  final VoidCallback? updated;

  const UpdateGamer({
    required this.gamer,
    this.isGamerExist = false,
    this.showErrorMessage,
    this.updated,
  });

  @override
  List<Object?> get props => <Object?>[
        gamer,
        isGamerExist,
        showErrorMessage,
        updated,
      ];
}

class ChangeSaveStatus extends GameEvent {
  final FirebaseSaveStatus saveStatus;

  const ChangeSaveStatus({
    required this.saveStatus,
  });

  @override
  List<Object?> get props => <Object?>[saveStatus];
}

class ChangeAnimation extends GameEvent {
  final String gamerId;
  final bool animate;

  const ChangeAnimation({
    required this.gamerId,
    required this.animate,
  });

  @override
  List<Object?> get props => <Object?>[gamerId, animate];
}

class UpdateAnimation extends GameEvent {
  final bool animate;

  const UpdateAnimation({required this.animate});

  @override
  List<Object?> get props => <Object?>[animate];
}

class SetStarterId extends GameEvent {
  final String starterId;

  const SetStarterId({
    required this.starterId,
  });

  @override
  List<Object?> get props => <Object?>[starterId];
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

class SetVotingDirection extends GameEvent {
  final VoteDirection votingDirection;

  const SetVotingDirection({
    required this.votingDirection,
  });

  @override
  List<Object?> get props => <Object?>[votingDirection];
}
