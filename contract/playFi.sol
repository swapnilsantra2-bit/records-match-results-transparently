// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MatchRecords {
    // The owner (admin) who can record results
    address public owner;

    // Struct to store match details
    struct MatchResult {
        uint256 id;
        string teamA;
        string teamB;
        uint8 scoreA;
        uint8 scoreB;
        uint256 timestamp;
    }

    // Array to store all match results
    MatchResult[] public matches;

    // Event to log new match results
    event MatchRecorded(
        uint256 indexed id,
        string teamA,
        string teamB,
        uint8 scoreA,
        uint8 scoreB,
        uint256 timestamp
    );

    constructor() {
        owner = msg.sender; // whoever deploys the contract is the owner
    }

    // Modifier to restrict certain actions to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    // Function to record a new match result (only owner)
    function recordMatch(
        string memory _teamA,
        string memory _teamB,
        uint8 _scoreA,
        uint8 _scoreB
    ) public onlyOwner {
        uint256 matchId = matches.length;
        matches.push(MatchResult(matchId, _teamA, _teamB, _scoreA, _scoreB, block.timestamp));

        emit MatchRecorded(matchId, _teamA, _teamB, _scoreA, _scoreB, block.timestamp);
    }

    // Get total number of matches recorded
    function getMatchCount() public view returns (uint256) {
        return matches.length;
    }

    // Retrieve a specific match by ID
    function getMatch(uint256 _id)
        public
        view
        returns (string memory, string memory, uint8, uint8, uint256)
    {
        require(_id < matches.length, "Invalid match ID");
        MatchResult memory m = matches[_id];
        return (m.teamA, m.teamB, m.scoreA, m.scoreB, m.timestamp);
    }

    // Optional: Transfer ownership if needed
    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}

