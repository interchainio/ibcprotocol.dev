---
title: What blockchains are compatible with IBC?
slug: what-blockchains-are-compatible-with-ibc
order: 5
---
Any blockchain can be compatible with IBC provided they meet the following requirements:
- **Module System:** The host ledger must support a module system, whereby self-contained, potentially mutually distrusted packages of code can safely execute on the same ledger, control how and when they allow other modules to communicate with them, and be identified and manipulated by a controller module or execution environment.
- **Key-value Store:** The host ledger must provide a key/value store interface allowing values to be read, written, and deleted.
- **Consensus State Introspection:** Host ledgers must provide the ability to introspect their current block height and consensus state (as utilised by the host ledger’s light client algorithm), as well as a bounded number of recent consensus states (e.g. past headers).
- **Timestamp access:** In order to support timestamp-based timeouts, host ledgers must provide a current Unix-style timestamp. Timeouts in subsequent headers must be non-decreasing.
- **Port System:** Host ledgers must implement a port system, where the IBC handler can allow different modules in the host ledgerto bind to uniquely named ports.
- **Exception/rollback system:** Host ledgers must support an exception or rollback system,whereby a transaction can abort execution and revert any previously made state changes (including state changes in other modules happening within the same transaction),excluding gas consumed and fee payments as appropriate.
- **Data availability:** For deliver-or-timeout safety, host ledgers must have eventual data availability, such that any key/value pairs instate can be eventually retrieved by relayers.
