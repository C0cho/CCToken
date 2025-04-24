// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.10;

import "forge-std/Vm.sol";
import {Script, console } from "forge-std/Script.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

import "../src/CC.sol";
import "../test/EmptyContract.sol";

contract CCScript is Script {
    EmptyContract public emptyContract;
    CC public cc;
    CC public ccImplementation;
    ProxyAdmin public ccProxyAdmin;

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address deployerAddress = vm.addr(deployerPrivateKey);
        console.log("deployerAddress address======", deployerAddress);
        console.log("msg.sender", msg.sender);

        vm.startBroadcast(deployerPrivateKey);

        emptyContract = new EmptyContract();

        TransparentUpgradeableProxy proxyCC = new TransparentUpgradeableProxy(address(emptyContract), deployerAddress, "");

        cc = CC(payable(address(proxyCC)));

        console.log("theCC address======", address(cc));

        ccImplementation = new CC();


        ccProxyAdmin = ProxyAdmin(getProxyAdminAddress(address(proxyCC)));

        console.log("ccProxyAdmin address======", address(ccProxyAdmin));

        ccProxyAdmin.upgradeAndCall(
            ITransparentUpgradeableProxy(address(cc)),
            address(ccImplementation),
            abi.encodeWithSelector(
                CC.initialize.selector,
                10e40,
                msg.sender
            )
        );
        vm.stopBroadcast();
    }

    function getProxyAdminAddress(address proxy) internal view returns (address) {
        address CHEATCODE_ADDRESS = 0x7109709ECfa91a80626fF3989D68f67F5b1DD12D;
        Vm vm = Vm(CHEATCODE_ADDRESS);

        bytes32 adminSlot = vm.load(proxy, ERC1967Utils.ADMIN_SLOT);
        return address(uint160(uint256(adminSlot)));
    }
}
