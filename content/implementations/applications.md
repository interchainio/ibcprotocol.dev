---
public:
  - title: ICS20 - Fungible Token Transfers 
    description: ibc-go, cw20
    link: https://github.com/cosmos/ibc-go/tree/main/modules/apps/transfer
  - title: ICS27 - Interchain Accounts 
    description: encode then execute a transaction from blockchain A on blockchain B in ibc-go
    link: https://github.com/cosmos/ibc-go/tree/interchain-accounts/modules/apps/27-interchain-accounts
  - title: ICS29 - Fee Middleware
    description: incentivised packet relaying in ibc-go
    link: https://github.com/cosmos/ibc-go/tree/ics29-fee-middleware/modules/apps/29-fee
  - title: Cross Chain Validation
    description: splitting the functionality of the proof-of-stake state machine, such as picking validator sets, tracking validators, tracking delegations, locking collateral, disbursing rewards, punishing misbehaviour, etc. across separate chains, where one (or many) chains run part (or all) of the proof-of-stake logic and one (or many) other chains accept & relay proof-of-stake relevant information (e.g. validator set updates, proofs-of-misbehaviour, etc.) cross-chain using IBC.
    link: 
  - title: Oracle Data Module (implemented by Band Protocol)
    description: this protocol allows other IBC-compatible blockchains to request data from BandChain.
    link: https://docs.bandchain.org/whitepaper/cosmos-ibc.html
---
