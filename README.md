# Foundry Fund Me

A crowdfunding dApp powered by **Foundry** for the smart contracts and an **HTML frontend** to interact with the deployed contract.

## 🚀 Features:

- Contract deployment via Foundry with integrated Chainlink Price Feeds
- Funding & withdrawal logic with owner-only control along with Mock contracts for local testing
- Scripts for Environment-aware config Anvil, Sepolia, and Mainnet
- A simple, connectable frontend in `html-fund-me/` to interact with the deployed contract

## 🛠 Built using 

-  **Foundry**: development, testing, and deployment
-  **Solidity**: Smart Contracts
-  **Chainlink**: for decentralized price feeds
-  **Alchemy / Infura**: for RPC access to Sepolia/Mainnet
-  **HTML + JS**: lightweight frontend for interaction

## Requirements

### Foundry 

Documentation - https://book.getfoundry.sh/

### .env file should contain

```
SEPOLIA_RPC_URL=https://sepolia.infura.io/v3/your_project_id
MAINNET_RPC_URL=https://mainnet.infura.io/v3/your_project_id
PRIVATE_KEY=your_private_key
```

## Smart Contract Usage

### 1.  **Clone the repository**:

    ```bash
    git clone [https://github.com/yourusername/foundry-fund-me](https://github.com/yourusername/foundry-fund-me)
    cd foundry-fund-me
    ```

### 2.  **Install dependencies**:

    ```bash
    forge install
    ```

### 3. **Build Contracts**:

    ```bash
    forge build
    ```

### 4. **Run Tests**:

    ```bash
    forge test
    ```

### 5. **Deploy to Sepolia**:

    ```bash
    forge script script/DeployFundMe.s.sol:DeployFundMe \
      --rpc-url $SEPOLIA_RPC_URL \
      --private-key $PRIVATE_KEY \
      --broadcast
    ```

