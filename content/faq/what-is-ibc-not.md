---
title: What is IBC Not?
slug: what-is-ibc-not
order: 2
---
IBC is not an application-layer protocol: it handles data transport, authentication, and reliability only.

IBC is not an atomic-swap protocol: arbitrary cross-chain data transfer and computation is supported.
IBC is not a token transfer protocol: token transfer is a possible application-layer use of the IBC protocol.

IBC is not a sharding protocol: there is no single state machine being split across chains, but rather a diverse set of different state machines on different chains which share some common interfaces.

IBC is not a layer-two scaling protocol: all chains implementing IBC exist on the same "layer", although they may occupy different points in the network topology, and there is not necessarily a single root chain or single validator set.
