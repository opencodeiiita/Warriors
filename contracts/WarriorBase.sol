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
    }

    // TODO: Define the 4 warrior types

    Warrior[] public warriors;
    mapping (address => uint[]) public ownerToWarriorIds;

    function _createWarrior(string memory _name, uint _warriorType, uint _dna) private {
        warriors.push(Warrior(_name, msg.sender, _warriorType, _dna));
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

}
