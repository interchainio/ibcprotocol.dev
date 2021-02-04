---
resources:
  - title: Overview Paper
    slug: overview-paper
    description: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
      eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    button: Download PDF v1.0
    link: https://media.githubusercontent.com/media/cosmos/ics/master/papers/2020-05/build/paper.pdf
  - title: Technical Specification
    slug: technical-specification
    description: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
      eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    button: Download PDF v1.0.1
    link: https://github.com/cosmos/ics/blob/master/spec.pdf

ibcImplementations:
  - badgeLabel: 1.0 Release
    badgeColor: green
    content:
      framework: Cosmos SDK
      language: Golang
      supported-light-clients: Tendermint Light Client
      implementer: Interchain GmbH, Informal Systems (auditor)
      links: |
        <a href="https://github.com/cosmos/ics/issues/145">Issue Tracker</a>, <a href="https://github.com/cosmos/cosmos-sdk/pull/4548">Source</a>
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
      supported-light-clients:
      implementer: |
        <a href="https://kadena.io">Kadena</a>
      links:
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Codechain
      language: Rust
      supported-light-clients:
      implementer: |
        <a href="https://codechain.io">CodeChain</a>
      links: |
        <a href="https://github.com/CodeChain-io/codechain">Source Code</a>
  - badgeLabel: Upcoming
    badgeColor: yellow
    content:
      framework: Substrate
      language: Rust
      supported-light-clients:
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

guides:
  - title: How to integrate IBC into a blockchain
    slug: how-to-integrate
    description: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
      eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    file: test.pdf
    button: Open Link
    link: https://docs.cosmos.network/master/ibc/integration.html
  - title: How to build an IBC application
    slug: how-to-build
    description: Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy
      eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua.
    file: test.pdf
    button: Open Link
    link: https://docs.cosmos.network/master/ibc/custom.html
