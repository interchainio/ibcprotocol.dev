---
title: Introduction
---

IBC is an interoperability protocol for communicating arbitrary data between arbitrary state machines.

The protocol consists of two distinct layers: the transport layer (TAO) which provides the necessary infrastructure to establish secure connections and authenticate data packets between chains, and the application layer, which defines exactly how these data packets should be packaged and interpreted by the sending and receiving chains.

The IBC application layer can be used to build a wide range of cross-chain applications, including but not limited to token transfers, interchain accounts (delegate calls between two chains), non-fungible token transfers and oracle data feeds.