# Foundry Fund Me

A full-stack crowdfunding dApp powered by **Foundry** for the smart contracts and an **HTML frontend** to interact with the deployed contract.

This project includes:

- Contract deployment using Chainlink price feeds
- Funding & withdrawal logic with owner-only control along with Mock contracts for local testing
- Scripts for Environment-aware config Anvil, Sepolia, and Mainnet
- A simple frontend in `html-fund-me/` to connect with the contract

# Requirements

## Foundry 
Documentation - https://book.getfoundry.sh/

## .env file with:
```
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/your_project_id
MAINNET_RPC_URL=https://mainnet.infura.io/v3/your_project_id
PRIVATE_KEY=your_private_key
```

# Smart Contract Usage

## Install Dependencies

```
forge install
```

## Build Contracts

```
forge install
```

## Run Tests

```
forge test
```

## Deploy to Sepolia

```
forge script script/DeployFundMe.s.sol:DeployFundMe \
  --rpc-url $SEPOLIA_RPC_URL \
  --private-key $PRIVATE_KEY \
  --broadcast
```

# Built using 

-  Foundry
-  Solidity
-  Chainlink Price Feeds
-  HTML (frontend)
