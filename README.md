<h1 align="center">
    <b>Warriors</b>
</h1>

<h1 align="center">
    <img src="https://cdn3.iconfinder.com/data/icons/fantasy-and-role-play-game-adventure-quest/512/Sword-128.png" alt="impedia">
</h1>

Warriors is a Web3 MMO Game built on Polygon. Generate your warriors and fight against the world!

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

<table role="table">
<thead>
<tr>
<th></th>
<th>Attack</th>
<th>Speed</th>
<th>Defence</th>
<th>HP</th>
<th>Rate of Fire</th>
</tr>
</thead>
<tbody>
<tr>
<td>Elephants</td>
<td>4</td>
<td>3</td>
<td>3</td>
<td>4</td>
<td>1</td>
</tr>
<tr>
<td>Knights</td>
<td>3</td>
<td>4</td>
<td>4</td>
<td>3</td>
<td>2</td>
</tr>
<tr>
<td>Archers</td>
<td>1</td>
<td>2</td>
<td>1</td>
<td>1</td>
<td>4</td>
</tr>
<tr>
<td>Swordsman</td>
<td>2</td>
<td>1</td>
<td>2</td>
<td>2</td>
<td>3</td>
</tr>
</tbody>
</table>

### Each of them can also get promoted after reaching certain amount of xp.

`TODO: Stats Increase`

A warriors type can be broken into two digits (CL) which represents:
C -> Class, L -> Level

### Promotion Chart
* (00) Battle Elephant → (01) Elite battle elephant → (02) Destroyer Elephant
* (10) Knight → (11) Cavalier → (12) Paladin
* (20) Archer → (21) Crossbowman → (22) Arbalester
* (30) Long Swordsman → (31) Twohanded Swordsman → (32) Champion

