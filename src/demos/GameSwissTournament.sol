// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "../SwissTournament.sol";
import "./Game.sol";

contract GameSwissTournament is SwissTournament {
    Game game;
    
    constructor(Game _game) {
        game = _game;

        // after contract deploys/initializes
        // you should call newTournament() to initialize the tournament
        // this is because newTournament() takes in calldata (for the L2 compression baby!)
        // and constructors dont accept calldata arrays :thonk:
    }

    /// @dev take note of the advancePlayers modifier
    function playMatch(ResultCounter calldata group, uint256 matchIndex) public override advancePlayers(group, matchIndex) {
        Match storage matchup = matches[group.wins][group.losses][matchIndex];
        uint256 winnerId = game.result(matchup.player0, matchup.player1);

        // Implementing playMatch() requires you to update the outcome of the match
        matchup.winnerId = winnerId;
        matchup.played = true;
        // the advancePlayers() modifier will handle advancing the players to the next group
    }
}