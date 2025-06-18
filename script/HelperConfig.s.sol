// SPDX-License-Identifier: UNLICENSED
import "forge-std/Script.sol";
import {MockV3Aggregator} from "../test/mocks/MockV3Aggregator.sol";
pragma solidity ^0.8.13;
contract HelperConfig  is Script{
    struct NetworkConfig {
        address priceFeed;
    }

    NetworkConfig public activeNetworkConfig;
    uint8 public constant DECIMALS = 8;
    int256 public constant INITIAL_PRICE = 2000e8; // 2000 USD in 8 decimals
    constructor() {
        if (block.chainid == 11155111) {
            activeNetworkConfig = getSepoliaEthConfig();
        } else if (block.chainid == 1) {
            activeNetworkConfig = getMainnetEthConfig();
        } else {
            activeNetworkConfig = getOrCreatAnvilEthConfig();
        }
    }
    function getSepoliaEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory sepoliaEthConfig = NetworkConfig({
            priceFeed: 0x694AA1769357215DE4FAC081bf1f309aDC325306
    });
        return sepoliaEthConfig;
    }
    function getOrCreatAnvilEthConfig() internal returns (NetworkConfig memory) {
        if(activeNetworkConfig.priceFeed != address(0)) {
            return activeNetworkConfig;
        }
            vm.startBroadcast();
            MockV3Aggregator mockPriceFeed = new MockV3Aggregator(
                DECIMALS,
                INITIAL_PRICE
            );
        vm.stopBroadcast();
        NetworkConfig memory anvilEthConfig = NetworkConfig({
            priceFeed: address(mockPriceFeed)
        });
        return anvilEthConfig;
    }
    function getMainnetEthConfig() public pure returns (NetworkConfig memory) {
        NetworkConfig memory mainnetEthConfig = NetworkConfig({
            priceFeed: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
        });
        return mainnetEthConfig;
    }
}