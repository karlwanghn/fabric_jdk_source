/*
SPDX-License-Identifier: Apache-2.0
*/

package edu.hit.sirtian;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.concurrent.*;

import org.hyperledger.fabric.gateway.*;

public class ClientApp {

	static {
		System.setProperty("org.hyperledger.fabric.sdk.service_discovery.as_localhost", "true");
	}

	public static void main(String[] args) throws Exception {
		// Load a file system based wallet for managing identities.
		Path walletPath = Paths.get("wallet");
		Wallet wallet = Wallets.newFileSystemWallet(walletPath);
		// load a CCP
		Path networkConfigPath = Paths.get("test-network", "organizations", "peerOrganizations", "org1.example.com", "connection-org1.yaml");

		Gateway.Builder builder = Gateway.createBuilder();
		builder.identity(wallet, "appUser").networkConfig(networkConfigPath).discovery(true);

		// create a gateway connection
//		try (Gateway gateway = builder.connect()) {
//
//			// get the network and contract
//			Network network = gateway.getNetwork("mychannel");
//			Contract contract = network.getContract("fabcar");
//
//			byte[] result;
//
//			result = contract.evaluateTransaction("queryAllCars");
//			System.out.println(new String(result));
//
//			contract.submitTransaction("createCar", "CAR10", "VW", "Polo", "Grey", "Mary");
//
//			result = contract.evaluateTransaction("queryCar", "CAR10");
//			System.out.println(new String(result));
//
//			contract.submitTransaction("changeCarOwner", "CAR10", "Archie");
//
//			result = contract.evaluateTransaction("queryCar", "CAR10");
//			System.out.println(new String(result));
//			System.out.println("that's all folks!");
//		}


		System.out.println("create threads ++++++++++++++++++");
		int  threadCount = 10;
		CountDownLatch countDownLatch = new CountDownLatch(threadCount);
		for(int i = 0;i < threadCount;i++){
			new Thread(()-> {
				Gateway gateway = builder.connect();
				// get the network and contract
				Network network = gateway.getNetwork("mychannel");
				Contract contract = network.getContract("fabcar");

				byte[] result;
				try {
					contract.submitTransaction("createCar", "CAR10", "VW", "Polo", "Grey", "Mary");
					result = contract.evaluateTransaction("queryAllCars");
					System.out.println(new String(result));
				} catch (ContractException e) {
					e.printStackTrace();
				} catch (TimeoutException e) {
					e.printStackTrace();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				countDownLatch.countDown();
			}).start();
		}

		countDownLatch.await();
		System.out.println("finished =====================");
	}

}
