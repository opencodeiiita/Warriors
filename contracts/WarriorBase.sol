// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract WarriorBase {
    uint256 dnaDigits = 10;
    uint256 dnaModulus = 10**dnaDigits;


    struct Warrior {
        string name;
        string warriorId;
        address owner;
        uint256 warriorType;
        uint256 dna;
        uint256 xp;
        uint256 lastTrained;

    }

    string[] warriorClasses = ["Elephant", "Knight", "Archer", "Swordsman"];

    string[] elephantStates = [
        "Battle Elephant",
        "Elite Battle Elephant",
        "Destroyer Elephant"
    ];
    string[] knightStates = ["Knight", "Cavalier", "Paladin"];
    string[] archerStates = ["Archer", "Crossbowman", "Arbalester"];
    string[] swordsmanStates = [
        "Long Swordsman",
        "Twohanded Swordsman",
        " Champion"
    ];

    Warrior[] public warriors;
    mapping(address => uint256[]) public ownerToWarriorIds;

    event NewWarrior(
        string name,
        address owner,
        uint256 warriorType,
        uint256 dna,
        
    );

    function _createWarrior(
        string memory _name,
        uint256 _warriorType,
        uint256 _dna
    ) private {
        warriors.push(Warrior(_name, msg.sender, _warriorType, _dna, 0, 0));
        uint256 id = warriors.length - 1;
        ownerToWarriorIds[msg.sender].push(id);

        emit NewWarrior(_name, msg.sender, _warriorType, _dna, );
    }

    function _generateRandomDna(string memory _name, uint256 _warriorType)
        private
        view
        returns (uint256)
    {
        uint256 rand = uint256(
            keccak256(abi.encodePacked(_warriorType, _name))
        );
        return rand % dnaModulus;
    }

    function createRandomWarrior(string memory _name, uint256 _warriorType)
        public
    {
        require(_warriorType >= 0 && _warriorType <= 3);
        uint256 randDna = _generateRandomDna(_name, _warriorType);
        _createWarrior(_name, _warriorType, randDna);
    }

    function _separateWarriorType(uint256 _warriorType)
        private
        view
        returns (uint256, uint256)
    {
        uint256 stateId = _warriorType % 10;
        uint256 classId = (_warriorType - stateId) / 10;
        return (classId, stateId);
    }

    function _returnWarriorClassAndName(uint256 _classId, uint256 _stateId)
        private
        view
        returns (string memory, string memory)
    {
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

    function _getTimeDuration(uint256 _startTime, uint256 _endTime)
        private
        view
        returns (uint256)
    {
        uint256 duration = _endTime - _startTime;
        return duration;
    }

    function trainWarrior(uint256 warriorId) public {
        require(
            warriorId >= 0 &&
                warriorId <= warriors.length &&
                warriors[warriorId].owner == msg.sender
        );
        uint256 lastTrainedDuration = (
            _getTimeDuration(warriors[warriorId].lastTrained, block.timestamp)
        ) / 1 days;
        require(lastTrainedDuration >= 1);
        warriors[warriorId].xp += 100;
    }
}
