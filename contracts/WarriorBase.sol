// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract WarriorBase {
    uint dnaDigits = 10;
    uint dnaModulus = 10 ** dnaDigits;

    struct Warrior {
        string name;
        address owner;
        uint warriorType;
        uint dna;
        uint xp;
        uint lastTrained;
    }

    string[] warriorClasses = ["Elephant", "Knight", "Archer","Swordsman"];

    string[] elephantStates = ["Battle Elephant", "Elite Battle Elephant", "Destroyer Elephant"];
    string[] knightStates = ["Knight", "Cavalier", "Paladin"];
    string[] archerStates =["Archer", "Crossbowman", "Arbalester"];
    string[] swordsmanStates =["Long Swordsman", "Twohanded Swordsman", " Champion"];

    Warrior[] public warriors;
    mapping (address => uint[]) public ownerToWarriorIds;

    function _createWarrior(string memory _name, uint _warriorType, uint _dna) private {
        warriors.push(Warrior(_name, msg.sender, _warriorType, _dna,0, 0));
        uint id = warriors.length - 1;
        ownerToWarriorIds[msg.sender].push(id);
        // TODO: add a CreateWarrior event and emit it.
    }

    function _generateRandomDna(string memory _name, uint _warriorType) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_warriorType ,_name)));
        return rand % dnaModulus;
    }

    function createRandomWarrior(string memory _name, uint _warriorType) public {
        require(_warriorType >= 0 && _warriorType <= 3);
        uint randDna = _generateRandomDna(_name, _warriorType);
        _createWarrior(_name, _warriorType, randDna);
    }
    
    function _separateWarriorType(uint _warriorType) private view returns (uint, uint) {
        uint stateId = _warriorType % 10;
        uint classId = (_warriorType - stateId)/10;
        return (classId, stateId);
    }
    
    function _returnWarriorClassAndName(uint _classId, uint _stateId) private view returns (string memory, string memory) {
        string memory className = warriorClasses[_classId];
        string memory warriorName;
        if (_classId == 0) {
            warriorName = elephantStates[_stateId];
        } else if (_classId == 1) {
            warriorName = knightStates[_stateId];
        } else if (_classId == 2) {
            warriorName = archerStates[_stateId];
        } else if (_classId == 3) {
            warriorName = swordsmanStates[_stateId];
        }
        return (className, warriorName);
    }
    
    function _getTimeDuration(uint _startTime, uint _endTime) private view returns (uint) {
        uint duration = _endTime - _startTime;
        return duration;
    }

    function trainWarrior(uint warriorId) public {
        require(
            warriorId >= 0 &&
            warriorId <= warriors.length &&
            warriors[warriorId].owner == msg.sender
        );
        uint lastTrainedDuration = (_getTimeDuration(warriors[warriorId].lastTrained, block.timestamp))/ 1 days;
        require(
          lastTrainedDuration >= 1
        );
        warriors[warriorId].xp += 100;
    }

}
