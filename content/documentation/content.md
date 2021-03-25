---
resources:
  - title: Overview Paper
    slug: overview-paper
    description: |
      The interblockchain communication protocol (IBC) is an end-to-end, connection-oriented, stateful protocol for reliable, ordered, and authenticated communication between modules on separate distributed ledgers...
    button: Download PDF v1.0
    link: https://s3.amazonaws.com/ibcprotocol.org/paper.pdf
  - title: Technical Specification
    slug: technical-specification
    description: |
      Download the Interblockchain Communication Protocol Specification.
    button: Download PDF v1.0.0-rc5
    link: https://s3.amazonaws.com/ibcprotocol.org/v0_3_1_IBC.pdf

ibcImplementations:
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      framework: Cosmos SDK
      language: Golang
      supported-light-clients: Tendermint Light Client
      implementer: Interchain GmbH, Informal Systems (auditor)
      links: |
        <a href="https://github.com/cosmos/ics/issues/145">Issue Tracker</a>,&nbsp;<a href="https://github.com/cosmos/cosmos-sdk/pull/4548">Source</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Tendermint-rs
      language: Rust
      supported-light-clients: |
        <a href="https://github.com/informalsystems/tendermint-rs">tendermint-rs</a>
      implementer: |
        <a href="https://informal.systems">Informal Systems</a>
      links: |
        <a href="https://github.com/informalsystems/ibc-rs">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Kepler
      language: Haskell
      supported-light-clients: N/A
      implementer: |
        <a href="https://foam.space/">FOAM</a>
      links: N/A
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Codechain
      language: Rust
      supported-light-clients: N/A
      implementer: |
        <a href="https://codechain.io">CodeChain</a>
      links: |
        <a href="https://github.com/CodeChain-io/codechain">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Substrate
      language: Rust
      supported-light-clients: Grandpa Light-client
      implementer: |
        <a href="https://cdot.network">Cdot Network</a>
      links: |
        <a href="https://github.com/cdot-network/substrate-ibc">Source Code</a>

relayerImplementations:
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: Golang
      implementer: Cosmos Community
      links: |
        <a href="https://github.com/cosmos/relayer">Source Code</a>
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: Rust
      implementer: Informal
      links: |
        <a href="https://github.com/informalsystems/ibc-rs/tree/master/relayer-cli">Source Code</a>
  - badgeLabel: Alpha
    badgeColor: lightGray
    content:
      language: TypeScript
      implementer: Confio
      links: |
        <a href="https://github.com/confio/ts-relayer">Source Code</a>

ibcApplications:
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      application: Fungible Token Transfer
      framework: Cosmos SDK
      implementer: Interchain GmbH
      links: |
        <a href="https://github.com/cosmos/cosmos-sdk/tree/master/x/ibc/applications/transfer">Source Code</a>,&nbsp;<a href="https://github.com/cosmos/ics/tree/master/spec/ics-020-fungible-token-transfer">Specification</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      application: Interchain Accounts
      framework: Cosmos SDK
      implementer: Chainapsis
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
