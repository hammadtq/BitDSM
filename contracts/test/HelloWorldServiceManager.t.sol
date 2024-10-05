// SPDX-License-Identifier: UNLICENSED
// pragma solidity ^0.8.12;

// import {HelloWorldServiceManager} from "../src/HelloWorldServiceManager.sol";
// import {MockAVSDeployer} from "@eigenlayer-middleware/test/utils/MockAVSDeployer.sol";
// import {ECDSAStakeRegistry} from "@eigenlayer-middleware/src/unaudited/ECDSAStakeRegistry.sol";
// import {Vm} from "forge-std/Vm.sol";
// import {console2} from "forge-std/Test.sol";
// import {HelloWorldDeploymentLib} from "../script/utils/HelloWorldDeploymentLib.sol";
// import {CoreDeploymentLib} from "../script/utils/CoreDeploymentLib.sol";
// import {UpgradeableProxyLib} from "../script/utils/UpgradeableProxyLib.sol";

// import {
//     Quorum,
//     StrategyParams,
//     IStrategy
// } from "@eigenlayer-middleware/src/interfaces/IECDSAStakeRegistryEventsAndErrors.sol";

// contract HelloWorldTaskManagerSetup is MockAVSDeployer {
//     Quorum internal quorum;

//     struct Operator {
//         Vm.Wallet key;
//         Vm.Wallet signingKey;
//     }

//     struct TrafficGenerator {
//         Vm.Wallet key;
//     }

//     Operator[] internal operators;
//     TrafficGenerator internal generator;

//     HelloWorldDeploymentLib.DeploymentData internal helloWorldDeployment;
//     CoreDeploymentLib.DeploymentData internal coreDeployment;
//     CoreDeploymentLib.DeploymentConfigData coreConfigData;

//     function setUp() public virtual {
//         operators.push(
//             Operator({
//                 key: vm.createWallet("operator"),
//                 signingKey: vm.createWallet("operator_signing_wallet")
//             })
//         );

//         generator = TrafficGenerator({key: vm.createWallet("generator_wallet")});

//         address proxyAdmin = UpgradeableProxyLib.deployProxyAdmin();

//         coreConfigData =
//             CoreDeploymentLib.readDeploymentConfigValues("test/mockData/config/core/", 1337); // TODO: Fix this to correct path
//         coreDeployment = CoreDeploymentLib.deployContracts(proxyAdmin, coreConfigData);

//         quorum.strategies.push(
//             StrategyParams({strategy: IStrategy(address(420)), multiplier: 10_000})
//         );

//         helloWorldDeployment =
//             HelloWorldDeploymentLib.deployContracts(proxyAdmin, proxyAdmin, proxyAdmin, coreDeployment, quorum);
//         labelContracts(coreDeployment, helloWorldDeployment);
//     }

//     function labelContracts(
//         CoreDeploymentLib.DeploymentData memory coreDeploymenttest,
//         HelloWorldDeploymentLib.DeploymentData memory helloWorldDeploymenttest
//     ) internal {
//         vm.label(coreDeploymenttest.delegationManager, "DelegationManager");
//         vm.label(coreDeploymenttest.avsDirectory, "AVSDirectory");
//         vm.label(coreDeploymenttest.strategyManager, "StrategyManager");
//         vm.label(coreDeploymenttest.eigenPodManager, "EigenPodManager");
//         vm.label(coreDeploymenttest.rewardsCoordinator, "RewardsCoordinator");
//         vm.label(coreDeploymenttest.eigenPodBeacon, "EigenPodBeacon");
//         vm.label(coreDeploymenttest.pauserRegistry, "PauserRegistry");
//         vm.label(coreDeploymenttest.wethStrategy, "WETHStrategy");

//         vm.label(helloWorldDeploymenttest.bitDSMServiceManager, "HelloWorldServiceManager");
//         vm.label(helloWorldDeploymenttest.stakeRegistry, "StakeRegistry");
//         vm.label(helloWorldDeploymenttest.wethStrategy, "WETHStrategy");
//     }
// }

// contract HelloWorldServiceManagerInitialization is HelloWorldTaskManagerSetup {
//     function testInitialization() public view {
//         assertTrue(helloWorldDeployment.stakeRegistry != address(0), "Not deployed");
//         assertTrue(helloWorldDeployment.bitDSMServiceManager != address(0), "Not deployed");
//         assertTrue(coreDeployment.delegationManager != address(0), "Not deployed");
//         assertTrue(coreDeployment.avsDirectory != address(0), "Not deployed");
//         assertTrue(coreDeployment.strategyManager != address(0), "Not deployed");
//         assertTrue(coreDeployment.eigenPodManager != address(0), "Not deployed");
//     }
// }