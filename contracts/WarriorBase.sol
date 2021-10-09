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

    struct Item {
        string name;
    }
    
    string[] warriorClasses = ["Elephant", "Knight", "Archer","Swordsman"];

    string[] elephantStates = ["Battle Elephant", "Elite Battle Elephant", "Destroyer Elephant"];
    string[] knightStates = ["Knight", "Cavalier", "Paladin"];
    string[] archerStates =["Archer", "Crossbowman", "Arbalester"];
    string[] swordsmanStates =["Long Swordsman", "Twohanded Swordsman", " Champion"];

    Warrior[] public warriors;
    mapping (address => uint[]) public ownerToWarriorIds;
    mapping (address => Item[]) public ownerInventory;


    event WarriorTrained(uint id, string name, address owner, uint xp, uint warriorType, uint dna);
    event WarriorCreated(uint id, string name, address owner, uint warriorType, uint dna);

    function _createWarrior(string memory _name, uint _warriorClass, uint _dna) private {
        uint initialWarriorType = _warriorClass * 10;
        warriors.push(Warrior(_name, msg.sender, initialWarriorType, _dna,0, 0));
        uint id = warriors.length - 1;
        ownerToWarriorIds[msg.sender].push(id);
        emit WarriorCreated(id, _name, msg.sender, _warriorClass, _dna) ;
    }
    

    function _generateRandomDna(string memory _name, uint _warriorClass) private view returns (uint) {
        uint rand = uint(keccak256(abi.encodePacked(_warriorClass ,_name)));
        return rand % dnaModulus;
    }

    function createRandomWarrior(string memory _name, uint _warriorClass) public {
        require(_warriorClass >= 0 && _warriorClass <= 3);
        uint randDna = _generateRandomDna(_name, _warriorClass);
        _createWarrior(_name, _warriorClass, randDna);
    }
    
    function _separateWarriorType(uint _warriorType) private pure returns (uint, uint) {
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
    
    function _getTimeDuration(uint _startTime, uint _endTime) private pure returns (uint) {
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
        emit WarriorTrained(warriorId, warriors[warriorId].name, msg.sender, warriors[warriorId].xp, warriors[warriorId].warriorType, warriors[warriorId].dna);
    }

}
