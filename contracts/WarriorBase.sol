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


    event WarriorTrained(uint id, string name, address owner, uint xp, uint warriorType, uint dna);
    event WarriorCreated(uint id, string name, address owner, uint warriorType, uint dna);

    function _createWarrior(string memory _name, uint _warriorClass, uint _dna) private {
        uint initialWarriorType = _warriorClass * 10;
        warriors.push(Warrior(_name, msg.sender, initialWarriorType, _dna,0, 0));
        uint id = warriors.length - 1;
        ownerToWarriorIds[msg.sender].push(id);
        emit WarriorCreated(id, _name, msg.sender, _warriorClass, _dna) ;
    }
    

    uint public result=1;
    uint public randAttack;
    uint public randSpeed;
    uint public  randDefence;
    uint public randHP;
    uint public randRateOfFire;
    mapping(uint=>mapping(string=>uint)) charactersticsMap;
    
    function _generateRandomDna(string memory _name, uint _warriorClass,uint _warriorType) private returns (uint) {
        
        
        //for warriorClass=0=>Warrior=="Elephant"
        charactersticsMap[0]["attack"]=4;
        charactersticsMap[0]["speed"]=3;
        charactersticsMap[0]["Defence"]=3;
        charactersticsMap[0]["HP"]=4;
        charactersticsMap[0]["Rate of Fire"]=1;
        
        //for warriorClass=1=>Warrior=="Knight"
        charactersticsMap[1]["Attack"]=3;
        charactersticsMap[1]["Speed"]=4;
        charactersticsMap[1]["Defence"]=4;
        charactersticsMap[1]["HP"]	=3;
        charactersticsMap[1]["Rate of Fire"]=2;
        
        //for warriorClass=2=>Warrior=="Archer"
        charactersticsMap[2]["Attack"]=1;
        charactersticsMap[2]["Speed"]=2;
        charactersticsMap[2]["Defence"]=1;
        charactersticsMap[2]["HP"]=1;
        charactersticsMap[2]["Rate of Fire"]=4;
        
        //for warriorClass=3=>Warrior=="Swordsman"
        charactersticsMap[0]["Attack"]=2;
        charactersticsMap[0]["Speed"]=1;
        charactersticsMap[0]["Defence"]=2;
        charactersticsMap[0]["HP"]=2;
        charactersticsMap[0]["Rate of Fire"]=3;
        
        result=0;
        
        //DNA indexed from 0 to 9 represents:
        //index 0,1=>value of attack
        //index 2,3=>value of speed
        // index 4,5=>value of Defence
        // index 6,7=>value of HP
        // index 8,9=>value of rateOfFireVal
        
        
        randAttack=(_warriorType-1)*6+uint(keccak256(abi.encodePacked(_warriorClass ,_name)))%6-1+(charactersticsMap[_warriorClass]["Attack"]-1)*20;
        if(randAttack<10){
            if(result==0){
                result=1;
            }
        result=result*100;
        }
        
        if(randAttack==0){
            result=result*10;
        }
        result=randAttack;
        
        
        randSpeed=(_warriorType-1)*6+uint(keccak256(abi.encodePacked(_warriorClass ,_name)))%6-1+(charactersticsMap[_warriorClass]["Speed"]-1)*20;
        result=result*100+randSpeed;
        
        
        randDefence=(_warriorType-1)*6+uint(keccak256(abi.encodePacked(_warriorClass ,_name)))%6-1+(charactersticsMap[_warriorClass]["Defence"]-1)*20;
        result=result*100+randDefence;
        
        
        randHP=(_warriorType-1)*6+uint(keccak256(abi.encodePacked(_warriorClass ,_name)))%6-1+(charactersticsMap[_warriorClass]["HP"]-1)*20;
        result=result*100+randHP;
        
        
        randRateOfFire=(_warriorType-1)*6+uint(keccak256(abi.encodePacked(_warriorClass ,_name)))%6-1+(charactersticsMap[_warriorClass]["Rate of Fire"]-1)*20;
        result=result*100+randRateOfFire;
        
        return result;
    }

    function createRandomWarrior(string memory _name, uint _warriorClass,uint _warriorType) public {
        require(_warriorClass >= 0 && _warriorClass <= 3);
        uint randDna = _generateRandomDna(_name, _warriorClass,_warriorType);
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
