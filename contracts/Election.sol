// SPDX-License-Identifier: ISC

pragma solidity ^0.8.11;

contract Election {
    // Model a Candidate
    struct Candidate {
        uint256 id;
        string name;
        uint256 voteCount;
    }

    // Read / Write Candidate
    mapping(uint256 => Candidate) public candidates;

    // Store accounts that have votes
    mapping(address => bool) public voters;

    // Store candidate count
    uint256 public candidatesCount;

    event votedEvent(uint256 indexed _candidateId);

    // Constructor
    constructor() {
        addCandidate("Candidate 1");
        addCandidate("Candidate 2");
    }

    function addCandidate(string memory _name) private {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    function vote(uint256 _candidateId) public {
        // require that sender haven't voted before
        require(!voters[msg.sender]);

        // require valid candidate
        require(_candidateId > 0 && _candidateId <= candidatesCount);

        //record that the voter has voted
        voters[msg.sender] = true;

        // update candidate vote count
        candidates[_candidateId].voteCount++;

        // trigger voted event
        emit votedEvent(_candidateId);
    }
}
