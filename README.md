<h1 align="center">
    <b>Warriors</b>
</h1>

<h1 align="center">
    <img src="https://cdn3.iconfinder.com/data/icons/fantasy-and-role-play-game-adventure-quest/512/Sword-128.png" alt="impedia">
</h1>

Warriors is a Web3 MMO Game built on Polygon. Generate your warriors and fight against the world!

Deployed Contract on Polygon(Matic): [0x696cc396da776d8c33260f584b0b7f2a9c0dbce8](https://polygonscan.com/address/0x696cc396da776d8c33260f584b0b7f2a9c0dbce8)

You can go to the [Write Contract Tab](https://polygonscan.com/address/0x696cc396da776d8c33260f584b0b7f2a9c0dbce8#writeContract), connect your Wallet, and play directly from the smart contract!

## Local Setup

1. Install Node.js and NPM
2. `npm install -g truffle ganache-cli`
3. Install Metamask and create an Ethereum wallet for yourself.

You can also setup Solidity language support in your IDE for better development experience.

Thats it!

## Game Details

### There are four types of warriors:
1. Elephants
2. Knights
3. Archers
4. Swordsmen


### Base Warrior Stats:

|         | Attack | Speed | Defense | HP | Rate Of Fire |
|---------|--------|-------|---------|----|--------------|
|Elephant |   4    |   3   |    3    | 4  |      1       |
|Knights  |   3    |   4   |    4    | 3  |      2       |
|Archers  |   1    |   2   |    1    | 1  |      4       |
|Swordsmen|   2    |   1   |    2    | 2  |      3       |

### Each of them can also get promoted after reaching certain amount of xp.

`TODO: Stats Increase`

A warriors type can be broken into two digits (CL) which represents:
C -> Class, L -> Level

### Promotion Chart
* (00) Battle Elephant → (01) Elite battle elephant → (02) Destroyer Elephant
* (10) Knight → (11) Cavalier → (12) Paladin
* (20) Archer → (21) Crossbowman → (22) Arbalester
* (30) Long Swordsman → (31) Twohanded Swordsman → (32) Champion

