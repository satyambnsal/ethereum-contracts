//SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.4;

contract Ballot {
    struct Voter {
        uint256 weight;
        bool voted;
        address delegate;
        uint256 vote;
    }

    struct Proposal {
        bytes32 name;
        uint256 voteCount;
    }

    mapping(address => Voter) public voters;
    Proposal[] public proposals;

    address public chairperson;

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 p = 0; p < proposalNames.length; p++) {
            proposals.push(Proposal({name: proposalNames[p], voteCount: 0}));
        }
    }

    function giveRightToVote(address to) public {
        require(
            msg.sender == chairperson,
            "Only chairperson can give right to vote"
        );
        require(voters[to].weight == 0, "Voter already have right to vote");
        voters[to].weight = 1;
    }

    function delegateVote(address to) public {
        Voter storage sender = voters[msg.sender];

        require(!sender.voted, "Voter already voted!");
        require(to != msg.sender, "Self delegation is not allowed");

        while (voters[to].delegate != address(0)) {
            to = voters[to].delegate;
            require(to != msg.sender, "Found loop in delegation");
        }

        sender.voted = true;
        sender.delegate = to;

        Voter storage _delegate = voters[to];

        if (_delegate.voted) {
            proposals[_delegate.vote].voteCount += sender.weight;
        } else {
            _delegate.weight += sender.weight;
        }
    }

    function vote(uint256 proposal) public {
        Voter storage voter = voters[msg.sender];
        require(voter.weight != 0, "Voter has no right to vote!");
        require(!voter.voted, "Voter already voted");

        voter.voted = true;
        voter.vote = proposal;
        proposals[proposal].voteCount += voter.weight;
    }

    function winnerProposal() public view returns (uint256 _winnerProposal) {
        uint256 winnerCount = 0;

        for (uint256 p = 0; p < proposals.length; p++) {
            if (proposals[p].voteCount > winnerCount) {
                winnerCount = proposals[p].voteCount;
                _winnerProposal = p;
            }
        }
    }

    function winnerName() public view returns (bytes32 _winnerName) {
        _winnerName = proposals[winnerProposal()].name;
    }
}
