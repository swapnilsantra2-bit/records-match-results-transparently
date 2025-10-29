# 🏆 MatchRecords – Transparent Match Results on the Blockchain

![Uploading image.png…]()



## 📘 Project Description

**MatchRecords** is a beginner-friendly blockchain project built in Solidity that allows recording and viewing of match results in a transparent and tamper-proof way.  
It demonstrates how to use **smart contracts** to store structured data (like sports match scores) on-chain, ensuring that no result can be altered once published.

This project is ideal for learning the basics of Solidity development, data storage, and event logging.

---

## ⚙️ What It Does

- The **contract owner** can record the results of a match (e.g., Team A vs Team B).
- Each match result includes:
  - Team names  
  - Scores  
  - Timestamp of when it was recorded
- **Anyone** can view match results at any time.
- **Events** are emitted for each new match, allowing front-end apps to listen for updates in real time.

---

## ✨ Features

- 🧾 **Immutable Match Records:** Once recorded, results cannot be modified or deleted.  
- 🔒 **Owner-Only Access Control:** Only the contract owner can record match results.  
- 🌍 **Public Transparency:** Anyone can view match results on-chain.  
- ⏰ **Timestamps:** Each record automatically stores the exact time it was created.  
- 🔊 **Event Logging:** Emits `MatchRecorded` events for front-end or analytics integration.  
- 👥 **Ownership Transfer:** Ownership can be transferred to another account if needed.

---

## 🔗 Deployed Smart Contract

You can deploy and test the contract directly in **Remix IDE** using the link below:

👉 [Open in Remix](https://remix.ethereum.org/#lang=en&optimize=false&runs=200&evmVersion=null&version=soljson-v0.8.30+commit.73712a01.js)

Once deployed:
1. Compile the contract with **Solidity v0.8.30**  
2. Deploy using **Remix VM (local)** or your preferred network (e.g., Sepolia testnet)  
3. Interact with the functions:  
   - `recordMatch("Team A", "Team B", 2, 1)`  
   - `getMatch(0)` to view stored results  

---

## 🧱 Smart Contract Overview

```solidity
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract MatchRecords {
    address public owner;

    struct MatchResult {
        uint256 id;
        string teamA;
        string teamB;
        uint8 scoreA;
        uint8 scoreB;
        uint256 timestamp;
    }

    MatchResult[] public matches;

    event MatchRecorded(
        uint256 indexed id,
        string teamA,
        string teamB,
        uint8 scoreA,
        uint8 scoreB,
        uint256 timestamp
    );

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

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

    function getMatchCount() public view returns (uint256) {
        return matches.length;
    }

    function getMatch(uint256 _id)
        public
        view
        returns (string memory, string memory, uint8, uint8, uint256)
    {
        require(_id < matches.length, "Invalid match ID");
        MatchResult memory m = matches[_id];
        return (m.teamA, m.teamB, m.scoreA, m.scoreB, m.timestamp);
    }

    function transferOwnership(address _newOwner) public onlyOwner {
        owner = _newOwner;
    }
}
