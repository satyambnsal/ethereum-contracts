// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract BallotV2 {
    address public chairperson;

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

    constructor(bytes32[] memory proposalNames) {
        chairperson = msg.sender;
        voters[chairperson].weight = 1;

        for (uint256 i = 0; i < proposalNames.length; i++) {
            proposals.push(Proposal({name: proposalNames[i], voteCount: 0}));
        }
    }

    function assignRightToVote(address to) public {
        require(
            msg.sender == chairperson,
            "Only chairperson can assign right to vote"
        );
        require(!voters[to].voted, "Voter already voted");
        require(voters[to].weight == 0, "Voter already has right to vote");
        voters[to].weight = 1;
    }

    function delegateVote(address to) public {
        Voter storage sender = voters[to];
        require(!sender.voted, "Voter already voted");
        require(sender.weight != 0, "Voter has no right to vote");
        require(msg.sender != to, "self-delegation is not allowed");

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
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "Voter already voted");
        require(sender.weight != 0, "Voter has no right to vote");

        sender.voted = true;
        sender.vote = proposal;
        proposals[proposal].voteCount += sender.weight;
    }

    function winningProposal() public view returns (uint256 _winningProposal) {
        uint256 maxVoteCount = 0;
        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > maxVoteCount) {
                maxVoteCount = proposals[i].voteCount;
                _winningProposal = i;
            }
        }
    }

    function winningProposalName()
        public
        view
        returns (bytes32 _winningProposalName)
    {
        uint256 winningProposalIndex = winningProposal();
        _winningProposalName = proposals[winningProposalIndex].name;
    }
}
