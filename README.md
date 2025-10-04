EcoMint Smart Contract  
**Carbon-Neutral NFT Minting and Eco-Tracking on Stacks Blockchain**

---

Overview
**EcoMint** is a blockchain-based smart contract designed to promote sustainability and environmental responsibility through **carbon-neutral NFT minting**.  
Built on the **Stacks blockchain** using **Clarity**, this contract allows creators to mint NFTs that are directly tied to green commitments, offset contributions, or verified eco-projects.

EcoMint empowers both NFT creators and collectors to make environmentally-conscious choices while engaging with digital assets.

---

Key Features
- **Sustainable Minting:** Each NFT minted supports eco-friendly initiatives or offset credits.  
- **Carbon Offset Integration:** Part of every minting fee funds verified green projects.  
- **Eco Metadata Tracking:** Every NFT includes metadata showing its carbon impact or offset value.  
- **Transparent Fund Distribution:** Automatically allocates minting fees between creators, projects, and the eco fund.  
- **Immutable Proof:** All minting and donation activities are recorded permanently on-chain.  

---

Smart Contract Details
- **Language:** Clarity  
- **Blockchain:** Stacks  
- **Token Standard:** SIP-009 (NFT Standard)  
- **Contract Name:** `eco-mint.clar`

---

Functions Overview

| Function | Access | Description |
|-----------|---------|-------------|
| `mint-eco-nft` | Public | Mints a new eco-linked NFT and registers its metadata. |
| `add-green-project` | Admin | Registers new verified green projects to receive eco-funds. |
| `donate-to-project` | Public | Enables users to contribute directly to listed projects. |
| `get-project-info` | Read-Only | Returns the details of a green project and total contributions. |
| `get-nft-metadata` | Read-Only | Displays eco-impact details of a specific NFT. |

---

How It Works
1. **Creator mints an NFT** → A portion of minting fees is allocated to verified eco-projects.  
2. **Eco impact recorded** → The NFT metadata includes environmental metrics (carbon offset, project name, etc.).  
3. **Transparent reporting** → Anyone can view eco-contributions through read-only functions.  

---

Testing
Run the following commands to verify contract functionality:
```bash
clarinet check
clarinet test
