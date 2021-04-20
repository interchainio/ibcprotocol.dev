---
resources:
  - title: Overview Paper
    slug: overview-paper
    description: |
      The interblockchain communication protocol (IBC) is an end-to-end, connection-oriented, stateful protocol for reliable, ordered, and authenticated communication between modules on separate distributed ledgers...
    button: Download PDF v1.0
    link: https://github.com/cosmos/ibc/raw/old/papers/2020-05/build/paper.pdf
  - title: Technical Specification
    slug: technical-specification
    description: |
      Download the Interblockchain Communication Protocol Specification.
    button: Download PDF v1.0.0-rc5
    link: https://github.com/cosmos/ibc/raw/old/spec.pdf

ibcImplementations:
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      language: Go
      framework: Cosmos SDK
      supported-light-clients: <a href="https://github.com/cosmos/ibc-go/tree/main/modules/light-clients/07-tendermint">Tendermint</a>,&nbsp;<a href="https://github.com/cosmos/ibc-go/tree/main/modules/light-clients/06-solomachine">Solo Machine</a>
      implementer: <a href="https://interchain.berlin">Interchain GmbH</a>,&nbsp;<a href="https://informal.systems">Informal Systems</a> (auditor)
      links: |
        <a href="https://github.com/cosmos/ibc">Issue Tracker</a>,&nbsp;<a href="https://github.com/cosmos/ibc-go">Source</a>
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      language: Rust
      framework: Framework-agnostic
      supported-light-clients: |
        <a href="https://github.com/informalsystems/tendermint-rs">Tendermint</a>
      implementer: |
        <a href="https://informal.systems">Informal Systems</a>
      links: |
        <a href="https://github.com/informalsystems/ibc-rs">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Rust
      framework: Substrate
      supported-light-clients: <a href="https://github.com/octopus-network/substrate-ibc/tree/master/src/grandpa">Grandpa</a>
      implementer: |
        <a href="https://cdot.network">cdot Network</a>
      links: |
        <a href="https://github.com/cdot-network/substrate-ibc">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Solidity
      framework: EVM
      supported-light-clients: <a href="https://github.com/datachainlab/ibc-solidity/blob/main/docs/ibft2-light-client.md">IBFT 2.0</a>
      implementer: |
        <a href="https://github.com/datachainlab">Datachain</a>
      links: |
        <a href="https://github.com/datachainlab/ibc-solidity">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Go
      framework: Fabric, Cosmos SDK
      supported-light-clients: <a href="https://github.com/datachainlab/fabric-ibc/tree/main/x/ibc/light-clients/xx-fabric">Fabric</a>
      implementer: |
        <a href="https://github.com/datachainlab">Datachain</a>
      links: |
        <a href="https://github.com/datachainlab/fabric-ibc">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Kotlin
      framework: Corda
      supported-light-clients: <a href="https://github.com/datachainlab/corda-ibc/tree/main/go/x/ibc/light-clients/xx-corda">Corda</a>
      implementer: |
        <a href="https://github.com/datachainlab">Datachain</a>
      links: |
        <a href="https://github.com/datachainlab/corda-ibc">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Haskell
      framework: Kepler
      supported-light-clients: N/A
      implementer: |
        <a href="https://foam.space/">FOAM</a>
      links: N/A
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      language: Rust
      framework: Codechain
      supported-light-clients: <a href="https://github.com/CodeChain-io/codechain/blob/master/core/src/client/client.rs">Tendermint</a>
      implementer: |
        <a href="https://codechain.io">CodeChain</a>
      links: |
        <a href="https://github.com/CodeChain-io/codechain">Source Code</a>

relayerImplementations:
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: Go
      implementer: Cosmos Community
      links: |
        <a href="https://github.com/cosmos/relayer">Source Code</a>
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: Rust
      implementer: <a href="https://informal.systems/">Informal Systems</a>
      links: |
        <a href="https://github.com/informalsystems/ibc-rs/tree/master/relayer-cli">Source Code</a>
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: TypeScript
      implementer: <a href="https://confio.tech/">Confio</a>
      links: |
        <a href="https://github.com/confio/ts-relayer">Source Code</a>

ibcApplications:
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      application: Fungible Token Transfer
      framework: Cosmos SDK
      implementer: <a href="https://interchain.berlin">Interchain GmbH</a>
      links: |
        <a href="https://github.com/cosmos/cosmos-sdk/tree/master/x/ibc/applications/transfer">Source Code</a>,&nbsp;<a href="https://github.com/cosmos/ics/tree/master/spec/ics-020-fungible-token-transfer">Specification</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      application: Interchain Accounts
      framework: Cosmos SDK
      implementer: <a href="https://chainapsis.com/">Chainapsis</a>,&nbsp;<a href="https://interchain.berlin">Interchain GmbH</a>
      links: |
        <a href="https://github.com/chainapsis/cosmos-sdk-interchain-account">Source Code</a>,&nbsp;<a href="https://github.com/cosmos/ics/tree/master/spec/ics-027-interchain-accounts">Specification</a>

guides:
  - title: How to integrate IBC into a blockchain
    slug: how-to-integrate
    description: |
      Are you building a blockchain on top of the Cosmos SDK? Check out this guide to learn how to integrate IBC and start connecting with other chains!
    file: test.pdf
    button: Open Link
    link: https://docs.cosmos.network/master/ibc/integration.html
  - title: How to build an IBC application
    slug: how-to-build
    description: |
      Learn how to build an application on top of the IBC protocol (e.g. cross-chain token transfers). 
    file: test.pdf
    button: Open Link
    link: https://docs.cosmos.network/master/ibc/custom.html
