// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";
import {ERC1967Proxy} from "../lib/openzeppelin-contracts/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import {Upgrades} from "../lib/openzeppelin-foundry-upgrades/src/Upgrades.sol";

contract MyTokenUpgradeTest is Test {
    MyToken myToken;
    ERC1967Proxy proxy;
    
    address owner = makeAddr("owner");
    address newOwner = makeAddr("newOwner");

    function setUp() public {
        MyToken implementation = new MyToken();
        proxy = new ERC1967Proxy(
            address(implementation),
            abi.encodeCall(implementation.initialize, owner)
            );
        myToken = MyToken(address(proxy));
    }

    function test_upgradeability() external {
        Upgrades.upgradeProxy(address(proxy), "MyTokenV2.sol:MyTokenV2", "", owner);
    }
}