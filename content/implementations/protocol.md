---
public:
  - title: IBC-go
    slug: IBC-go
    description: |
Golang implementation built as a Cosmos SDK module.
  - title: IBC-rs
    slug: IBC-rs
    description: |
Rust implementation.

This project comprises primarily four crates:

The ibc crate defines the main data structures and on-chain logic for the IBC protocol.

The ibc-relayer crate provides an implementation of an IBC relayer, as a library.

The ibc-relayer-cli crate is a CLI (a wrapper over the ibc-relayer library), comprising the hermes binary.

The ibc-proto crate is a library with Rust types generated from .proto definitions necessary for interacting with Cosmos SDK and its IBC structs.

The ibc-telemetry crate is a library for use in the hermes CLI, for gathering telemetry data and exposing that in a Prometheus endpoint.
  - title: Solidity
    slug: Solidity
    description: |
      Solidity implementation of IBC core logic (IBC handlers)

enterprise:
  - title: TIBC
    slug: TIBC
    description: |
---
