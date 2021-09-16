<template>
  <div class="mx-auto max-w-7xl">
    <body>
      <p
        class="s1"
        style="
          padding-top: 7pt;
          padding-left: 6pt;
          text-indent: 0pt;
          text-align: left;
          font-family: 'Times New Roman', serif;
          font-style: normal;
          font-weight: normal;
          text-decoration: none;
          font-size: 25pt;
        "
      >
        The Interblockchain Communication Protocol: An Overview
      </p>
      <br />
      <br />
      <p
        class="s2"
        style="padding-left: 6pt; text-indent: 0pt; text-align: left"
      >
        Christopher Goes <span class="p">Interchain GmbH Berlin, Germany</span>
      </p>
      <p style="padding-left: 6pt; text-indent: 0pt; text-align: left">
        <a href="mailto:cwgoes@interchain.berlin">cwgoes@interchain.berlin</a>
      </p>
      <p style="text-indent: 0pt; text-align: left"><br /></p>
      <p
        class="s3"
        style="
          padding-top: 8pt;
          padding-left: 6pt;
          text-indent: 0pt;
          text-align: justify;
        "
      >
        Abstract<span class="h2"
          >—The interblockchain communication proto- col (IBC) is an end-to-end,
          connection-oriented, state- ful protocol for reliable, ordered, and
          authenticated communication between modules on separate dis- tributed
          ledgers. IBC is designed for interoperation between heterogenous
          ledgers arranged in an unknown, dynamic topology, operating with
          varied consensus algorithms and state machines. The protocol realises
          this by specifying the sufficient set of data structures,
          abstractions, and semantics of a communication pro- tocol which once
          implemented by participating ledgers will allow them to safely
          communicate. IBC is payload- agnostic and provides a cross-ledger
          asynchronous com- munication primitive which can be used as a
          constituent building block by a wide variety of applications.</span
        >
      </p>
      <p
        class="s3"
        style="
          padding-top: 6pt;
          padding-left: 6pt;
          text-indent: 0pt;
          text-align: justify;
        "
      >
        Index Terms<span class="h2">—ibc; interblockchain; dlt</span>
      </p>
      <p style="text-indent: 0pt; text-align: left"><br /></p>
      <ol id="l1">
        <li>
          <p
            style="padding-left: 104pt; text-indent: -12pt; text-align: justify"
          >
            <a name="bookmark0">Introduction</a>
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            By virtue of their nature as replicated state machines across which
            deterministic execution and thus continued agreement on an exact
            deterministic ruleset must be maintained, individual distributed
            ledgers are limited in their throughput &amp; flexibility, must
            trade off application- specific optimisations for general-purpose
            capabilities, and can only offer a single security model to
            applications built on top of them. In order to support the transac-
            tion throughput, application diversity, cost efficiency, and fault
            tolerance required to facilitate wide deployment of distributed
            ledger applications, execution and storage must be split across many
            independent ledgers which can run concurrently, upgrade
            independently, and each specialise in different ways, in a manner
            such that the ability of different applications to communicate with
            one another, essential for permissionless innovation and complex
            multi- part contracts, is maintained.
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 1pt;
              text-align: justify;
            "
          >
            One multi-ledger design direction is to shard a single logical
            ledger across separate consensus instances, referred to as “shards”,
            which execute concurrently and store disjoint partitions of the
            state. In order to reason globally about safety and liveness, and in
            order to correctly route data and code between shards, these designs
            must take a “top-down approach” — constructing a particular network
            topology, usually a single root ledger and a star or tree of shards,
            and engineering protocol rules and incentives to enforce that
            topology. Message passing can then be implemented on top of such a
            sharded topology by systems such as Polkadot’s XCMP [1] and Ethereum
            2.0’s cross-shard communication [2]. This approach possesses
            advantages in simplicity and
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            predictability, but faces hard technical problems in assuring the
            validity of state transitions [3], requires the adherence of all
            shards to a single validator set (or randomly elected subset
            thereof) and a single virtual machine, and faces challenges in
            upgrading itself over time due to the necessity of reaching global
            consensus on alterations to the network topology or ledger ruleset.
            Additionally, such sharded systems are brittle: if the fault
            tolerance threshold is exceeded, the system needs to coordinate a
            global halt &amp; restart, and possibly initiate complex state
            transition rollback procedures — it is not possible to safely
            isolate Byzantine portions of the network graph and continue
            operation.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The <i>interblockchain communication protocol </i>(IBC) provides a
            mechanism by which separate, sovereign replicated ledgers can
            safely, voluntarily interact while sharing only a minimum requisite
            common interface. The protocol design approaches a differently
            formulated version of the scaling and interoperability problem:
            enabling safe, reliable interoperation of a network of heterogeneous
            distributed ledgers, arranged in an unknown topology, preserving
            data secrecy where possible, where the ledgers can diversify,
            develop, and rearrange independently of each other or of a
            particular imposed topology or ledger design. In a wide, dynamic
            network of interoperating ledgers, sporadic Byzantine faults are
            expected, so the protocol must also detect, mitigate, and contain
            the potential damage of Byzantine faults in accordance with the
            requirements of the applications and ledgers involved without
            requiring the use of additional trusted parties or global
            coordination.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            To facilitate this heterogeneous interoperation, the in-
            terblockchain communication protocol utilises a bottom-up approach,
            specifying the set of requirements, functions, and properties
            necessary to implement interoperation between two ledgers, and then
            specifying different ways in which multiple interoperating ledgers
            might be composed which preserve the requirements of higher-level
            protocols. IBC thus presumes nothing about and requires nothing of
            the overall network topology, and of the implementing ledgers
            requires only that a known, minimal set of functions with specified
            properties are available. Ledgers within IBC are defined as their
            light client consensus validation functions, thus expanding the
            range of what a “ledger” can be to include single machines and
            complex consensus algorithms alike. IBC implementations are expected
            to be co-resident with higher-level modules and protocols on the
            host ledger.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Ledgers hosting IBC must provide a certain set of functions for
            consensus transcript verification and cryptographic commitment proof
            generation, and IBC packet relayers (off- ledger processes) are
            expected to have access to network protocols and physical data-links
            as required to read the state of one ledger and submit data to
            another.
          </p>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The data payloads in IBC packets are opaque to the protocol itself —
            modules on each ledger determine the semantics of the packets which
            are sent between them. For cross-ledger token transfer, packets
            could contain fungible token information, where assets are locked on
            one ledger to mint corresponding vouchers on another. For
            cross-ledger governance, packets could contain vote information,
            where accounts on one ledger could vote in the governance system of
            another. For cross-ledger account delegation, packets could contain
            transaction authorisation information, allowing an account on one
            ledger to be controlled by an account on another. For a cross-ledger
            decentralised exchange, packets could contain order intent
            information or trade settlement information, such that assets on
            different ledgers could be exchanged without leaving their host
            ledgers by transitory escrow and a sequence of packets.
          </p>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            This bottom-up approach is quite similar to, and directly inspired
            by, the TCP/IP specification [4] for interoperability between hosts
            in packet-switched computer networks. Just as TCP/IP defines the
            protocol by which two hosts commu- nicate, and higher-level
            protocols knit many bidirectional host-to-host links into complex
            topologies, IBC defines the protocol by which two ledgers
            communicate, and higher- level protocols knit many bidirectional
            ledger-to-ledger links into gestalt multi-ledger applications. Just
            as TCP/IP packets contain opaque payload data with semantics inter-
            preted by the processes on each host, IBC packets contain opaque
            payload data with semantics interpreted by the modules on each
            ledger. Just as TCP/IP provides reliable, ordered data transmission
            between processes, allowing a process on one host to reason about
            the state of a process on another, IBC provides reliable, ordered
            data transmission between modules, allowing a module on one ledger
            to reason about the state of a module on another.
          </p>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            This paper is intended as an overview of the abstractions defined by
            the IBC protocol and the mechanisms by which they are composed. We
            first outline the structure of the protocol, including scope,
            interfaces, and operational requirements. Subsequently, we detail
            the abstractions defined by the protocol, including modules, ports,
            clients, connections, channels, packets, and relayers, and describe
            the subprotocols for opening and closing handshakes, packet relay,
            edge-case handling, and relayer operations. After explaining the
            internal structure of the protocol, we define the interface by which
            applications can utilise IBC, and sketch an example
            application-level protocol for fungible token transfer. Finally, we
            recount testing and
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 7pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a name="bookmark1"
              >deployment efforts of the protocol thus far. Appendices include
              pseudocode for the connection handshake, channel handshake, and
              packet relay algorithms.</a
            >
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 67pt;
              text-indent: -17pt;
              text-align: justify;
            "
          >
            <a name="bookmark2">Protocol scope &amp; properties</a>
          </p>
          <ol id="l2">
            <li>
              <p
                style="
                  padding-top: 3pt;
                  padding-left: 24pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                Scope
              </p>
              <p
                style="
                  padding-top: 3pt;
                  padding-left: 7pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark3"
                  >IBC handles authentication, transport, and ordering of opaque
                  data packets relayed between modules on separate ledgers —
                  ledgers can be run on solo machines, replicated by many nodes
                  running a consensus algorithm, or constructed by any process
                  whose state can be verified. The protocol is defined between
                  modules on two ledgers, but designed for safe simultaneous use
                  between any number of modules on any number of ledgers
                  connected in arbitrary topologies.</a
                >
              </p>
            </li>
            <li>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 24pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                Interfaces
              </p>
              <p
                style="
                  padding-top: 3pt;
                  padding-left: 7pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                IBC sits between modules — smart contracts, other ledger
                components, or otherwise independently executed pieces of
                application logic on ledgers — on one side, and underlying
                consensus protocols, blockchains, and network infrastructure
                (e.g. TCP/IP), on the other side.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 7pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                IBC provides to modules a set of functions much like the
                functions which might be provided to a module for interacting
                with another module on the same ledger: sending data packets and
                receiving data packets on an established connection and channel,
                in addition to calls to manage the protocol state: opening and
                closing connections and channels, choosing connection, channel,
                and packet delivery options, and inspecting connection and
                channel status.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 1pt;
                  text-align: justify;
                "
              >
                <a name="bookmark4"
                  >IBC requires certain functionalities and properties of the
                  underlying ledgers, primarily finality (or thresholding
                  finality gadgets), cheaply-verifiable consensus transcripts
                  (such that a light client algorithm can verify the results of
                  the consensus process with much less computation &amp; storage
                  than a full node), and simple key/value store functionality.
                  On the network side, IBC requires only eventual data delivery
                  — no authentication, synchrony, or ordering properties are
                  assumed.</a
                >
              </p>
            </li>
            <li>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 24pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                Operation
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 3pt;
              padding-left: 7pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The primary purpose of IBC is to provide reliable, authen- ticated,
            ordered communication between modules running on independent host
            ledgers. This requires protocol logic in the areas of data relay,
            data confidentiality and legibility, reliability, flow control,
            authentication, statefulness, and multiplexing.
          </p>
          <ol id="l3">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 22pt;
                  text-indent: -14pt;
                  text-align: justify;
                "
              >
                <a name="bookmark5">Data relay</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 1pt;
                  text-align: justify;
                "
              >
                In the IBC architecture, modules are not directly sending
                messages to each other over networking infrastructure, but
                rather are creating messages to be sent which are then
                physically relayed from one ledger to another by monitoring
                “relayer processes”. IBC assumes the existence of a set of
                relayer processes with access to an underlying network
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark6"
                  >protocol stack (likely TCP/IP, UDP/IP, or QUIC/IP) and
                  physical interconnect infrastructure. These relayer processes
                  monitor a set of ledgers implementing the IBC protocol,
                  continuously scanning the state of each ledger and requesting
                  transaction execution on another ledger when outgoing packets
                  have been committed. For correct operation and progress in a
                  connection between two ledgers, IBC requires only that at
                  least one correct and live relayer process exists which can
                  relay between the ledgers.</a
                >
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 11pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Data confidentiality and legibility
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark7"
                  >The IBC protocol requires only that the minimum data
                  necessary for correct operation of the IBC protocol be made
                  available and legible (serialised in a standardised format) to
                  relayer processes, and the ledger may elect to make that data
                  available only to specific relayers. This data consists of
                  consensus state, client, connection, channel, and packet
                  information, and any auxiliary state structure necessary to
                  construct proofs of inclusion or exclusion of particular
                  key/value pairs in state. All data which must be proved to
                  another ledger must also be legible; i.e., it must be
                  serialised in a standardised format agreed upon by the two
                  ledgers.</a
                >
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 11pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Reliability
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark8"
                  >The network layer and relayer processes may behave in
                  arbitrary ways, dropping, reordering, or duplicating packets,
                  purposely attempting to send invalid transactions, or
                  otherwise acting in a Byzantine fashion, without com-
                  promising the safety or liveness of IBC. This is achieved by
                  assigning a sequence number to each packet sent over an IBC
                  channel, which is checked by the IBC handler (the part of the
                  ledger implementing the IBC protocol) on the receiving ledger,
                  and providing a method for the sending ledger to check that
                  the receiving ledger has in fact received and handled a packet
                  before sending more packets or taking further action.
                  Cryptographic commitments are used to prevent datagram
                  forgery: the sending ledger commits to outgoing packets, and
                  the receiving ledger checks these commitments, so datagrams
                  altered in transit by a relayer will be rejected. IBC also
                  supports unordered channels, which do not enforce ordering of
                  packet receives relative to sends but still enforce
                  exactly-once delivery.</a
                >
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 11pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Flow control
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                IBC does not provide specific protocol-level provisions for
                compute-level or economic-level flow control. The under- lying
                ledgers are expected to have compute throughput limiting devices
                and flow control mechanisms of their own such as gas markets.
                Application-level economic flow con- trol — limiting the rate of
                particular packets according to their content — may be useful to
                ensure security properties and contain damage from Byzantine
                faults. For example, an application transferring value over an
                IBC channel might
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark9"
                  >want to limit the rate of value transfer per block to limit
                  damage from potential Byzantine behaviour. IBC provides
                  facilities for modules to reject packets and leaves
                  particulars up to the higher-level application protocols.</a
                >
              </p>
              <p style="text-indent: 0pt; text-align: left"><br /></p>
            </li>
            <li>
              <p
                class="s4"
                style="padding-left: 21pt; text-indent: -14pt; text-align: left"
              >
                Authentication
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark10"
                  >All data sent over IBC are authenticated: a block finalised
                  by the consensus algorithm of the sending ledger must com- mit
                  to the outgoing packet via a cryptographic commitment, and the
                  receiving ledger’s IBC handler must verify both the consensus
                  transcript and the cryptographic commitment proof that the
                  datagram was sent before acting upon it.</a
                >
              </p>
              <p style="text-indent: 0pt; text-align: left"><br /></p>
            </li>
            <li>
              <p
                class="s4"
                style="padding-left: 21pt; text-indent: -14pt; text-align: left"
              >
                Statefulness
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark11"
                  >Reliability, flow control, and authentication as described
                  above require that IBC initialises and maintains certain
                  status information for each datastream. This information is
                  split between three abstractions: clients, connections, and
                  channels. Each client object contains information about the
                  consensus state of the counterparty ledger. Each connection
                  object contains a specific pair of named identifiers agreed to
                  by both ledgers in a handshake protocol, which uniquely
                  identifies a connection between the two ledgers. Each channel,
                  specific to a pair of modules, contains information concerning
                  negotiated encoding and multiplexing options and state and
                  sequence numbers. When two modules wish to communicate, they
                  must locate an existing connection and channel between their
                  two ledgers, or initialise a new connection and channel(s) if
                  none yet exist. Initialising connections and channels requires
                  a multi-step handshake which, once complete, ensures that only
                  the two intended ledgers are connected, in the case of
                  connections, and ensures that two modules are connected and
                  that future datagrams relayed will be authenticated, encoded,
                  and sequenced as desired, in the case of channels.</a
                >
              </p>
              <p style="text-indent: 0pt; text-align: left"><br /></p>
            </li>
            <li>
              <p
                class="s4"
                style="padding-left: 21pt; text-indent: -14pt; text-align: left"
              >
                Multiplexing
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 9pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            To allow for many modules within a single host ledger to use an IBC
            connection simultaneously, IBC allows any number of channels to be
            associated with a single connection. Each channel uniquely
            identifies a datastream over which packets can be sent in order (in
            the case of an ordered channel), and always exactly once, to a
            destination module on the receiving ledger. Channels are usually
            expected to be associated with a single module on each ledger, but
            one-to-many and many-to-one channels are also possible. The number
            of channels per connection is unbounded, facilitating concurrent
            throughput limited only by the throughput of the underlying ledgers
            with only a single connection and pair of clients necessary to track
            consensus information (and consensus transcript verification cost
            thus amortised across all channels using the connection).
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 5pt;
              padding-left: 75pt;
              text-indent: -21pt;
              text-align: left;
            "
          >
            <a name="bookmark12">Host ledger requirements</a
            ><a name="bookmark13">&zwnj;</a>
          </p>
          <ol id="l4">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 4pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Module system
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                <a name="bookmark14"
                  >The host ledger must support a module system, whereby
                  self-contained, potentially mutually distrusted packages of
                  code can safely execute on the same ledger, control how and
                  when they allow other modules to communicate with them, and be
                  identified and manipulated by a controller module or execution
                  environment.</a
                >
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Key/value Store
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The host ledger must provide a key/value store interface
                allowing values to be read, written, and deleted.
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                These functions must be permissioned to the IBC handler module
                so that only the IBC handler module can write or delete a
                certain subset of paths. This will likely be implemented as a
                sub-store (prefixed key-space) of a larger key/value store used
                by the entire ledger.
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Host ledgers must provide an instance of this interface which is
                provable, such that the light client algorithm for the host
                ledger can verify presence or absence of particular key-value
                pairs which have been written to it.
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                This interface does not necessitate any particular storage
                backend or backend data layout. ledgers may elect to use a
                storage backend configured in accordance with their needs, as
                long as the store on top fulfils the specified interface and
                provides commitment proofs.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark15">Consensus state introspection</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Host ledgers must provide the ability to introspect their
                current height, current consensus state (as utilised by the host
                ledger’s light client algorithm), and a bounded number of recent
                consensus states (e.g. past headers). These are used to prevent
                man-in-the-middle attacks during handshakes to set up
                connections with other ledgers — each ledger checks that the
                other ledger is in fact authenticating data using its consensus
                state.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark16">Timestamp access</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                In order to support timestamp-based timeouts, host ledgers must
                provide a current Unix-style timestamp. Timeouts in subsequent
                headers must be non-decreasing.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark17">Port system</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Host ledgers must implement a port system, where the IBC handler
                can allow different modules in the host ledger to bind to
                uniquely named ports. Ports are identified by an identifier, and
                must be permissioned so that:
              </p>
              <ul id="l5">
                <li>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: left;
                    "
                  >
                    Once a module has bound to a port, no other modules can use
                    that port until the module releases it
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: left;
                    "
                  >
                    A single module can bind to multiple ports
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: left;
                    "
                  >
                    Ports are allocated first-come first-serve
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-top: 5pt;
                      padding-left: 26pt;
                      text-indent: -9pt;
                      text-align: left;
                    "
                  >
                    “Reserved” ports for known modules can be bound when the
                    ledger is first started
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    This permissioning can be implemented with unique references
                    (object capabilities [5]) for each port, with source-based
                    authentication(a la <span class="s5">msg.sender </span>in
                    Ethereum contracts), or with some other method of access
                    control, in any case enforced by the host ledger.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Ports are not generally intended to be human-readable
                    identifiers — just as DNS name resolution and standardised
                    port numbers for particular applications exist to abstract
                    away the details of IP addresses and ports from TCP/IP
                    users, ledger name resolution and standardised ports for
                    particular applications may be created in order to abstract
                    away the details of ledger identification and port
                    selection. Such an addressing system could easily be built
                    on top of IBC itself, such that an initial connection to the
                    addressing system over IBC would then enable name resolution
                    for subsequent connections to other ledgers and
                    applications.
                  </p>
                </li>
              </ul>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: justify;
                "
              >
                <a name="bookmark18">Exception/rollback system</a>
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Host ledgers must support an exception or rollback system,
                whereby a transaction can abort execution and revert any
                previously made state changes (including state changes in other
                modules happening within the same transaction), excluding gas
                consumed and fee payments as appropriate.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: justify;
                "
              >
                <a name="bookmark19">Data availability</a>
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 8pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            For deliver-or-timeout safety, host ledgers must have eventual data
            availability, such that any key/value pairs in state can be
            eventually retrieved by relayers. For exactly- once safety, data
            availability is not required.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            For liveness of packet relay, host ledgers must have bounded
            transactional liveness, such that incoming transactions are
            confirmed within a block height or timestamp bound (in particular,
            less than the timeouts assigned to the packets).
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a name="bookmark20"
              >IBC packet data, and other data which is not directly stored in
              the Merklized state but is relied upon by relayers, must be
              available to and efficiently computable by relayer processes.</a
            >
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 90pt;
              text-indent: -20pt;
              text-align: justify;
            "
          >
            <a name="bookmark21">Protocol structure</a>
          </p>
          <ol id="l6">
            <li>
              <p
                style="
                  padding-top: 3pt;
                  padding-left: 23pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                Clients
              </p>
              <p
                style="
                  padding-top: 3pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The <i>client </i>abstraction encapsulates the properties that
                consensus algorithms of ledgers implementing the in-
                terblockchain communication protocol are required to satisfy.
                These properties are necessary for efficient and safe state
                verification in the higher-level protocol abstractions. The
                algorithm utilised in IBC to verify the consensus transcript and
                state sub-components of another ledger is referred to as a
                “validity predicate”, and pairing it with a state that the
                verifier assumes to be correct forms a “light client”
                (colloquially shortened to “client”).
              </p>
              <ol id="l7">
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 5pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark22">Motivation</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    In the IBC protocol, an actor, which may be an end user, an
                    off-ledger process, or ledger, needs to be able to verify
                    updates to the state of another ledger which the other
                    ledger’s consensus algorithm has agreed upon, and reject any
                    possible updates which the other ledger’s consensus
                    algorithm has not agreed upon. A light client is the
                    algorithm with which an actor can do so. The client
                    abstraction formalises this model’s interface and require-
                    ments, so that the IBC protocol can easily integrate with
                    new ledgers which are running new consensus algorithms as
                    long as associated light client algorithms fulfilling the
                    listed requirements are provided.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Beyond the properties described in this specification, IBC
                    does not impose any requirements on the internal operation
                    of ledgers and their consensus algorithms. A ledger may
                    consist of a single process signing operations with a
                    private key, a quorum of processes signing in unison, many
                    processes operating a Byzantine fault-tolerant consensus
                    algorithm (a replicated, or distributed, ledger), or other
                    configurations yet to be invented — from the perspective of
                    IBC, a ledger is defined entirely by its light client
                    validation and equivocation detection logic. Clients will
                    generally not include validation of the state transition
                    logic in general (as that would be equivalent to simply
                    executing the other state machine), but may elect to
                    validate parts of state transitions in particular cases, and
                    can validate the entire state transition if doing so is
                    asymptotically efficient, perhaps through compression using
                    a SNARK [6].
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Externally, however, the light client verification functions
                    used by IBC clients must have <i>finality</i>, such that
                    verified blocks (subject to the usual consensus safety
                    assumptions), once verified, cannot be reverted. The safety
                    of higher abstraction layers of the IBC protocol and
                    guarantees provided to the applications using the protocol
                    depend on this property of finality.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    In order to graft finality onto Nakamoto consensus al-
                    gorithms, such as used in Bitcoin [7], clients can act as
                    thresholding views of internal, non-finalising clients. In
                    the case where modules utilising the IBC protocol to
                    interact with probabilistic-finality consensus algorithms
                    which might require different finality thresholds for
                    different applications, one write-only client could be
                    created to track headers and many read-only clients with
                    different finality thresholds (confirmation depths after
                    which state roots are considered final) could use that same
                    state. Of course, this will introduce different security
                    assumptions than those required of full nodes running the
                    consensus algorithm, and trade-offs which must be balanced
                    by the user on the basis of their application-specific
                    security needs.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The client protocol is designed to support third-party
                    introduction. Consider the general example: Alice, a module
                    on a ledger, wants to introduce Bob, a second module on
                  </p>
                  <p
                    style="
                      padding-top: 5pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    a second ledger who Alice knows (and who knows Alice), to
                    Carol, a third module on a third ledger, who Alice knows but
                    Bob does not. Alice must utilise an existing channel to Bob
                    to communicate the canonically-serialisable validity
                    predicate for Carol, with which Bob can then open a
                    connection and channel so that Bob and Carol can talk
                    directly. If necessary, Alice may also communicate to Carol
                    the validity predicate for Bob, prior to Bob’s connection
                    attempt, so that Carol knows to accept the incoming request.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark23"
                      >Client interfaces are constructed so that custom
                      validation logic can be provided safely to define a custom
                      client at runtime, as long as the underlying ledger can
                      provide an appropriate gas metering mechanism to charge
                      for compute and storage. On a host ledger which supports
                      WASM execution, for example, the validity predicate and
                      equivocation predicate could be provided as executable
                      WASM functions when the client instance is created.</a
                    >
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Definitions
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 7pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>validity predicate </i>is an opaque function defined by
                    a client type to verify headers depending on the current
                    consensus state. Using the validity predicate should be far
                    more computationally efficient than replaying the full
                    consensus algorithm and state machine for the given parent
                    header and the list of network messages.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 7pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>consensus state </i>is an opaque type representing the
                    state of a validity predicate. The light client validity
                    predicate algorithm in combination with a particular
                    consensus state must be able to verify state updates agreed
                    upon by the associated consensus algorithm. The consensus
                    state must also be serialisable in a canonical fashion so
                    that third parties, such as counterparty ledgers, can check
                    that a particular ledger has stored a particular state. It
                    must also be introspectable by the ledger which it is for,
                    such that the ledger can look up its own consensus state at
                    a past height and compare it to a stored consensus state in
                    another ledger’s client.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 7pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>commitment root </i>is an inexpensive way for
                    downstream logic to verify whether key/value pairs are
                    present or absent in a state at a particular height. Often
                    this will be instantiated as the root of a Merkle tree.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 7pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>header </i>is an opaque data structure defined by a
                    client type which provides information to update a consensus
                    state. Headers can be submitted to an associated client to
                    update the stored consensus state. They likely contain a
                    height, a proof, a new commitment root, and possibly updates
                    to the validity predicate.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>misbehaviour predicate </i>is an opaque function
                    defined by a client type, used to check if data constitutes
                    a violation of the consensus protocol. This might be two
                    signed headers with different state roots but the same
                    height, a signed header containing invalid state
                    transitions,
                  </p>
                  <p
                    style="
                      padding-top: 5pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark24"
                      >or other evidence of malfeasance as defined by the
                      consensus algorithm.</a
                    >
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 9pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Desired properties
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Light clients must provide a secure algorithm to verify
                    other ledgers’ canonical headers, using the existing
                    consensus state. The higher level abstractions will then be
                    able to verify sub-components of the state with the
                    commitment roots stored in the consensus state, which are
                    guaranteed to have been committed by the other ledger’s
                    consensus algorithm.
                  </p>
                  <p
                    style="
                      padding-top: 9pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Validity predicates are expected to reflect the behaviour of
                    the full nodes which are running the corresponding consensus
                    algorithm. Given a consensus state and a list of messages,
                    if a full node accepts a new header, then the light client
                    must also accept it, and if a full node rejects it, then the
                    light client must also reject it.
                  </p>
                  <p
                    style="
                      padding-top: 9pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Light clients are not replaying the whole message
                    transcript, so it is possible under cases of consensus
                    misbehaviour that the light clients’ behaviour differs from
                    the full nodes’. In this case, a misbehaviour proof which
                    proves the divergence between the validity predicate and the
                    full node can be generated and submitted to the ledger so
                    that the ledger can safely deactivate the light client,
                    invalidate past state roots, and await higher-level
                    intervention.
                  </p>
                  <p
                    style="
                      padding-top: 9pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The validity of the validity predicate is dependent on the
                    security model of the consensus algorithm. For example, the
                    consensus algorithm could be BFT proof-of-authority with a
                    trusted operator set, or BFT proof-of-stake with a
                    tokenholder set, each of which have a defined threshold
                    above which Byzantine behaviour may result in divergence.
                  </p>
                  <p
                    style="
                      padding-top: 9pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark25"
                      >Clients may have time-sensitive validity predicates, such
                      that if no header is provided for a period of time (e.g.
                      an unbonding period of three weeks in a proof-of-stake
                      system) it will no longer be possible to update the
                      client.</a
                    >
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 9pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    State verification
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark26"
                      >Client types must define functions to authenticate
                      internal state of the ledger which the client tracks.
                      Internal imple- mentation details may differ (for example,
                      a loopback client could simply read directly from the
                      state and require no proofs). Externally-facing clients
                      will likely verify signature or vector commitment
                      proofs.</a
                    >
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 9pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Example client instantiations
                  </p>
                  <ol id="l8">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 8pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Loopback
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        A loopback client of a local ledger merely reads from
                        the local state, to which it must have access. This is
                        analogous to <span class="s5">localhost </span>or
                        <span class="s5">127.0.0.1 </span>in TCP/IP.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 5pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: justify;
                        "
                      >
                        Simple signatures
                      </p>
                      <p
                        style="
                          padding-top: 5pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        A client of a solo machine running a non-replicated
                        ledger with a known public key checks signatures on
                        messages sent by that local machine. Multi-signature or
                        threshold signature schemes can also be used in such a
                        fashion.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Proxy clients
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 7pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Proxy clients verify another (proxy) ledger’s
                        verification of the target ledger, by including in the
                        proof first a proof of the client state on the proxy
                        ledger, and then a secondary proof of the sub-state of
                        the target ledger with respect to the client state on
                        the proxy ledger. This allows the proxy client to avoid
                        storing and tracking the consensus state of the target
                        ledger itself, at the cost of adding security
                        assumptions of proxy ledger correctness.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        BFT consensus and verifiable state
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 7pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        For the immediate application of interoperability
                        between sovereign, fault-tolerant distributed ledgers,
                        the most common and most useful client type will be
                        light clients for instances of BFT consensus algorithms
                        such as Tendermint [8], GRANDPA [9], or HotStuff [10],
                        with ledgers utilising Merklized state trees such as an
                        IAVL+ tree [11] or a Merkle Patricia tree [12]. The
                        client algorithm for such instances will utilise the BFT
                        consensus algorithm’s light client validity predicate
                        and treat at minimum consensus equivocation
                        (double-signing) as misbehaviour, along with other
                        possible misbehaviour types specific to the proof-of-
                        authority or proof-of-stake system involved.
                      </p>
                    </li>
                  </ol>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark27">Client lifecycle</a>
                  </p>
                  <ol id="l9">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 8pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Creation
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 7pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Clients can be created permissionlessly by anyone at any
                        time by specifying an identifier, client type, and
                        initial consensus state.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Update
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Updating a client is done by submitting a new header.
                        When a new header is verified with the stored client
                        state’s validity predicate and consensus state, the
                        client will update its internal state accordingly,
                        possibly finalising commitment roots and updating the
                        signature authority logic in the stored consensus state.
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        If a client can no longer be updated (if, for example,
                        the unbonding period has passed), it will no longer be
                        possible to send any packets over connections and
                        channels associated with that client, or timeout any
                        packets in- flight (since the height and timestamp on
                        the destination ledger can no longer be verified).
                        Manual intervention must take place to reset the client
                        state or migrate the connections and channels to another
                        client. This cannot safely be done automatically, but
                        ledgers implementing IBC could elect to allow governance
                        mechanisms to perform these actions (perhaps even
                        per-client/connection/channel with a controlling
                        multi-signature or contract).
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 5pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: justify;
                        "
                      >
                        Misbehaviour
                      </p>
                    </li>
                  </ol>
                </li>
              </ol>
              <p
                style="
                  padding-top: 7pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                If the client detects evidence of misbehaviour, the client can
                be take appropriate action, possibly invalidating previously
                valid commitment roots and preventing future updates. What
                precisely constitutes misbehaviour will depend on the consensus
                algorithm which the validity predicate is validating the output
                of.
              </p>
            </li>
            <li>
              <p
                style="
                  padding-top: 12pt;
                  padding-left: 23pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                <a name="bookmark28">Connections</a>
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The <i>connection </i>abstraction encapsulates two stateful
                objects (<i>connection ends</i>) on two separate ledgers, each
                associated with a light client of the other ledger, which
                together facilitate cross-ledger sub-state verification and
                packet relay (through channels). Connections are safely
                established in an unknown, dynamic topology using a handshake
                subprotocol.
              </p>
              <ol id="l10">
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark29">Motivation</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The IBC protocol provides <i>authorisation </i>and
                    <i>ordering </i>semantics for packets: guarantees,
                    respectively, that packets have been committed on the
                    sending ledger (and according state transitions executed,
                    such as escrowing tokens), and that they have been committed
                    exactly once in a particular order and can be delivered
                    exactly once in that same order. The
                    <i>connection </i>abstraction in conjunction with the
                    <i>client </i>abstraction defines the
                    <i>authorisation </i>semantics of IBC. Ordering semantics
                    are provided by channels.
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark30">Definitions</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>connection end </i>is state tracked for an end of a
                    connection on one ledger, defined as follows:
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-top: 8pt;
                      padding-left: 17pt;
                      text-indent: -10pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    enum ConnectionState { INIT<span style="color: #666"
                      >,</span
                    >
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 17pt;
                      text-indent: 0pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    TRYOPEN<span style="color: #666">, </span>OPEN<span
                      style="color: #666"
                      >,</span
                    >
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 6pt;
                      text-indent: 0pt;
                      line-height: 11pt;
                      text-align: left;
                    "
                  >
                    }
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-top: 8pt;
                      padding-left: 17pt;
                      text-indent: -10pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    interface ConnectionEnd { state<span style="color: #666"
                      >: </span
                    >ConnectionState
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 17pt;
                      text-indent: 0pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    counterpartyConnectionIdentifier<span style="color: #666"
                      >: </span
                    >Identifier counterpartyPrefix<span style="color: #666"
                      >: </span
                    >CommitmentPrefix clientIdentifier<span style="color: #666"
                      >: </span
                    >Identifier counterpartyClientIdentifier<span
                      style="color: #666"
                      >: </span
                    >Identifier version<span style="color: #666">: </span
                    ><span style="color: #8e2100">string</span>
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 6pt;
                      text-indent: 0pt;
                      line-height: 11pt;
                      text-align: left;
                    "
                  >
                    }
                  </p>
                  <ul id="l11">
                    <li>
                      <p
                        style="
                          padding-top: 10pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">state </span>field describes the
                        current state of the connection end.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The
                        <span class="s5">counterpartyConnectionIdentifier </span
                        >field iden- tifies the connection end on the
                        counterparty ledger associated with this connection.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">counterpartyPrefix </span>field
                        contains the prefix used for state verification on the
                        counterparty ledger associated with this connection.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-top: 5pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">clientIdentifier </span>field
                        identifies the client asso- ciated with this connection.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The
                        <span class="s5">counterpartyClientIdentifier </span
                        >field identifies the client on the counterparty ledger
                        associated with this connection.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">version </span>field is an opaque
                        string which can be utilised to determine encodings or
                        protocols for channels or packets utilising this
                        connection.
                      </p>
                    </li>
                  </ul>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 11pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark31">Opening handshake</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The opening handshake subprotocol allows each ledger to
                    verify the identifier used to reference the connection on
                    the other ledger, enabling modules on each ledger to reason
                    about the reference on the other ledger.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The opening handshake consists of four datagrams:
                    <span class="s5">ConnOpenInit</span>,
                    <span class="s5">ConnOpenTry</span>,
                    <span class="s5">ConnOpenAck</span>, and
                    <span class="s5">ConnOpenConfirm</span>.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A correct protocol execution, between two ledgers
                    <span class="s5">A </span>and <span class="s5">B</span>,
                    with connection states formatted as
                    <span class="s5">(A, B)</span>, flows as follows:
                  </p>
                  <p style="text-indent: 0pt; text-align: left"><br /></p>
                  <table
                    style="border-collapse: collapse; margin-left: 6.835pt"
                    cellspacing="0"
                  >
                    <tr style="height: 17pt">
                      <td
                        style="
                          width: 84pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s8"
                          style="
                            padding-top: 1pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          Datagram
                        </p>
                      </td>
                      <td
                        style="
                          width: 91pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s8"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          Prior state
                        </p>
                      </td>
                      <td
                        style="
                          width: 84pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s8"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          Posterior state
                        </p>
                      </td>
                    </tr>
                    <tr style="height: 14pt">
                      <td
                        style="
                          width: 84pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 2pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          ConnOpenInit
                        </p>
                      </td>
                      <td
                        style="
                          width: 91pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 2pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (-, -)
                        </p>
                      </td>
                      <td
                        style="
                          width: 84pt;
                          border-top-style: solid;
                          border-top-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 2pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (INIT, -)
                        </p>
                      </td>
                    </tr>
                    <tr style="height: 12pt">
                      <td style="width: 84pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          ConnOpenTry
                        </p>
                      </td>
                      <td style="width: 91pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (INIT, none)
                        </p>
                      </td>
                      <td style="width: 84pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (INIT, TRYOPEN)
                        </p>
                      </td>
                    </tr>
                    <tr style="height: 12pt">
                      <td style="width: 84pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          ConnOpenAck
                        </p>
                      </td>
                      <td style="width: 91pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (INIT, TRYOPEN)
                        </p>
                      </td>
                      <td style="width: 84pt">
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            line-height: 10pt;
                            text-align: left;
                          "
                        >
                          (OPEN, TRYOPEN)
                        </p>
                      </td>
                    </tr>
                    <tr style="height: 15pt">
                      <td
                        style="
                          width: 84pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          ConnOpenConfirm
                        </p>
                      </td>
                      <td
                        style="
                          width: 91pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          (OPEN, TRYOPEN)
                        </p>
                      </td>
                      <td
                        style="
                          width: 84pt;
                          border-bottom-style: solid;
                          border-bottom-width: 1pt;
                        "
                      >
                        <p
                          class="s9"
                          style="
                            padding-top: 1pt;
                            padding-left: 5pt;
                            text-indent: 0pt;
                            text-align: left;
                          "
                        >
                          (OPEN, OPEN)
                        </p>
                      </td>
                    </tr>
                  </table>
                  <p
                    style="
                      padding-top: 3pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    At the end of an opening handshake between two ledgers
                    implementing the subprotocol, the following properties hold:
                  </p>
                  <ul id="l12">
                    <li>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Each ledger has each other’s correct consensus state as
                        originally specified by the initiating actor.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Each ledger has knowledge of and has agreed to its
                        identifier on the other ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Each ledger knows that the other ledger has agreed to
                        the same data.
                      </p>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Connection handshakes can safely be performed permis-
                        sionlessly, modulo anti-spam measures (paying gas).
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 6pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ConnOpenInit<span class="p"
                          >, executed on ledger A, initialises a connec- tion
                          attempt on ledger A, specifying a pair of identifiers
                          for the connection on both ledgers and a pair of
                          identifiers for existing light clients (one for each
                          ledger). ledger A stores a connection end object in
                          its state.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 6pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ConnOpenTry<span class="p"
                          >, executed on ledger B, relays notice of a connection
                          attempt on ledger A to ledger B, providing the pair of
                          connection identifiers, the pair of client
                          identifiers, and a desired version. Ledger B verifies
                          that these identifiers are valid, checks that the
                          version is compatible, verifies a proof that ledger A
                          has stored these identifiers, and verifies a proof
                          that the light client ledger A is using to validate
                          ledger B has the correct consensus state for ledger B.
                          ledger B stores a connection end object in its
                          state.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 5pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ConnOpenAck<span class="p"
                          >, executed on ledger A, relays acceptance of a
                          connection open attempt from ledger B back to ledger
                          A, providing the identifier which can now be used to
                          look up the connection end object. ledger A verifies
                          that the version requested is compatible, verifies a
                          proof that ledger B has stored the same identifiers
                          ledger A has stored, and verifies a proof that the
                          light client ledger B is using to validate ledger A
                          has the correct consensus state for ledger A.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 11pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        <a name="bookmark32">ConnOpenConfirm</a
                        ><span class="p"
                          >, executed on ledger B, confirms opening of a
                          connection on ledger A to ledger B. Ledger B simply
                          checks that ledger A has executed </span
                        >ConnOpenAck
                        <span class="p">and marked the connection as </span
                        >OPEN<span class="p"
                          >. Ledger B subsequently marks its end of the
                          connection as </span
                        >OPEN<span class="p">. After execution of </span
                        >ConnOpenConfirm
                        <span class="p"
                          >the connection is open on both ends and can be used
                          immediately.</span
                        >
                      </p>
                    </li>
                  </ul>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 10pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Versioning
                  </p>
                </li>
              </ol>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                During the handshake process, two ends of a connection come to
                agreement on a version bytestring associated with that
                connection. At the moment, the contents of this version
                bytestring are opaque to the IBC core protocol. In the future,
                it might be used to indicate what kinds of channels can utilise
                the connection in question, or what encoding formats
                channel-related datagrams will use. Host ledgers may utilise the
                version data to negotiate encodings, pri- orities, or
                connection-specific metadata related to custom logic on top of
                IBC. Host ledgers may also safely ignore the version data or
                specify an empty string.
              </p>
              <p style="text-indent: 0pt; text-align: left"><br /></p>
            </li>
            <li>
              <p
                style="padding-left: 23pt; text-indent: -16pt; text-align: left"
              >
                <a name="bookmark33">Channels</a>
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The <i>channel </i>abstraction provides message delivery seman-
                tics to the interblockchain communication protocol in three
                categories: ordering, exactly-once delivery, and module
                permissioning. A channel serves as a conduit for packets passing
                between a module on one ledger and a module on another, ensuring
                that packets are executed only once, delivered in the order in
                which they were sent (if necessary), and delivered only to the
                corresponding module owning the other end of the channel on the
                destination ledger. Each channel is associated with a particular
                connection, and a connection may have any number of associated
                channels, allowing the use of common identifiers and amortising
                the cost of header verification across all the channels
                utilising a connection and light client.
              </p>
              <p
                style="
                  padding-top: 11pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Channels are payload-agnostic. The modules which send and
                receive IBC packets decide how to construct packet data and how
                to act upon the incoming packet data, and must utilise their own
                application logic to determine which state transactions to apply
                according to what data the packet contains.
              </p>
              <ol id="l13">
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 5pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark34">Motivation</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The interblockchain communication protocol uses a cross-
                    ledger message passing model. IBC <i>packets </i>are relayed
                    from one ledger to the other by external relayer processes.
                    Two ledgers, A and B, confirm new blocks independently, and
                    packets from one ledger to the other may be delayed,
                    censored, or re-ordered arbitrarily. Packets are visible to
                    relayers and can be read from a ledger by any relayer
                    process and submitted to any other ledger.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The IBC protocol must provide ordering (for ordered
                    channels) and exactly-once delivery guarantees to allow ap-
                    plications to reason about the combined state of connected
                    modules on two ledgers. For example, an application may wish
                    to allow a single tokenised asset to be transferred between
                    and held on multiple ledgers while preserving fungibility
                    and conservation of supply. The application can mint asset
                    vouchers on ledger B when a particular IBC packet is
                    committed to ledger B, and require outgoing sends of that
                    packet on ledger A to escrow an equal amount of the asset on
                    ledger A until the vouchers are later redeemed back to
                    ledger A with an IBC packet in the reverse direction. This
                    ordering guarantee along with correct application logic can
                    ensure that total supply is preserved across both ledgers
                    and that any vouchers minted on ledger B can later be
                    redeemed back to ledger A. A more detailed explanation of
                    this example is provided later on.
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark35">Definitions</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>channel </i>is a pipeline for exactly-once packet
                    delivery between specific modules on separate ledgers, which
                    has at least one end capable of sending packets and one end
                    capable of receiving packets.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    An <i>ordered </i>channel is a channel where packets are
                    delivered exactly in the order which they were sent.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    An <i>unordered </i>channel is a channel where packets can
                    be delivered in any order, which may differ from the order
                    in which they were sent.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    All channels provide exactly-once packet delivery, meaning
                    that a packet sent on one end of a channel is delivered no
                    more and no less than once, eventually, to the other end.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    A <i>channel end </i>is a data structure storing metadata
                    associ- ated with one end of a channel on one of the
                    participating ledgers, defined as follows:
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-top: 8pt;
                      padding-left: 17pt;
                      text-indent: -10pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    interface ChannelEnd { state<span style="color: #666"
                      >: </span
                    >ChannelState ordering<span style="color: #666">: </span
                    >ChannelOrder
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 17pt;
                      text-indent: 0pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    counterpartyPortIdentifier<span style="color: #666">: </span
                    >Identifier counterpartyChannelIdentifier<span
                      style="color: #666"
                      >: </span
                    >Identifier nextSequenceSend<span style="color: #666"
                      >: </span
                    >uint64 nextSequenceRecv<span style="color: #666">: </span
                    >uint64 nextSequenceAck<span style="color: #666">: </span
                    >uint64
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-top: 5pt;
                      padding-left: 17pt;
                      text-indent: 0pt;
                      line-height: 106%;
                      text-align: left;
                    "
                  >
                    connectionHops<span style="color: #666">: </span
                    >[Identifier] version<span style="color: #666">: </span
                    ><span style="color: #8e2100">string</span>
                  </p>
                  <p
                    class="s5"
                    style="
                      padding-left: 6pt;
                      text-indent: 0pt;
                      line-height: 11pt;
                      text-align: left;
                    "
                  >
                    }
                  </p>
                  <ul id="l14">
                    <li>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          line-height: 12pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">state </span>is the current state
                        of the channel end.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">ordering </span>field indicates
                        whether the channel is ordered or unordered. This is an
                        enumeration instead of a boolean in order to allow
                        additional kinds of ordering to be easily supported in
                        the future.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The
                        <span class="s5">counterpartyPortIdentifier </span
                        >identifies the port on the counterparty ledger which
                        owns the other end of the channel.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The
                        <span class="s5">counterpartyChannelIdentifier </span
                        >identifies the channel end on the counterparty ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">nextSequenceSend</span>, stored
                        separately, tracks the sequence number for the next
                        packet to be sent.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">nextSequenceRecv</span>, stored
                        separately, tracks the sequence number for the next
                        packet to be received.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">nextSequenceAck</span>, stored
                        separately, tracks the sequence number for the next
                        packet to be acknowl- edged.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">connectionHops </span>stores the
                        list of connection identifiers, in order, along which
                        packets sent on this channel will travel. At the moment
                        this list must be of length 1. In the future multi-hop
                        channels may be supported.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -9pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">version </span>string stores an
                        opaque channel version, which is agreed upon during the
                        handshake. This can determine module-level configuration
                        such as which packet encoding is used for the channel.
                        This version is not used by the core IBC protocol.
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Channel ends have a <i>state</i>:
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 7pt;
                          padding-left: 17pt;
                          text-indent: -10pt;
                          line-height: 106%;
                          text-align: left;
                        "
                      >
                        enum ChannelState { INIT<span style="color: #666"
                          >,</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 17pt;
                          text-indent: 0pt;
                          line-height: 106%;
                          text-align: left;
                        "
                      >
                        TRYOPEN<span style="color: #666">, </span>OPEN<span
                          style="color: #666"
                          >, </span
                        >CLOSED<span style="color: #666">,</span>
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 11pt;
                          text-align: left;
                        "
                      >
                        }
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        A channel end in <span class="s5">INIT </span>state has
                        just started the opening handshake.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        A channel end in <span class="s5">TRYOPEN </span>state
                        has acknowledged the handshake step on the counterparty
                        ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        A channel end in <span class="s5">OPEN </span>state has
                        completed the handshake and is ready to send and receive
                        packets.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        A channel end in <span class="s5">CLOSED </span>state
                        has been closed and can no longer be used to send or
                        receive packets.
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        A <span class="s5">Packet</span>, encapsulating opaque
                        data to be transferred from one module to another over a
                        channel, is a particular interface defined as follows:
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 8pt;
                          padding-left: 17pt;
                          text-indent: -10pt;
                          line-height: 106%;
                          text-align: left;
                        "
                      >
                        interface Packet { sequence<span style="color: #666"
                          >: </span
                        >uint64 timeoutHeight<span style="color: #666">: </span
                        >uint64 timeoutTimestamp<span style="color: #666"
                          >: </span
                        >uint64
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 5pt;
                          padding-left: 17pt;
                          text-indent: 0pt;
                          line-height: 106%;
                          text-align: left;
                        "
                      >
                        sourcePort<span style="color: #666">: </span>Identifier
                        sourceChannel<span style="color: #666">: </span
                        >Identifier destPort<span style="color: #666">: </span
                        >Identifier destChannel<span style="color: #666"
                          >: </span
                        >Identifier data<span style="color: #666">: </span>bytes
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 11pt;
                          text-align: left;
                        "
                      >
                        }
                      </p>
                      <p style="text-indent: 0pt; text-align: left"><br /></p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">sequence </span>number corresponds
                        to the order of sends and receives, where a packet with
                        an earlier sequence number must be sent and received
                        before a packet with a later sequence number.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">timeoutHeight </span>indicates a
                        consensus height on the destination ledger after which
                        the packet will no longer be processed, and will instead
                        count as having timed-out.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">timeoutTimestamp </span>indicates a
                        timestamp on the destination ledger after which the
                        packet will no longer be processed, and will instead
                        count as having timed- out.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">sourcePort </span>identifies the
                        port on the sending ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">sourceChannel </span>identifies the
                        channel end on the sending ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">destPort </span>identifies the port
                        on the receiving ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">destChannel </span>identifies the
                        channel end on the receiving ledger.
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">data </span>is an opaque value
                        which can be defined by the application logic of the
                        associated modules.
                      </p>
                    </li>
                  </ul>
                  <p style="text-indent: 0pt; text-align: left"><br /></p>
                  <p
                    style="
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark36">Note that a </a
                    ><span class="s5">Packet </span>is never directly
                    serialised. Rather it is an intermediary structure used in
                    certain function calls that may need to be created or
                    processed by modules calling the IBC handler.
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 9pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Properties
                  </p>
                  <ol id="l15">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 8pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Efficiency
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        As channels impose no flow control of their own, the
                        speed of packet transmission and confirmation is limited
                        only by the speed of the underlying ledgers.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Exactly-once delivery
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        IBC packets sent on one end of a channel are delivered
                        no more than exactly once to the other end. No network
                        synchrony assumptions are required for exactly-once
                        safety. If one or both of the ledgers halt, packets may
                        be delivered no more than once, and once the ledgers
                        resume packets will be able to flow again.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Ordering
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        On ordered channels, packets are be sent and received in
                        the same order: if packet <span class="s5">x </span>is
                        sent before packet <span class="s5">y </span>by a
                        channel end on ledger A, packet
                        <span class="s5">x </span>will be received before packet
                        <span class="s5">y </span>by the corresponding channel
                        end on ledger B.
                      </p>
                      <p
                        style="
                          padding-top: 5pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        On unordered channels, packets may be sent and received
                        in any order. Unordered packets, like ordered packets,
                        have individual timeouts specified in terms of the
                        destination ledger’s height or timestamp.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Permissioning
                      </p>
                      <p
                        style="
                          padding-top: 6pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        <a name="bookmark37"
                          >Channels are permissioned to one module on each end,
                          determined during the handshake and immutable after-
                          wards (higher-level logic could tokenise channel
                          ownership by tokenising ownership of the port). Only
                          the module which owns the port associated with a
                          channel end is able to send or receive on the
                          channel.</a
                        >
                      </p>
                    </li>
                  </ol>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    Channel lifecycle management
                  </p>
                  <ol id="l16">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 8pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Opening handshake
                      </p>
                      <p
                        style="
                          padding-top: 6pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 12pt;
                          text-align: justify;
                        "
                      >
                        The channel opening handshake, between two ledgers
                        <span class="s5">A</span>
                      </p>
                      <p style="text-indent: 0pt; text-align: left">
                        <span
                          ><img
                            width="346"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_001.png"
                        /></span>
                      </p>
                      <p style="text-indent: 0pt; text-align: left">
                        <span
                          ><img
                            width="346"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_002.png"
                        /></span>
                      </p>
                      <p
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 168%;
                          text-align: left;
                        "
                      >
                        and <span class="s5">B</span>, with state formatted as
                        <span class="s5">(A, B)</span>, flows as follows:
                        Datagram Prior state Posterior state
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 10pt;
                          text-align: left;
                        "
                      >
                        ChanOpenInit (-, -) (INIT, -)
                      </p>
                      <p
                        style="
                          padding-top: 5pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        module which it specifies will own the other end of the
                        created channel on the counterparty ledger. Once a
                        channel is created, ownership can only be changed by
                        changing ownership of the associated ports.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 15pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Versioning
                      </p>
                      <p
                        style="
                          padding-top: 6pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        During the handshake process, two ends of a channel come
                        to agreement on a version bytestring associated with
                        that channel. The contents of this version bytestring
                        are opaque to the IBC core protocol. Host ledgers may
                        utilise the version data to indicate supported
                        application-layer protocols, agree on packet encoding
                        formats, or negotiate other channel-related metadata
                        related to custom logic on top of IBC. Host ledgers may
                        also safely ignore the version data or specify an empty
                        string.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 15pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Closing handshake
                      </p>
                      <p
                        style="
                          padding-top: 6pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          line-height: 12pt;
                          text-align: justify;
                        "
                      >
                        The channel closing handshake, between two ledgers
                        <span class="s5">A </span>and
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 1pt;
                          text-indent: 0pt;
                          line-height: 12pt;
                          text-align: justify;
                        "
                      >
                        B<span class="p">, with state formatted as </span>(A,
                        B)<span class="p">, flows as follows:</span>
                      </p>
                      <p style="text-indent: 0pt; text-align: left"><br /></p>
                      <p
                        style="
                          padding-left: 1pt;
                          text-indent: 0pt;
                          line-height: 1pt;
                          text-align: left;
                        "
                      >
                        <span
                          ><img
                            width="328"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_003.png"
                        /></span>
                      </p>
                      <p
                        style="
                          padding-top: 1pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Datagram Prior state Posterior state
                      </p>
                      <p style="text-indent: 0pt; text-align: left"><br /></p>
                      <p
                        style="
                          padding-left: 269pt;
                          text-indent: 0pt;
                          line-height: 1pt;
                          text-align: left;
                        "
                      >
                        <span
                          ><img
                            width="330"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_004.png"
                        /></span>
                      </p>
                      <p style="text-indent: 0pt; text-align: left">
                        <span
                          ><img
                            width="332"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_005.png"
                        /></span>
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 81%;
                          text-align: left;
                        "
                      >
                        <span class="s10"
                          >ChanOpenTry (INIT, -) (INIT, TRYOPEN) </span
                        >ChanCloseInit
                        <span class="s11">(OPEN, OPEN) (CLOSED, OPEN) </span
                        ><span class="s10"
                          >ChanOpenAck (INIT, TRYOPEN) (OPEN, TRYOPEN) </span
                        >ChanCloseConfirm
                        <span class="s11">(CLOSED, OPEN) (CLOSED, CLOSED) </span
                        >ChanOpenConfirm (OPEN, TRYOPEN) (OPEN, OPEN)
                      </p>
                      <p style="text-indent: 0pt; text-align: left"><br /></p>
                      <p
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          line-height: 1pt;
                          text-align: left;
                        "
                      >
                        <span
                          ><img
                            width="346"
                            height="1"
                            alt="image"
                            src="OverviewPaper_files/Image_006.png"
                        /></span>
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 4pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanOpenInit<span class="p"
                          >, executed on ledger A, initiates a channel opening
                          handshake from a module on ledger A to a module on
                          ledger B, providing the identifiers of the local
                          channel identifier, local port, remote port, and
                          remote channel identifier. ledger A stores a channel
                          end object in its state.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanOpenTry<span class="p"
                          >, executed on ledger B, relays notice of a channel
                          handshake attempt to the module on ledger B, providing
                          the pair of channel identifiers, a pair of port
                          identifiers, and a desired version. ledger B verifies
                          a proof that ledger A has stored these identifiers as
                          claimed, looks up the module which owns the
                          destination port, calls that module to check that the
                          version requested is compatible, and stores a channel
                          end object in its state.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 6pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanOpenAck<span class="p"
                          >, executed on ledger A, relays acceptance of a
                          channel handshake attempt back to the module on ledger
                          A, providing the identifier which can now be used to
                          look up the channel end. ledger A verifies a proof
                          that ledger B has stored the channel metadata as
                          claimed and marks its end of the channel as </span
                        >OPEN<span class="p">.</span>
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 5pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanOpenConfirm<span class="p"
                          >, executed on ledger B, confirms open- ing of a
                          channel from ledger A to ledger B. Ledger B simply
                          checks that ledger A has executed </span
                        >ChanOpenAck
                        <span class="p">and marked the channel as </span
                        >OPEN<span class="p"
                          >. Ledger B subsequently marks its end of the channel
                          as </span
                        >OPEN<span class="p">. After execution of </span
                        >ChanOpenConfirm<span class="p"
                          >, the channel is open on both ends and can be used
                          immediately.</span
                        >
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        When the opening handshake is complete, the module which
                        initiates the handshake will own the end of the created
                        channel on the host ledger, and the counterparty
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanCloseInit<span class="p"
                          >, executed on ledger A, closes the end of the channel
                          on ledger A.</span
                        >
                      </p>
                      <p
                        class="s5"
                        style="
                          padding-top: 7pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        ChanCloseInit<span class="p"
                          >, executed on ledger B, simply verifies that the
                          channel has been marked as closed on ledger A and
                          closes the end on ledger B.</span
                        >
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Any in-flight packets can be timed-out as soon as a
                        channel is closed.
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 1pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Once closed, channels cannot be reopened and identifiers
                        cannot be reused. Identifier reuse is prevented because
                        we want to prevent potential replay of previously sent
                        packets. The replay problem is analogous to using
                        sequence numbers with signed messages, except where the
                        light client algorithm “signs” the messages (IBC
                        packets), and the replay prevention sequence is the
                        combination of port identifier, channel identifier, and
                        packet sequence — hence we cannot allow the same port
                        identifier and channel identifier to be reused again
                        with a sequence reset to zero, since this might allow
                        packets to be replayed. It would be possible to safely
                        reuse identifiers if timeouts of a particular maximum
                        height/time were mandated and tracked, and future
                        protocol versions may incorporate this feature.
                      </p>
                    </li>
                  </ol>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 15pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark38">Sending packets</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 1pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The <span class="s5">sendPacket </span>function is called by
                    a module in order to send an IBC packet on a channel end
                    owned by the calling module to the corresponding module on
                    the counterparty ledger.
                  </p>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 1pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Calling modules must execute application logic atomically in
                    conjunction with calling <span class="s5">sendPacket</span>.
                  </p>
                  <p
                    style="
                      padding-top: 5pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The IBC handler performs the following steps in order:
                  </p>
                  <ul id="l17">
                    <li>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Checks that the channel and connection are open to send
                        packets
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Checks that the calling module owns the sending port
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Checks that the packet metadata matches the channel and
                        connection information
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Checks that the timeout height specified has not already
                        passed on the destination ledger
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Increments the send sequence counter associated with the
                        channel (in the case of ordered channels)
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: left;
                        "
                      >
                        Stores a constant-size commitment to the packet data and
                        packet timeout
                      </p>
                    </li>
                  </ul>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Note that the full packet is not stored in the state of the
                    ledger — merely a short hash-commitment to the data and
                    timeout value. The packet data can be calculated from the
                    transaction execution and possibly returned as log output
                    which relayers can index.
                  </p>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 8pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark39">Receiving packets</a>
                  </p>
                  <p
                    style="
                      padding-top: 9pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The <span class="s5">recvPacket </span>function is called by
                    a module in order to receive and process an IBC packet sent
                    on the corre- sponding channel end on the counterparty
                    ledger.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Calling modules must execute application logic atomically in
                    conjunction with calling <span class="s5">recvPacket</span>,
                    likely beforehand to calculate the acknowledgement value.
                  </p>
                  <p
                    style="
                      padding-top: 6pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    The IBC handler performs the following steps in order:
                  </p>
                  <ul id="l18">
                    <li>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Checks that the channel and connection are open to
                        receive packets
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Checks that the calling module owns the receiving port
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Checks that the packet metadata matches the channel and
                        connection information
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Checks that the packet sequence is the next sequence the
                        channel end expects to receive (for ordered chan- nels)
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          line-height: 12pt;
                          text-align: justify;
                        "
                      >
                        Checks that the timeout height has not yet passed
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Checks the inclusion proof of packet data commitment in
                        the outgoing ledger’s state
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Sets the opaque acknowledgement value at a store path
                        unique to the packet (if the acknowledgement is
                        non-empty or the channel is unordered)
                      </p>
                    </li>
                    <li>
                      <p
                        style="
                          padding-left: 26pt;
                          text-indent: -10pt;
                          text-align: justify;
                        "
                      >
                        Increments the packet receive sequence associated with
                        the channel end (for ordered channels)
                      </p>
                    </li>
                  </ul>
                  <ol id="l19">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 7pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Acknowledgements
                      </p>
                      <p style="text-indent: 0pt; text-align: left"><br /></p>
                      <p
                        style="
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">acknowledgePacket </span>function
                        is called by a module to process the acknowledgement of
                        a packet previously sent by the calling module on a
                        channel to a counterparty module on the counterparty
                        ledger. <span class="s5">acknowledgePacket </span>also
                        cleans up the packet commitment, which is no longer
                        necessary since the packet has been received and acted
                        upon.
                      </p>
                      <p
                        style="
                          padding-top: 5pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Calling modules may atomically execute appropriate ap-
                        plication acknowledgement-handling logic in conjunction
                        with calling <span class="s5">acknowledgePacket</span>.
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        The IBC handler performs the following steps in order:
                      </p>
                      <ul id="l20">
                        <li>
                          <p
                            style="
                              padding-top: 12pt;
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the channel and connection are open to
                            acknowledge packets
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the calling module owns the sending port
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the packet metadata matches the channel
                            and connection information
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the packet was actually sent on this
                            channel
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the packet sequence is the next sequence
                            the channel end expects to acknowledge (for ordered
                            channels)
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks the inclusion proof of the packet
                            acknowledge- ment data in the receiving ledger’s
                            state
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Deletes the packet commitment (cleaning up state and
                            preventing replay)
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Increments the next acknowledgement sequence (for
                            ordered channels)
                          </p>
                        </li>
                      </ul>
                    </li>
                  </ol>
                </li>
                <li>
                  <p
                    class="s4"
                    style="
                      padding-top: 12pt;
                      padding-left: 21pt;
                      text-indent: -14pt;
                      text-align: left;
                    "
                  >
                    <a name="bookmark40">Timeouts</a>
                  </p>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    Application semantics may require some timeout: an upper
                    limit to how long the ledger will wait for a transaction to
                    be processed before considering it an error. Since the two
                    ledgers have different local clocks, this is an obvious
                    attack vector for a double spend — an attacker may delay the
                    relay of the receipt or wait to send the packet until right
                    after the timeout — so applications cannot safely implement
                    naive timeout logic themselves. In order to avoid any
                    possible “double-spend” attacks, the timeout algorithm
                    requires that the destination ledger is running and
                    reachable. The timeout must be proven on the recipient
                    ledger, not simply the absence of a response on the sending
                    ledger.
                  </p>
                  <ol id="l21">
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 21pt;
                          text-indent: -14pt;
                          text-align: left;
                        "
                      >
                        Sending end
                      </p>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        The <span class="s5">timeoutPacket </span>function is
                        called by a module which originally attempted to send a
                        packet to a counterparty module, where the timeout
                        height or timeout timestamp has passed on the
                        counterparty ledger without the packet being committed,
                        to prove that the packet can no longer be executed and
                        to allow the calling module to safely perform
                        appropriate state transitions.
                      </p>
                      <p
                        style="
                          padding-top: 8pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        Calling modules may atomically execute appropriate
                        appli- cation timeout-handling logic in conjunction with
                        calling
                        <span class="s5">timeoutPacket</span>.
                      </p>
                      <p
                        style="
                          padding-top: 7pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        The IBC handler performs the following steps in order:
                      </p>
                      <ul id="l22">
                        <li>
                          <p
                            style="
                              padding-top: 12pt;
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the channel and connection are open to
                            timeout packets
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 27pt;
                              text-indent: -10pt;
                              text-align: justify;
                            "
                          >
                            Checks that the calling module owns the sending port
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-top: 5pt;
                              padding-left: 26pt;
                              text-indent: -10pt;
                              text-align: left;
                            "
                          >
                            Checks that the packet metadata matches the channel
                            and connection information
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 26pt;
                              text-indent: -10pt;
                              text-align: left;
                            "
                          >
                            Checks that the packet was actually sent on this
                            channel
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 26pt;
                              text-indent: -10pt;
                              text-align: left;
                            "
                          >
                            Checks a proof that the packet has not been
                            confirmed on the destination ledger
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 26pt;
                              text-indent: -10pt;
                              text-align: left;
                            "
                          >
                            Checks a proof that the destination ledger has ex-
                            ceeded the timeout height or timestamp
                          </p>
                        </li>
                        <li>
                          <p
                            style="
                              padding-left: 26pt;
                              text-indent: -10pt;
                              text-align: left;
                            "
                          >
                            Deletes the packet commitment (cleaning up state and
                            preventing replay)
                          </p>
                          <p style="text-indent: 0pt; text-align: left">
                            <br />
                          </p>
                          <p
                            style="
                              padding-left: 6pt;
                              text-indent: 0pt;
                              text-align: justify;
                            "
                          >
                            In the case of an ordered channel,
                            <span class="s5">timeoutPacket </span>addition- ally
                            closes the channel if a packet has timed out.
                            Unordered channels are expected to continue in the
                            face of timed-out packets.
                          </p>
                          <p
                            style="
                              padding-top: 9pt;
                              padding-left: 6pt;
                              text-indent: 0pt;
                              text-align: justify;
                            "
                          >
                            If relations are enforced between timeout heights of
                            subse- quent packets, safe bulk timeouts of all
                            packets prior to a timed-out packet can be
                            performed.
                          </p>
                        </li>
                      </ul>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Timing-out on close
                      </p>
                      <p
                        style="
                          padding-top: 9pt;
                          padding-left: 6pt;
                          text-indent: 0pt;
                          text-align: justify;
                        "
                      >
                        If a channel is closed, in-flight packets can never be
                        received and thus can be safely timed-out. The
                        <span class="s5">timeoutOnClose </span>function is
                        called by a module in order to prove that the channel to
                        which an unreceived packet was addressed has been
                        closed, so the packet will never be received (even if
                        the <span class="s5">timeoutHeight </span>or
                        <span class="s5">timeoutTimestamp </span>has not yet
                        been reached). Appropriate application-specific logic
                        may then safely be executed.
                      </p>
                    </li>
                    <li>
                      <p
                        class="s4"
                        style="
                          padding-top: 6pt;
                          padding-left: 20pt;
                          text-indent: -13pt;
                          text-align: left;
                        "
                      >
                        Cleaning up state
                      </p>
                    </li>
                  </ol>
                </li>
              </ol>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 5pt;
                  text-indent: 1pt;
                  text-align: justify;
                "
              >
                If an acknowledgement is not written (as handling the
                acknowledgement would clean up state in that case),
                <span class="s5">cleanupPacket </span>may be called by a module
                in order to remove a received packet commitment from storage.
                The receiving end must have already processed the packet
                (whether regularly or past timeout).
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                In the ordered channel case,
                <span class="s5">cleanupPacket </span>cleans-up a packet on an
                ordered channel by proving that the receive sequence has passed
                the packet’s sequence on the other end.
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                In the unordered channel case,
                <span class="s5">cleanupPacket </span>cleans-up a packet on an
                unordered channel by proving that the associated acknowledgement
                has been written.
              </p>
              <p style="text-indent: 0pt; text-align: left"><br /></p>
            </li>
            <li>
              <p
                style="padding-left: 23pt; text-indent: -17pt; text-align: left"
              >
                <a name="bookmark41">Relayers</a>
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Relayer algorithms are the “physical” connection layer of IBC —
            off-ledger processes responsible for relaying data between two
            ledgers running the IBC protocol by scanning the state of each
            ledger, constructing appropriate datagrams, and executing them on
            the opposite ledger as allowed by the protocol.
          </p>
          <ol id="l23">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 5pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark42">Motivation</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 5pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                In the IBC protocol, one ledger can only record the intention to
                send particular data to another ledger — it does not have direct
                access to a network transport layer. Physical datagram relay
                must be performed by off-ledger infrastructure with access to a
                transport layer such as TCP/IP. This standard defines the
                concept of a <i>relayer </i>algorithm, executable by an
                off-ledger process with the ability to query ledger state, to
                perform this relay.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                A <i>relayer </i>is an off-ledger process with the ability to
                read the state of and submit transactions to some set of ledgers
                utilising the IBC protocol.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark43">Properties</a>
              </p>
              <ul id="l24">
                <li>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    No exactly-once or deliver-or-timeout safety proper- ties of
                    IBC depend on relayer behaviour (Byzantine relayers are
                    assumed)
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Packet relay liveness properties of IBC depend only on the
                    existence of at least one correct, live relayer
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 25pt;
                      text-indent: -9pt;
                      text-align: justify;
                    "
                  >
                    Relaying can safely be permissionless, all requisite
                    verification is performed by the ledger itself
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Requisite communication between the IBC user and the relayer
                    is minimised
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Provision for relayer incentivisation are not included in
                    the core protocol, but are possible at the application layer
                  </p>
                </li>
              </ul>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 9pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark44">Basic relayer algorithm</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The relayer algorithm is defined over a set of ledgers imple-
                menting the IBC protocol. Each relayer may not necessarily have
                access to read state from and write datagrams to all ledgers in
                the multi-ledger network (especially in the case of permissioned
                or private ledgers) — different relayers may relay between
                different subsets.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Every so often, although no more frequently than once per block
                on either ledger, a relayer calculates the set of all valid
                datagrams to be relayed from one ledger to another based on the
                state of both ledgers. The relayer must possess prior knowledge
                of what subset of the IBC protocol is implemented by the ledgers
                in the set for which they are relaying (e.g. by reading the
                source code). Datagrams can be submitted individually as single
                transactions or atomically as a single transaction if the ledger
                supports it.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Different relayers may relay between different ledgers — as long
                as each pair of ledgers has at least one correct and live
                relayer and the ledgers remain live, all packets flowing between
                ledgers in the network will eventually be relayed.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark45">Packets, acknowledgements, timeouts</a>
              </p>
            </li>
          </ol>
          <ol id="l25">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Relaying packets in an ordered channel
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Packets in an ordered channel can be relayed in either an
                event-based fashion or a query-based fashion. For the
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                former, the relayer should watch the source ledger for events
                emitted whenever packets are sent, then compose the packet using
                the data in the event log. For the latter, the relayer should
                periodically query the send sequence on the source ledger, and
                keep the last sequence number relayed, so that any sequences in
                between the two are packets that need to be queried and then
                relayed. In either case, subsequently, the relayer process
                should check that the destination ledger has not yet received
                the packet by checking the receive sequence, and then relay it.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 20pt;
                  text-indent: -13pt;
                  text-align: left;
                "
              >
                Relaying packets in an unordered channel
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Packets in an unordered channel can most easily be relayed in an
                event-based fashion. The relayer should watch the source ledger
                for events emitted whenever packets are send, then compose the
                packet using the data in the event log. Subsequently, the
                relayer should check whether the destination ledger has received
                the packet already by querying for the presence of an
                acknowledgement at the packet’s sequence number, and if one is
                not yet present the relayer should relay the packet.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 20pt;
                  text-indent: -13pt;
                  text-align: left;
                "
              >
                Relaying acknowledgements
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Acknowledgements can most easily be relayed in an event- based
                fashion. The relayer should watch the destination ledger for
                events emitted whenever packets are received and
                acknowledgements are written, then compose the acknowledgement
                using the data in the event log, check whether the packet
                commitment still exists on the source ledger (it will be deleted
                once the acknowledgement is relayed), and if so relay the
                acknowledgement to the source ledger.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Relaying timeouts
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Timeout relay is slightly more complex since there is no
                specific event emitted when a packet times-out — it is simply
                the case that the packet can no longer be relayed, since the
                timeout height or timestamp has passed on the destination
                ledger. The relayer process must elect to track a set of packets
                (which can be constructed by scanning event logs), and as soon
                as the height or timestamp of the destination ledger exceeds
                that of a tracked packet, check whether the packet commitment
                still exists on the source ledger (it will be deleted once the
                timeout is relayed), and if so relay a timeout to the source
                ledger.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 20pt;
                  text-indent: -13pt;
                  text-align: left;
                "
              >
                Ordering constraints
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                There are implicit ordering constraints imposed on the relayer
                process determining which datagrams must be submitted in what
                order. For example, a header must be submitted to finalise the
                stored consensus state and commitment root for a particular
                height in a light client before a packet can be relayed. The
                relayer process is responsible for frequently querying the state
                of the ledgers between which they are relaying in order to
                determine what must be relayed when.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 5pt;
                  padding-left: 19pt;
                  text-indent: -12pt;
                  text-align: justify;
                "
              >
                Bundling
              </p>
              <p
                style="
                  padding-top: 7pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                If the host ledger supports it, the relayer process can bundle
                many datagrams into a single transaction, which will cause them
                to be executed in sequence, and amortise any overhead costs
                (e.g. signature checks for fee payment).
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 20pt;
                  text-indent: -13pt;
                  text-align: justify;
                "
              >
                Race conditions
              </p>
              <p
                style="
                  padding-top: 7pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Multiple relayers relaying between the same pair of modules and
                ledgers may attempt to relay the same packet (or submit the same
                header) at the same time. If two relayers do so, the first
                transaction will succeed and the second will fail. Out-of-band
                coordination between the relayers or between the actors who sent
                the original packets and the relayers is necessary to mitigate
                this.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 6pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: justify;
                "
              >
                Incentivisation
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The relay process must have access to accounts on both ledgers with
            sufficient balance to pay for transaction fees. Relayers may employ
            application-level methods to recoup these fees, such by including a
            small payment to themselves in the packet data.
          </p>
          <p
            style="
              padding-top: 7pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Any number of relayer processes may be safely run in parallel (and
            indeed, it is expected that separate relayers will serve separate
            subsets of the multi-ledger network). However, they may consume
            unnecessary fees if they submit the same proof multiple times, so
            some minimal coordination may be ideal (such as assigning particular
            relayers to particular packets or scanning mempools for pending
            transactions).
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 12pt;
              padding-left: 101pt;
              text-indent: -16pt;
              text-align: left;
            "
          >
            <a name="bookmark46">Usage patterns</a
            ><a name="bookmark47">&zwnj;</a>
          </p>
          <ol id="l26">
            <li>
              <p
                style="
                  padding-top: 7pt;
                  padding-left: 23pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                Call receiver
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Essential to the functionality of the IBC handler is an
                interface to other modules running on the same ledger, so that
                it can accept requests to send packets and can route incoming
                packets to modules. This interface should be as minimal as
                possible in order to reduce implementation complexity and
                requirements imposed on host ledgers.
              </p>
              <p
                style="
                  padding-top: 7pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                For this reason, the core IBC logic uses a receive-only call
                pattern that differs slightly from the intuitive dataflow. As
                one might expect, modules call into the IBC handler to create
                connections, channels, and send packets. However, instead of the
                IBC handler, upon receipt of a packet from another ledger,
                selecting and calling into the appropriate module, the module
                itself must call <span class="s5">recvPacket </span>on the IBC
                handler (likewise for accepting channel creation hand- shakes).
                When <span class="s5">recvPacket </span>is called, the IBC
                handler will check that the calling module is authorised to
                receive and process the packet (based on included proofs and
                known state of connections / channels), perform appropriate
                state updates (incrementing sequence numbers to prevent replay),
                and return control to the module or throw on error. The IBC
                handler never calls into modules directly.
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Although a bit counterintuitive to reason about at first, this
                pattern has a few notable advantages:
              </p>
              <ul id="l27">
                <li>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    It minimises requirements of the host ledger, since the IBC
                    handler need not understand how to call into other modules
                    or store any references to them.
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    It avoids the necessity of managing a module lookup table in
                    the handler state.
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: left;
                    "
                  >
                    It avoids the necessity of dealing with module return data
                    or failures. If a module does not want to receive a packet
                    (perhaps having implemented ad- ditional authorisation on
                    top), it simply never calls
                    <span class="s5">recvPacket</span>. If the routing logic
                    were implemented in the IBC handler, the handler would need
                    to deal with the failure of the module, which is tricky to
                    interpret.
                  </p>
                </li>
              </ul>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                It also has one notable disadvantage: without an additional
                abstraction, the relayer logic becomes more complex, since
                off-ledger relayer processes will need to track the state of
                multiple modules to determine when packets can be submitted.
              </p>
              <p
                style="
                  padding-top: 6pt;
                  padding-left: 5pt;
                  text-indent: 1pt;
                  text-align: justify;
                "
              >
                For this reason, ledgers may implement an additional IBC
                “routing module” which exposes a call dispatch interface.
              </p>
            </li>
            <li>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 23pt;
                  text-indent: -16pt;
                  text-align: justify;
                "
              >
                <a name="bookmark48">Call dispatch</a>
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 4pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            For common relay patterns, an “IBC routing module” can be
            implemented which maintains a module dispatch table and simplifies
            the job of relayers.
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 1pt;
              text-align: justify;
            "
          >
            In the call dispatch pattern, datagrams (contained within
            transaction types defined by the host ledger) are relayed directly
            to the routing module, which then looks up the appropriate module
            (owning the channel and port to which the datagram was addressed)
            and calls an appropriate function (which must have been previously
            registered with the routing module). This allows modules to avoid
            handling datagrams directly, and makes it harder to accidentally
            screw-up the atomic state transition execution which must happen in
            conjunction with sending or receiving a packet (since the module
            never handles packets directly, but rather exposes functions which
            are called by the routing module upon receipt of a valid packet).
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Additionally, the routing module can implement default logic for
            handshake datagram handling (accepting incoming handshakes on behalf
            of modules), which is convenient for modules which do not need to
            implement their own custom logic.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 8pt;
              padding-left: 54pt;
              text-indent: -20pt;
              text-align: justify;
            "
          >
            <a name="bookmark49">Example application-level module</a>
          </p>
          <p
            style="
              padding-top: 4pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The section specifies packet data structure and state machine
            handling logic for the transfer of fungible tokens over an IBC
            channel between two modules on separate ledgers. The state machine
            logic presented allows for safe multi-ledger denomination handling
            with permissionless channel opening. This logic constitutes a
            “fungible token transfer bridge module”, interfacing between the IBC
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            routing module and an existing asset tracking module on the host
            ledger.
          </p>
          <ol id="l28">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark50">Motivation</a>
              </p>
              <p
                style="
                  padding-top: 9pt;
                  padding-left: 5pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Users of a set of ledgers connected over the IBC protocol might
                wish to utilise an asset issued on one ledger on another ledger,
                perhaps to make use of additional features such as exchange or
                privacy protection, while retaining fungibility with the
                original asset on the issuing ledger. This application-layer
                protocol allows for transferring fungible tokens between ledgers
                connected with IBC in a way which preserves asset fungibility,
                preserves asset ownership, limits the impact of Byzantine
                faults, and requires no additional permissioning.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark51">Properties</a>
              </p>
              <ul id="l29">
                <li>
                  <p
                    style="
                      padding-top: 8pt;
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Preservation of fungibility (two-way peg)
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Preservation of total supply (constant or inflationary on a
                    single source ledger and module)
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Permissionless token transfers, no need to whitelist
                    connections, modules, or denominations
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Symmetric (all ledgers implement the same logic)
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Fault containment: prevents Byzantine-inflation of tokens
                    originating on ledger A, as a result of ledger B’s Byzantine
                    behaviour (though any users who sent tokens to ledger B may
                    be at risk)
                  </p>
                </li>
              </ul>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 10pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark52">Packet definition</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 5pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                Only one packet data type,
                <span class="s5">FungibleTokenPacketData</span>, which specifies
                the denomination, amount, sending account, receiving account,
                and whether the sending ledger is the source of the asset, is
                required:
              </p>
              <p
                class="s5"
                style="
                  padding-top: 7pt;
                  padding-left: 16pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                interface FungibleTokenPacketData { denomination<span
                  style="color: #666"
                  >: </span
                ><span style="color: #8e2100">string</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 16pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                amount<span style="color: #666">: </span>uint256 sender<span
                  style="color: #666"
                  >: </span
                ><span style="color: #8e2100">string </span>receiver<span
                  style="color: #666"
                  >: </span
                ><span style="color: #8e2100">string</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 5pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                }
              </p>
              <p
                style="
                  padding-top: 5pt;
                  padding-left: 5pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The acknowledgement data type describes whether the transfer
                succeeded or failed, and the reason for failure (if any):
              </p>
              <p
                class="s5"
                style="
                  padding-top: 6pt;
                  padding-left: 16pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                interface FungibleTokenPacketAcknowledgement { success<span
                  style="color: #666"
                  >: </span
                ><span style="color: #8e2100">boolean</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 16pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <span style="color: #000">error</span>:
                <span style="color: #000">Maybe</span>&lt;<span
                  style="color: #8e2100"
                  >string</span
                >&gt;
              </p>
              <p
                class="s5"
                style="padding-left: 5pt; text-indent: 0pt; text-align: left"
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 8pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark53">Packet handling semantics</a>
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 5pt;
                  text-indent: 0pt;
                  text-align: justify;
                "
              >
                The protocol logic is symmetric, so that denominations
                originating on either ledger can be converted to vouchers on the
                other, and then redeemed back again later.
              </p>
              <ul id="l30">
                <li>
                  <p
                    style="
                      padding-top: 7pt;
                      padding-left: 25pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    When acting as the source ledger, the bridge module escrows
                    an existing local asset denomination on the
                  </p>
                  <p
                    style="
                      padding-top: 5pt;
                      padding-left: 26pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    sending ledger and mints vouchers on the receiving ledger.
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    When acting as the sink ledger, the bridge module burns
                    local vouchers on the sending ledgers and une- scrows the
                    local asset denomination on the receiving ledger.
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    When a packet times-out, local assets are unescrowed back to
                    the sender or vouchers minted back to the sender
                    appropriately.
                  </p>
                </li>
                <li>
                  <p
                    style="
                      padding-left: 26pt;
                      text-indent: -10pt;
                      text-align: justify;
                    "
                  >
                    Acknowledgement data is used to handle failures, such as
                    invalid denominations or invalid destination accounts.
                    Returning an acknowledgement of failure is preferable to
                    aborting the transaction since it more easily enables the
                    sending ledger to take appropriate action based on the
                    nature of the failure.
                  </p>
                  <p style="text-indent: 0pt; text-align: left"><br /></p>
                  <p
                    style="
                      padding-left: 6pt;
                      text-indent: 0pt;
                      text-align: justify;
                    "
                  >
                    <a name="bookmark54"
                      >This implementation preserves both fungibility and
                      supply. If tokens have been sent to the counterparty
                      ledger, they can be redeemed back in the same denomination
                      and amount on the source ledger. The combined supply of
                      unlocked tokens of a particular on both ledgers is
                      constant, since each send-receive packet pair locks and
                      mints the same amount (although the source ledger of a
                      particular asset could change the supply outside of the
                      scope of this protocol).</a
                    >
                  </p>
                </li>
              </ul>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 11pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Fault containment
              </p>
              <p
                style="
                  padding-top: 8pt;
                  padding-left: 5pt;
                  text-indent: 1pt;
                  text-align: justify;
                "
              >
                Ledgers could fail to follow the fungible transfer token
                protocol outlined here in one of two ways: the full nodes
                running the consensus algorithm could diverge from the light
                client, or the ledger’s state machine could incorrectly
                implement the escrow &amp; voucher logic (whether inad-
                vertently or intentionally). Consensus divergence should
                eventually result in evidence of misbehaviour which can be used
                to freeze the client, but may not immediately do so (and no
                guarantee can be made that such evidence would be submitted
                before more packets), so from the perspective of the protocol’s
                goal of isolating faults these cases must be handled in the same
                way. No guarantees can be made about asset recovery — users
                electing to transfer tokens to a ledger take on the risk of that
                ledger failing — but containment logic can easily be implemented
                on the interface boundary by tracking incoming and outgoing
                supply of each asset, and ensuring that no ledger is allowed to
                redeem vouchers for more tokens than it had initially escrowed.
                In essence, particular channels can be treated as accounts,
                where a module on the other end of a channel cannot spend more
                than it has received. Since isolated Byzantine sub-graphs of a
                multi-ledger fungible token transfer system will be unable to
                transfer out any more tokens than they had initially received,
                this prevents any supply inflation of source assets, and ensures
                that users only take on the consensus risk of ledgers they
                intentionally connect to.
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 5pt;
                  padding-left: 20pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark55">Multi-ledger transfer paths</a>
              </p>
            </li>
          </ol>
          <p
            style="
              padding-top: 8pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            This protocol does not directly handle the “diamond problem”, where
            a user sends a token originating on ledger A to ledger B, then to
            ledger D, and wants to return it through the path
            <span class="s5">D -&gt; C -&gt; A </span>— since the supply is
            tracked as owned by ledger B (and the voucher denomination will be
            <span class="s5"
              >&quot;{portD}/{channelD}/{portB}/{channelB}/denom&quot;</span
            >), ledger C cannot serve as the intermediary. This is necessary due
            to the fault containment desiderata outlined above. Complexities
            arising from long redemption paths may lead to the emergence of
            central ledgers in the network topology or automated markets to
            exchange assets with different redemption paths.
          </p>
          <p
            style="
              padding-top: 7pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            In order to track all of the denominations moving around the network
            of ledgers in various paths, it may be helpful for a particular
            ledger to implement a registry which will track the “global” source
            ledger for each denomination. End-user service providers (such as
            wallet authors) may want to integrate such a registry or keep their
            own mapping of canonical source ledgers and human-readable names in
            order to improve UX.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 8pt;
              padding-left: 86pt;
              text-indent: -25pt;
              text-align: justify;
            "
          >
            <a name="bookmark56">Testing &amp; deployment</a>
          </p>
          <p
            style="
              padding-top: 4pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            A full version of the interblockchain protocol has been implemented
            in Go in the Cosmos SDK [13], an implemen- tation is in progress in
            Rust [14], and implementations are planned for other languages in
            the future. An off-ledger relayer daemon has also been implemented
            in Go [15]. Game of Zones [16], a live test of the initial software
            release, is currently in progress. Over one hundred simulated zones
            (separate consensus instances and ledgers) have been successfully
            linked together [17].
          </p>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Production release and deployment to the Cosmos Network is planned
            for later this summer. As IBC is a permissionless, opt-in protocol,
            adoption will be dependent on ledgers voluntarily electing to
            support the specification, in full or in part. Adoption of IBC does
            not require connection to the Cosmos Hub, usage of any particular
            token, or even usage of any other piece of Cosmos software — IBC can
            be implemented on top of other state machine frameworks such as
            Substrate [18], or by standalone ledgers using custom logic —
            adherence to the correct protocol is both necessary and sufficient
            for successful interoperation.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 8pt;
              padding-left: 96pt;
              text-indent: -29pt;
              text-align: justify;
            "
          >
            <a name="bookmark57">Acknowledgements</a>
          </p>
          <p
            style="
              padding-top: 4pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            The original idea of IBC was first outlined in the Cosmos whitepaper
            [19], and realisation of the protocol is made possible in practice
            by the Byzantine-fault-tolerant con- sensus and efficient light
            client verification of Tendermint, introduced in
            <i>Tendermint: Consensus without Mining </i>[8] and updated in
            <i>The latest gossip on BFT consensus </i>[20]. An earlier version
            of the IBC specification [21] was written by Ethan Frey.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            Many current and former employees of All in Bits (dba Tendermint
            Inc.), Agoric Systems, the Interchain Founda- tion, Informal
            Systems, and Interchain GmbH participated in brainstorming and
            reviews of the IBC protocol. Thanks are due in particular to Ethan
            Buchman, Jae Kwon, Ethan Frey, Juwoon Yun, Anca Zamfir, Zarko
            Milosevic, Zaki Manian, Aditya Sripal, Federico Kunze, Dean Tribble,
            Mark Miller, Brian Warner, Chris Hibbert, Michael FIG, Sunny
            Aggarwal, Dev Ojha, Colin Axner, and Jack Zampolin. Thanks also to
            Meher Roy at Chorus One. Thanks to Zaki Manian, Sam Hart, and Adi
            Seredinschi for reviewing this paper.
          </p>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            This work was supported by the Interchain Foundation.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 5pt;
              padding-left: 246pt;
              text-indent: -20pt;
              text-align: left;
            "
          >
            <a name="bookmark58">Appendices</a>
          </p>
        </li>
      </ol>
      <p style="text-indent: 0pt; text-align: left"><br /></p>
      <ol id="l31">
        <li>
          <p style="padding-left: 23pt; text-indent: -16pt; text-align: left">
            <a name="bookmark59">Connection handshake</a
            ><a name="bookmark60">&zwnj;</a>
          </p>
          <ol id="l32">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 11pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Initiating a handshake
              </p>
              <p
                class="s5"
                style="
                  padding-top: 10pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">connOpenInit</span>(
                identifier<span style="color: #666">: </span>Identifier<span
                  style="color: #666"
                  >,</span
                >
              </p>
              <p
                class="s5"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                desiredCounterpartyConnectionIdentifier<span style="color: #666"
                  >: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyPrefix<span style="color: #666">: </span
                >CommitmentPrefix<span style="color: #666">, </span
                >clientIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">: </span
                >Identifier) {
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(validateConnectionIdentifier(identifier))
                abortTransactionUnless(provableStore<span style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(identifier))
                <span style="color: #666">== </span>null) state
                <span style="color: #666">= </span>INIT
              </p>
              <p
                class="s5"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                connection
                <span style="color: #666">= </span>ConnectionEnd{state<span
                  style="color: #666"
                  >, </span
                >desiredCounterpartyConnectionIdentifier<span
                  style="color: #666"
                  >, </span
                >counterpartyPrefix<span style="color: #666">, </span
                >clientIdentifier<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">, </span
                >getCompatibleVersions()}
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 10pt;
                  text-align: left;
                "
              >
                <a name="bookmark61">provableStore</a
                ><span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(connectionPath(identifier)<span style="color: #666">, </span
                >connection)
              </p>
              <p
                class="s5"
                style="
                  padding-top: 1pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  text-align: left;
                "
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 1pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Responding to a handshake initiation
              </p>
              <p
                class="s5"
                style="
                  padding-top: 10pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">connOpenTry</span>(
                desiredIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                counterpartyConnectionIdentifier<span style="color: #666"
                  >: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyPrefix<span style="color: #666">: </span
                >CommitmentPrefix<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >clientIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyVersions<span style="color: #666">: </span
                ><span style="color: #8e2100">string</span>[]<span
                  style="color: #666"
                  >,</span
                >
              </p>
              <p
                class="s5"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                proofInit<span style="color: #666">: </span>CommitmentProof<span
                  style="color: #666"
                  >, </span
                >proofConsensus<span style="color: #666">: </span
                >CommitmentProof<span style="color: #666">, </span
                >proofHeight<span style="color: #666">: </span>uint64<span
                  style="color: #666"
                  >, </span
                >consensusHeight<span style="color: #666">: </span>uint64) {
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(validateConnectionIdentifier(desiredIdentifier))
                abortTransactionUnless(consensusHeight
                <span style="color: #666">&lt;= </span>getCurrentHeight())
                expectedConsensusState
                <span style="color: #666">= </span
                >getConsensusState(consensusHeight)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 158pt;
                  text-indent: -130pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                expected
                <span style="color: #666">= </span>ConnectionEnd{INIT<span
                  style="color: #666"
                  >, </span
                >desiredIdentifier<span style="color: #666">, </span
                >getCommitmentPrefix()<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">, </span
                >clientIdentifier<span style="color: #666">, </span
                >counterpartyVersions}
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                version
                <span style="color: #666">= </span
                >pickVersion(counterpartyVersions)
              </p>
              <p
                class="s5"
                style="padding-left: 27pt; text-indent: 0pt; text-align: left"
              >
                connection
                <span style="color: #666">= </span>ConnectionEnd{TRYOPEN<span
                  style="color: #666"
                  >, </span
                >counterpartyConnectionIdentifier<span style="color: #666"
                  >, </span
                >counterpartyPrefix<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 169pt;
                  text-indent: 0pt;
                  line-height: 10pt;
                  text-align: left;
                "
              >
                clientIdentifier<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">, </span
                >version}
              </p>
              <p
                class="s5"
                style="
                  padding-top: 1pt;
                  padding-left: 27pt;
                  text-indent: 0pt;
                  text-align: left;
                "
              >
                abortTransactionUnless(
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                connection<span style="color: #666">.</span
                ><span style="color: #05287c">verifyConnectionState</span
                >(proofHeight<span style="color: #666">, </span>proofInit<span
                  style="color: #666"
                  >, </span
                >counterpartyConnectionIdentifier<span style="color: #666"
                  >, </span
                >expected)) abortTransactionUnless(connection<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">verifyClientConsensusState</span>(
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                proofHeight<span style="color: #666">, </span
                >proofConsensus<span style="color: #666">, </span
                >counterpartyClientIdentifier<span style="color: #666">, </span
                >consensusHeight<span style="color: #666">, </span
                >expectedConsensusState)) previous
                <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(desiredIdentifier))
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless( (previous </span
                >=== <span style="color: #000">null) </span>||
                <span style="color: #000">(previous</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >=== <span style="color: #000">INIT </span>&amp;&amp;
              </p>
              <p
                class="s6"
                style="
                  padding-left: 48pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >counterpartyConnectionIdentifier </span
                >===
                <span style="color: #000"
                  >counterpartyConnectionIdentifier </span
                >&amp;&amp; <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >counterpartyPrefix </span
                >===
                <span style="color: #000">counterpartyPrefix </span>&amp;&amp;
              </p>
              <p
                class="s6"
                style="
                  padding-left: 48pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >clientIdentifier </span
                >===
                <span style="color: #000">clientIdentifier </span>&amp;&amp;
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >counterpartyClientIdentifier </span
                >===
                <span style="color: #000">counterpartyClientIdentifier </span
                >&amp;&amp; <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >version </span
                >=== <span style="color: #000">version))</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                identifier <span style="color: #666">= </span>desiredIdentifier
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(connectionPath(identifier)<span style="color: #666">, </span
                >connection)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 5pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                <a name="bookmark62">Acknowledging the response</a>
              </p>
              <p
                class="s6"
                style="
                  padding-top: 10pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">connOpenAck</span
                ><span style="color: #000">( identifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">version</span>:
                <span style="color: #8e2100">string</span>,
                <span style="color: #000">proofTry</span>:
                <span style="color: #000">CommitmentProof</span>,
              </p>
              <p
                class="s5"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                proofConsensus<span style="color: #666">: </span
                >CommitmentProof<span style="color: #666">, </span
                >proofHeight<span style="color: #666">: </span>uint64<span
                  style="color: #666"
                  >, </span
                >consensusHeight<span style="color: #666">: </span>uint64) {
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(consensusHeight
                <span style="color: #666">&lt;= </span>getCurrentHeight())
                connection <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(identifier))
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">INIT </span>||
                <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >===
                <span style="color: #000">TRYOPEN) expectedConsensusState </span
                >=
                <span style="color: #000"
                  >getConsensusState(consensusHeight)</span
                >
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                expected
                <span style="color: #666">= </span>ConnectionEnd{TRYOPEN<span
                  style="color: #666"
                  >, </span
                >identifier<span style="color: #666">, </span
                >getCommitmentPrefix()<span style="color: #666">,</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 158pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >counterpartyClientIdentifier</span
                >, <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >clientIdentifier</span
                >, <span style="color: #000">version}</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #05287c">verifyConnectionState</span
                ><span style="color: #000">(proofHeight</span>,
                <span style="color: #000">proofTry</span>,
                <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >counterpartyConnectionIdentifier</span
                >, <span style="color: #000">expected))</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #05287c">verifyClientConsensusState</span
                ><span style="color: #000">( proofHeight</span>,
                <span style="color: #000">proofConsensus</span>,
                <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >counterpartyClientIdentifier</span
                >, <span style="color: #000">consensusHeight</span>,
                <span style="color: #000">expectedConsensusState))</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">connection</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >=
                <span style="color: #000"
                  >OPEN abortTransactionUnless(getCompatibleVersions()</span
                >.<span style="color: #05287c">indexOf</span
                ><span style="color: #000">(version) </span>!== -<span
                  style="color: #3fa070"
                  >1</span
                ><span style="color: #000">) connection</span>.<span
                  style="color: #7c8e28"
                  >version </span
                >= <span style="color: #000">version provableStore</span>.<span
                  style="color: #05287c"
                  >set</span
                ><span style="color: #000">(connectionPath(identifier)</span>,
                <span style="color: #000">connection)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <a name="bookmark63">}</a>
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-left: 21pt;
                  text-indent: -14pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                Finalising the connection
              </p>
            </li>
          </ol>
          <p
            class="s5"
            style="
              padding-top: 9pt;
              padding-left: 17pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">connOpenConfirm</span>(
            identifier<span style="color: #666">: </span>Identifier<span
              style="color: #666"
              >, </span
            >proofAck<span style="color: #666">: </span>CommitmentProof<span
              style="color: #666"
              >, </span
            >proofHeight<span style="color: #666">: </span>uint64) {
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">connection </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000"
              >(connectionPath(identifier))
              abortTransactionUnless(connection</span
            >.<span style="color: #7c8e28">state </span>===
            <span style="color: #000">TRYOPEN)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            expected <span style="color: #666">= </span>ConnectionEnd{OPEN<span
              style="color: #666"
              >, </span
            >identifier<span style="color: #666">, </span
            >getCommitmentPrefix()<span style="color: #666">,</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 158pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">connection</span>.<span
              style="color: #7c8e28"
              >counterpartyClientIdentifier</span
            >, <span style="color: #000">connection</span>.<span
              style="color: #7c8e28"
              >clientIdentifier</span
            >, <span style="color: #000">connection</span>.<span
              style="color: #7c8e28"
              >version</span
            ><span style="color: #000">}</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #05287c">verifyConnectionState</span>(
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proofHeight</span>,
            <span style="color: #000">proofAck</span>,
            <span style="color: #000">connection</span>.<span
              style="color: #7c8e28"
              >counterpartyConnectionIdentifier</span
            >, <span style="color: #000">expected)) connection</span>.<span
              style="color: #7c8e28"
              >state </span
            >= <span style="color: #000">OPEN</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 10pt;
              text-align: left;
            "
          >
            provableStore<span style="color: #666">.</span
            ><span style="color: #05287c">set</span
            >(connectionPath(identifier)<span style="color: #666">, </span
            >connection)
          </p>
          <p
            class="s5"
            style="
              padding-top: 1pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a name="bookmark64">}</a>
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 23pt;
              text-indent: -16pt;
              text-align: left;
            "
          >
            <a name="bookmark65">Channel handshake</a>
          </p>
          <ol id="l33">
            <li>
              <p
                class="s4"
                style="
                  padding-top: 3pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Initiating a handshake
              </p>
              <p
                class="s5"
                style="
                  padding-top: 9pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">chanOpenInit</span>( order<span
                  style="color: #666"
                  >: </span
                >ChannelOrder<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                connectionHops<span style="color: #666">: </span
                >[Identifier]<span style="color: #666">, </span
                >portIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >channelIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyPortIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span
                >counterpartyChannelIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span>version<span
                  style="color: #666"
                  >: </span
                ><span style="color: #8e2100">string</span>)<span
                  style="color: #666"
                  >: </span
                >CapabilityKey {
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(validateChannelIdentifier(portIdentifier</span
                >,
                <span style="color: #000"
                  >channelIdentifier))
                  abortTransactionUnless(connectionHops</span
                >.<span style="color: #7c8e28">length </span>===
                <span style="color: #3fa070">1</span
                ><span style="color: #000"
                  >) abortTransactionUnless(provableStore</span
                >.<span style="color: #05287c">get</span
                ><span style="color: #000">(channelPath(portIdentifier</span>,
                <span style="color: #000">channelIdentifier)) </span>===
                <span style="color: #000">null)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-top: 5pt;
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                connection <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(connectionHops[<span style="color: #3fa070"
                  >0</span
                >])) abortTransactionUnless(connection
                <span style="color: #666">!== </span>null)
                abortTransactionUnless(authenticateCapability(portPath(portIdentifier)<span
                  style="color: #666"
                  >, </span
                >portCapability)) channel
                <span style="color: #666">= </span>ChannelEnd{INIT<span
                  style="color: #666"
                  >, </span
                >order<span style="color: #666">, </span
                >counterpartyPortIdentifier<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 109pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                counterpartyChannelIdentifier<span style="color: #666">, </span
                >connectionHops<span style="color: #666">, </span>version}
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)<span style="color: #666">, </span>channel)
                channelCapability
                <span style="color: #666">= </span
                >newCapability(channelCapabilityPath(portIdentifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier)) provableStore<span style="color: #666"
                  >.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceSendPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceRecvPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <a name="bookmark66">provableStore</a
                ><span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceAckPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>) return channelCapability
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 3pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Responding to a handshake initiation
              </p>
              <p
                class="s5"
                style="
                  padding-top: 10pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">chanOpenTry</span>( order<span
                  style="color: #666"
                  >: </span
                >ChannelOrder<span style="color: #666">,</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">connectionHops</span>:
                <span style="color: #000">[Identifier]</span>,
                <span style="color: #000">portIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">channelIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">counterpartyPortIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">counterpartyChannelIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">version</span>:
                <span style="color: #8e2100">string</span>,
              </p>
              <p
                class="s6"
                style="
                  padding-left: 17pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">counterpartyVersion</span>:
                <span style="color: #8e2100">string</span>,
                <span style="color: #000">proofInit</span>:
                <span style="color: #000">CommitmentProof</span>,
                <span style="color: #000">proofHeight</span>:
                <span style="color: #000">uint64)</span>:
                <span style="color: #000">CapabilityKey {</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(validateChannelIdentifier(portIdentifier</span
                >,
                <span style="color: #000"
                  >channelIdentifier))
                  abortTransactionUnless(connectionHops</span
                >.<span style="color: #7c8e28">length </span>===
                <span style="color: #3fa070">1</span
                ><span style="color: #000">)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                previous <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)) abortTransactionUnless(
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">(previous </span>===
                <span style="color: #000">null) </span>||
                <span style="color: #000">(previous</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >=== <span style="color: #000">INIT </span>&amp;&amp;
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >order </span
                >=== <span style="color: #000">order </span>&amp;&amp;
              </p>
              <p
                class="s6"
                style="
                  padding-left: 43pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >counterpartyPortIdentifier </span
                >===
                <span style="color: #000">counterpartyPortIdentifier </span
                >&amp;&amp; <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >counterpartyChannelIdentifier </span
                >===
                <span style="color: #000">counterpartyChannelIdentifier </span
                >&amp;&amp; <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >connectionHops </span
                >=== <span style="color: #000">connectionHops </span>&amp;&amp;
              </p>
              <p
                class="s6"
                style="
                  padding-left: 43pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <span style="color: #000">previous</span>.<span
                  style="color: #7c8e28"
                  >version </span
                >=== <span style="color: #000">version)</span>
              </p>
              <p
                class="s5"
                style="padding-left: 38pt; text-indent: 0pt; text-align: left"
              >
                )
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(authenticateCapability(portPath(portIdentifier)<span
                  style="color: #666"
                  >, </span
                >portCapability)) connection
                <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(connectionHops[<span style="color: #3fa070"
                  >0</span
                >])) abortTransactionUnless(connection
                <span style="color: #666">!== </span>null)
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">OPEN) expected </span>=
                <span style="color: #000">ChannelEnd{INIT</span>,
                <span style="color: #000">order</span>,
                <span style="color: #000">portIdentifier</span>,
              </p>
              <p
                class="s5"
                style="
                  padding-left: 142pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                channelIdentifier<span style="color: #666">, </span
                >[connection<span style="color: #666">.</span
                ><span style="color: #7c8e28"
                  >counterpartyConnectionIdentifier</span
                >]<span style="color: #666">, </span>counterpartyVersion}
              </p>
              <p
                class="s5"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(connection<span style="color: #666"
                  >.</span
                ><span style="color: #05287c">verifyChannelState</span>(
                proofHeight<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 38pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                proofInit<span style="color: #666">, </span
                >counterpartyPortIdentifier<span style="color: #666">, </span
                >counterpartyChannelIdentifier<span style="color: #666">, </span
                >expected
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                ))
              </p>
              <p
                class="s5"
                style="padding-left: 27pt; text-indent: 0pt; text-align: left"
              >
                channel
                <span style="color: #666">= </span>ChannelEnd{TRYOPEN<span
                  style="color: #666"
                  >, </span
                >order<span style="color: #666">, </span
                >counterpartyPortIdentifier<span style="color: #666">,</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 109pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                counterpartyChannelIdentifier<span style="color: #666">, </span
                >connectionHops<span style="color: #666">, </span>version}
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)<span style="color: #666">, </span>channel)
                channelCapability
                <span style="color: #666">= </span
                >newCapability(channelCapabilityPath(portIdentifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier))
              </p>
              <p
                class="s5"
                style="
                  padding-top: 5pt;
                  padding-left: 27pt;
                  text-indent: 0pt;
                  text-align: left;
                "
              >
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceSendPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>)
              </p>
              <p
                class="s5"
                style="padding-left: 27pt; text-indent: 0pt; text-align: left"
              >
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceRecvPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <a name="bookmark67">provableStore</a
                ><span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(nextSequenceAckPath(portIdentifier<span style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span
                ><span style="color: #3fa070">1</span>) return channelCapability
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 3pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Acknowledging the response
              </p>
              <p
                class="s6"
                style="
                  padding-top: 9pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">chanOpenAck</span
                ><span style="color: #000">( portIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">channelIdentifier</span>:
                <span style="color: #000">Identifier</span>,
                <span style="color: #000">counterpartyVersion</span>:
                <span style="color: #8e2100">string</span>,
                <span style="color: #000">proofTry</span>:
                <span style="color: #000">CommitmentProof</span>,
                <span style="color: #000">proofHeight</span>:
                <span style="color: #000">uint64) {</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">channel </span>=
                <span style="color: #000">provableStore</span>.<span
                  style="color: #05287c"
                  >get</span
                ><span style="color: #000">(channelPath(portIdentifier</span>,
                <span style="color: #000"
                  >channelIdentifier)) abortTransactionUnless(channel</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">INIT </span>||
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >===
                <span style="color: #000"
                  >TRYOPEN)
                  abortTransactionUnless(authenticateCapability(channelCapabilityPath(portIdentifier</span
                >, <span style="color: #000">channelIdentifier)</span>,
                <span style="color: #000">connection </span>=
                <span style="color: #000">provableStore</span>.<span
                  style="color: #05287c"
                  >get</span
                ><span style="color: #000">(connectionPath(channel</span>.<span
                  style="color: #7c8e28"
                  >connectionHops</span
                ><span style="color: #000">[</span
                ><span style="color: #3fa070">0</span
                ><span style="color: #000"
                  >])) abortTransactionUnless(connection </span
                >!== <span style="color: #000">null)</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">OPEN)</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 142pt;
                  text-indent: -115pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">expected </span>=
                <span style="color: #000">ChannelEnd{TRYOPEN</span>,
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >order</span
                >, <span style="color: #000">portIdentifier</span>,
                <span style="color: #000">channelIdentifier</span>,
                <span style="color: #000">[connection</span>.<span
                  style="color: #7c8e28"
                  >counterpartyConnectionIdentifier</span
                ><span style="color: #000">]</span>,
                <span style="color: #000">counterpartyVersion}</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(connection<span style="color: #666"
                  >.</span
                ><span style="color: #05287c">verifyChannelState</span>(
                proofHeight<span style="color: #666">,</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">proofTry</span>,
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >counterpartyPortIdentifier</span
                >, <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >counterpartyChannelIdentifier</span
                >, <span style="color: #000">expected</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                ))
              </p>
              <p
                class="s6"
                style="padding-left: 27pt; text-indent: 0pt; text-align: left"
              >
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >= <span style="color: #000">OPEN</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <a name="bookmark68"><span style="color: #000">channel</span></a
                >.<span style="color: #7c8e28">version </span>=
                <span style="color: #000"
                  >counterpartyVersion provableStore</span
                >.<span style="color: #05287c">set</span
                ><span style="color: #000">(channelPath(portIdentifier</span>,
                <span style="color: #000">channelIdentifier)</span>,
                <span style="color: #000">channel)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                }
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 3pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Finalising a channel
              </p>
              <p
                class="s5"
                style="
                  padding-top: 10pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">chanOpenConfirm</span>(
                portIdentifier<span style="color: #666">: </span>Identifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier<span style="color: #666">: </span
                >Identifier<span style="color: #666">, </span>proofAck<span
                  style="color: #666"
                  >: </span
                >CommitmentProof<span style="color: #666">, </span
                >proofHeight<span style="color: #666">: </span>uint64) {
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">channel </span>=
                <span style="color: #000">provableStore</span>.<span
                  style="color: #05287c"
                  >get</span
                ><span style="color: #000">(channelPath(portIdentifier</span>,
                <span style="color: #000"
                  >channelIdentifier)) abortTransactionUnless(channel </span
                >!==
                <span style="color: #000"
                  >null) abortTransactionUnless(channel</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">TRYOPEN)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(authenticateCapability(channelCapabilityPath(portIdentifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span>connection
                <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(channel<span style="color: #666">.</span
                ><span style="color: #7c8e28">connectionHops</span>[<span
                  style="color: #3fa070"
                  >0</span
                >])) abortTransactionUnless(connection
                <span style="color: #666">!== </span>null)
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000"
                  >abortTransactionUnless(connection</span
                >.<span style="color: #7c8e28">state </span>===
                <span style="color: #000">OPEN) expected </span>=
                <span style="color: #000">ChannelEnd{OPEN</span>,
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >order</span
                >, <span style="color: #000">portIdentifier</span>,
              </p>
              <p
                class="s5"
                style="
                  padding-left: 142pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                channelIdentifier<span style="color: #666">, </span
                >[connection<span style="color: #666">.</span
                ><span style="color: #7c8e28"
                  >counterpartyConnectionIdentifier</span
                >]<span style="color: #666">, </span>channel<span
                  style="color: #666"
                  >.</span
                ><span style="color: #7c8e28">version</span>}
              </p>
              <p
                class="s5"
                style="
                  padding-left: 38pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(connection<span style="color: #666"
                  >.</span
                ><span style="color: #05287c">verifyChannelState</span>(
                proofHeight<span style="color: #666">,</span>
              </p>
              <p
                class="s6"
                style="
                  padding-left: 38pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">proofAck</span>,
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >counterpartyPortIdentifier</span
                >,
              </p>
              <p
                class="s6"
                style="
                  padding-top: 5pt;
                  padding-left: 38pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >counterpartyChannelIdentifier</span
                >, <span style="color: #000">expected</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 10pt;
                  text-align: left;
                "
              >
                ))
              </p>
              <p
                class="s6"
                style="
                  padding-top: 1pt;
                  padding-left: 27pt;
                  text-indent: 0pt;
                  text-align: left;
                "
              >
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >= <span style="color: #000">OPEN</span>
              </p>
              <p
                class="s5"
                style="padding-left: 27pt; text-indent: 0pt; text-align: left"
              >
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)<span style="color: #666">, </span>channel)
              </p>
              <p
                class="s5"
                style="
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 9pt;
                  text-align: left;
                "
              >
                <a name="bookmark69">}</a>
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-top: 1pt;
                  padding-left: 21pt;
                  text-indent: -14pt;
                  text-align: left;
                "
              >
                Initiating channel closure
              </p>
              <p
                class="s5"
                style="
                  padding-top: 9pt;
                  padding-left: 17pt;
                  text-indent: -10pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                <span class="h1">function </span
                ><span style="color: #05287c">chanCloseInit</span>(
                portIdentifier<span style="color: #666">: </span>Identifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier<span style="color: #666">: </span>Identifier)
                {
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                abortTransactionUnless(authenticateCapability(channelCapabilityPath(portIdentifier<span
                  style="color: #666"
                  >, </span
                >channelIdentifier)<span style="color: #666">, </span>channel
                <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)) abortTransactionUnless(channel
                <span style="color: #666">!== </span>null)
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <span style="color: #000">abortTransactionUnless(channel</span
                >.<span style="color: #7c8e28">state </span>!==
                <span style="color: #000">CLOSED)</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 106%;
                  text-align: left;
                "
              >
                connection <span style="color: #666">= </span>provableStore<span
                  style="color: #666"
                  >.</span
                ><span style="color: #05287c">get</span
                >(connectionPath(channel<span style="color: #666">.</span
                ><span style="color: #7c8e28">connectionHops</span>[<span
                  style="color: #3fa070"
                  >0</span
                >])) abortTransactionUnless(connection
                <span style="color: #666">!== </span>null)
                abortTransactionUnless(connection<span style="color: #666"
                  >.</span
                ><span style="color: #7c8e28">state </span
                ><span style="color: #666">=== </span>OPEN)
              </p>
              <p
                class="s6"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <span style="color: #000">channel</span>.<span
                  style="color: #7c8e28"
                  >state </span
                >= <span style="color: #000">CLOSED</span>
              </p>
              <p
                class="s5"
                style="
                  padding-left: 27pt;
                  text-indent: 0pt;
                  line-height: 10pt;
                  text-align: left;
                "
              >
                provableStore<span style="color: #666">.</span
                ><span style="color: #05287c">set</span
                >(channelPath(portIdentifier<span style="color: #666">, </span
                >channelIdentifier)<span style="color: #666">, </span>channel)
              </p>
              <p
                class="s5"
                style="
                  padding-top: 1pt;
                  padding-left: 6pt;
                  text-indent: 0pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                <a name="bookmark70">}</a>
              </p>
            </li>
            <li>
              <p
                class="s4"
                style="
                  padding-left: 21pt;
                  text-indent: -14pt;
                  line-height: 11pt;
                  text-align: left;
                "
              >
                Confirming channel closure
              </p>
            </li>
          </ol>
          <p
            class="s5"
            style="
              padding-top: 10pt;
              padding-left: 17pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">chanCloseConfirm</span>(
            portIdentifier<span style="color: #666">: </span>Identifier<span
              style="color: #666"
              >, </span
            >channelIdentifier<span style="color: #666">: </span>Identifier<span
              style="color: #666"
              >, </span
            >proofInit<span style="color: #666">: </span>CommitmentProof<span
              style="color: #666"
              >, </span
            >proofHeight<span style="color: #666">: </span>uint64) {
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            abortTransactionUnless(authenticateCapability(channelCapabilityPath(portIdentifier<span
              style="color: #666"
              >, </span
            >channelIdentifier)<span style="color: #666">, </span>channel
            <span style="color: #666">= </span>provableStore<span
              style="color: #666"
              >.</span
            ><span style="color: #05287c">get</span
            >(channelPath(portIdentifier<span style="color: #666">, </span
            >channelIdentifier)) abortTransactionUnless(channel
            <span style="color: #666">!== </span>null)
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(channel</span
            >.<span style="color: #7c8e28">state </span>!==
            <span style="color: #000">CLOSED)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            connection <span style="color: #666">= </span>provableStore<span
              style="color: #666"
              >.</span
            ><span style="color: #05287c">get</span>(connectionPath(channel<span
              style="color: #666"
              >.</span
            ><span style="color: #7c8e28">connectionHops</span>[<span
              style="color: #3fa070"
              >0</span
            >])) abortTransactionUnless(connection
            <span style="color: #666">!== </span>null)
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #7c8e28">state </span
            ><span style="color: #666">=== </span>OPEN)
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">expected </span>=
            <span style="color: #000">ChannelEnd{CLOSED</span>,
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >order</span
            >, <span style="color: #000">portIdentifier</span>,
          </p>
          <p
            class="s5"
            style="
              padding-left: 142pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            channelIdentifier<span style="color: #666">, </span>[connection<span
              style="color: #666"
              >.</span
            ><span style="color: #7c8e28">counterpartyConnectionIdentifier</span
            >]<span style="color: #666">, </span>channel<span
              style="color: #666"
              >.</span
            ><span style="color: #7c8e28">version</span>}
          </p>
          <p
            class="s5"
            style="
              padding-left: 38pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #05287c">verifyChannelState</span>(
            proofHeight<span style="color: #666">,</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proofInit</span>,
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyPortIdentifier</span
            >, <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyChannelIdentifier</span
            >, <span style="color: #000">expected</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            ))
          </p>
          <p
            class="s6"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >state </span
            >= <span style="color: #000">CLOSED</span>
          </p>
          <p
            class="s5"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            provableStore<span style="color: #666">.</span
            ><span style="color: #05287c">set</span
            >(channelPath(portIdentifier<span style="color: #666">, </span
            >channelIdentifier)<span style="color: #666">, </span>channel)
          </p>
          <p
            class="s5"
            style="padding-left: 6pt; text-indent: 0pt; text-align: left"
          >
            <a name="bookmark71">}</a>
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 23pt;
              text-indent: -16pt;
              text-align: left;
            "
          >
            <a name="bookmark72">Packet Handling</a>
          </p>
        </li>
      </ol>
      <ol id="l34">
        <li>
          <p
            class="s4"
            style="
              padding-top: 3pt;
              padding-left: 21pt;
              text-indent: -14pt;
              text-align: left;
            "
          >
            Sending a packet
          </p>
          <p
            class="s5"
            style="
              padding-top: 9pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">sendPacket</span>(packet<span
              style="color: #666"
              >: </span
            >Packet) {
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channel </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(channelPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)) abortTransactionUnless(channel </span
            >!== <span style="color: #000">null)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(channel</span
            >.<span style="color: #7c8e28">state </span>!==
            <span style="color: #000">CLOSED)</span>
          </p>
          <p
            class="s6"
            style="
              padding-top: 5pt;
              padding-left: 38pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000"
              >abortTransactionUnless(authenticateCapability(
              channelCapabilityPath(packet</span
            >.<span style="color: #7c8e28">sourcePort</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">capability))</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(packet</span>.<span
              style="color: #7c8e28"
              >destPort </span
            >=== <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyPortIdentifier</span
            ><span style="color: #000">) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">destChannel </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyChannelIdentifier</span
            ><span style="color: #000">) connection </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(connectionPath(channel</span>.<span
              style="color: #7c8e28"
              >connectionHops</span
            ><span style="color: #000">[</span
            ><span style="color: #3fa070">0</span
            ><span style="color: #000"
              >])) abortTransactionUnless(connection </span
            >!== <span style="color: #000">null)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">latestClientHeight </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(clientPath(connection</span>.<span
              style="color: #7c8e28"
              >clientIdentifier</span
            ><span style="color: #000">))</span>.<span style="color: #05287c"
              >latestClientHeight</span
            ><span style="color: #000">() abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">timeoutHeight </span>===
            <span style="color: #3fa070">0 </span>||
            <span style="color: #000">latestClientHeight </span>&lt;
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutHeight</span
            ><span style="color: #000">) nextSequenceSend </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(nextSequenceSendPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">sequence </span>===
            <span style="color: #000">nextSequenceSend)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            nextSequenceSend <span style="color: #666">= </span>nextSequenceSend
            <span style="color: #666">+ </span
            ><span style="color: #3fa070">1</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >set</span
            ><span style="color: #000">(nextSequenceSendPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">nextSequenceSend) provableStore</span
            >.<span style="color: #05287c">set</span
            ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">)</span>,
          </p>
          <p
            class="s6"
            style="
              padding-left: 122pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <a name="bookmark73"><span style="color: #000">hash(packet</span></a
            >.<span style="color: #7c8e28">data</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutHeight</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000">))</span>
          </p>
          <p
            class="s5"
            style="padding-left: 6pt; text-indent: 0pt; text-align: left"
          >
            }
          </p>
        </li>
        <li>
          <p
            class="s4"
            style="
              padding-top: 3pt;
              padding-left: 21pt;
              text-indent: -14pt;
              text-align: left;
            "
          >
            Receiving a packet
          </p>
          <p
            class="s5"
            style="
              padding-top: 10pt;
              padding-left: 17pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">recvPacket</span>( packet<span
              style="color: #666"
              >: </span
            >OpaquePacket<span style="color: #666">, </span>proof<span
              style="color: #666"
              >: </span
            >CommitmentProof<span style="color: #666">, </span>proofHeight<span
              style="color: #666"
              >: </span
            >uint64<span style="color: #666">,</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 17pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            acknowledgement<span style="color: #666">: </span>bytes)<span
              style="color: #666"
              >: </span
            >Packet {
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channel </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(channelPath(packet</span>.<span
              style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            ><span style="color: #000">)) abortTransactionUnless(channel </span
            >!==
            <span style="color: #000">null) abortTransactionUnless(channel</span
            >.<span style="color: #7c8e28">state </span>===
            <span style="color: #000">OPEN)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            abortTransactionUnless(
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000"
              >authenticateCapability(channelCapabilityPath(packet</span
            >.<span style="color: #7c8e28">destPort</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000"
              >capability)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">sourcePort </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyPortIdentifier</span
            ><span style="color: #000">) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">sourceChannel </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyChannelIdentifier</span
            ><span style="color: #000"
              >) abortTransactionUnless(provableStore</span
            >.<span style="color: #05287c">get</span
            ><span style="color: #000">(packetAcknowledgementPath(packet</span
            >.<span style="color: #7c8e28">destPort</span>,
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">) </span>===
            <span style="color: #000">null))</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            connection <span style="color: #666">= </span>provableStore<span
              style="color: #666"
              >.</span
            ><span style="color: #05287c">get</span>(connectionPath(channel<span
              style="color: #666"
              >.</span
            ><span style="color: #7c8e28">connectionHops</span>[<span
              style="color: #3fa070"
              >0</span
            >])) abortTransactionUnless(connection
            <span style="color: #666">!== </span>null)
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #7c8e28">state </span
            ><span style="color: #666">=== </span>OPEN)
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(packet</span>.<span
              style="color: #7c8e28"
              >timeoutHeight </span
            >=== <span style="color: #3fa070">0 </span>||
            <span style="color: #000">getConsensusHeight() </span>&lt;
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutHeight</span
            ><span style="color: #000">) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">timeoutTimestamp </span>===
            <span style="color: #3fa070">0 </span>||
            <span style="color: #000">currentTimestamp() </span>&lt;
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000">) abortTransactionUnless(connection</span
            >.<span style="color: #05287c">verifyPacketData</span
            ><span style="color: #000">(</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proofHeight</span>,
            <span style="color: #000">proof</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >sourcePort</span
            >,
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            >,
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 10pt;
              text-align: left;
            "
          >
            <span style="color: #000">concat(packet</span>.<span
              style="color: #7c8e28"
              >data</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutHeight</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000">)</span>
          </p>
          <p
            class="s5"
            style="
              padding-top: 1pt;
              padding-left: 27pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            ))
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">if (acknowledgement</span>.<span
              style="color: #7c8e28"
              >length </span
            >&gt; <span style="color: #3fa070">0 </span>||
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >order </span
            >=== <span style="color: #000">UNORDERED) provableStore</span>.<span
              style="color: #05287c"
              >set</span
            ><span style="color: #000">(</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 48pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">packetAcknowledgementPath(packet</span
            >.<span style="color: #7c8e28">destPort</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">hash(acknowledgement)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            )
          </p>
          <p
            class="s6"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            <span style="color: #000">if (channel</span>.<span
              style="color: #7c8e28"
              >order </span
            >=== <span style="color: #000">ORDERED) {</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">nextSequenceRecv </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(nextSequenceRecvPath(packet</span>.<span
              style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            ><span style="color: #000">)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">sequence </span>===
            <span style="color: #000">nextSequenceRecv)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">nextSequenceRecv </span>=
            <span style="color: #000">nextSequenceRecv </span>+
            <span style="color: #3fa070">1 </span
            ><span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >set</span
            ><span style="color: #000">(nextSequenceRecvPath(packet</span>.<span
              style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">nextSequenceRecv)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            }
          </p>
          <p
            class="s5"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            return packet
          </p>
          <p
            class="s5"
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a name="bookmark74">}</a>
          </p>
        </li>
        <li>
          <p
            class="s4"
            style="
              padding-top: 3pt;
              padding-left: 21pt;
              text-indent: -14pt;
              text-align: left;
            "
          >
            Acknowledging a packet
          </p>
          <p
            class="s5"
            style="
              padding-top: 9pt;
              padding-left: 17pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">acknowledgePacket</span>( packet<span
              style="color: #666"
              >: </span
            >OpaquePacket<span style="color: #666">, </span>acknowledgement<span
              style="color: #666"
              >: </span
            >bytes<span style="color: #666">, </span>proof<span
              style="color: #666"
              >: </span
            >CommitmentProof<span style="color: #666">, </span>proofHeight<span
              style="color: #666"
              >: </span
            >uint64)<span style="color: #666">: </span>Packet {
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channel </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(channelPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)) abortTransactionUnless(channel </span
            >!== <span style="color: #000">null)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(channel</span
            >.<span style="color: #7c8e28">state </span>===
            <span style="color: #000"
              >OPEN) abortTransactionUnless(authenticateCapability(</span
            >
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channelCapabilityPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000"
              >capability)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">destPort </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyPortIdentifier</span
            ><span style="color: #000">) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">destChannel </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyChannelIdentifier</span
            ><span style="color: #000">) connection </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(connectionPath(channel</span>.<span
              style="color: #7c8e28"
              >connectionHops</span
            ><span style="color: #000">[</span
            ><span style="color: #3fa070">0</span
            ><span style="color: #000"
              >])) abortTransactionUnless(connection </span
            >!== <span style="color: #000">null)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(connection</span
            >.<span style="color: #7c8e28">state </span>===
            <span style="color: #000"
              >OPEN) abortTransactionUnless(provableStore</span
            >.<span style="color: #05287c">get</span
            ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >,
          </p>
          <p
            class="s6"
            style="
              padding-left: 48pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">))</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 36pt;
              line-height: 106%;
              text-align: left;
            "
          >
            === <span style="color: #000">hash(packet</span>.<span
              style="color: #7c8e28"
              >data</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutHeight</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000"
              >)) abortTransactionUnless(connection</span
            >.<span style="color: #05287c">verifyPacketAcknowledgement</span
            ><span style="color: #000">(</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proofHeight</span>,
            <span style="color: #000">proof</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            >, <span style="color: #000">acknowledgement</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            ))
          </p>
          <p
            class="s6"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            <span style="color: #000">if (channel</span>.<span
              style="color: #7c8e28"
              >order </span
            >=== <span style="color: #000">ORDERED) {</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">nextSequenceAck </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(nextSequenceAckPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">sequence </span>===
            <span style="color: #000">nextSequenceAck)</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            nextSequenceAck <span style="color: #666">= </span>nextSequenceAck
            <span style="color: #666">+ </span
            ><span style="color: #3fa070">1</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 10pt;
              text-align: left;
            "
          >
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >set</span
            ><span style="color: #000">(nextSequenceAckPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">nextSequenceAck)</span>
          </p>
          <p
            class="s5"
            style="
              padding-top: 1pt;
              padding-left: 27pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            }
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <a name="bookmark75"
              ><span style="color: #000">provableStore</span></a
            >.<span style="color: #05287c">delete</span
            ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">)) return packet</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 6pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            }
          </p>
        </li>
        <li>
          <p
            class="s4"
            style="
              padding-top: 3pt;
              padding-left: 21pt;
              text-indent: -14pt;
              text-align: left;
            "
          >
            Handling a timed-out packet
          </p>
          <p
            class="s5"
            style="
              padding-top: 10pt;
              padding-left: 17pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span class="h1">function </span
            ><span style="color: #05287c">timeoutPacket</span>( packet<span
              style="color: #666"
              >: </span
            >OpaquePacket<span style="color: #666">, </span>proof<span
              style="color: #666"
              >: </span
            >CommitmentProof<span style="color: #666">, </span>proofHeight<span
              style="color: #666"
              >: </span
            >uint64<span style="color: #666">,</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 17pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            nextSequenceRecv<span style="color: #666">: </span>Maybe<span
              style="color: #666"
              >&lt;</span
            >uint64<span style="color: #666">&gt;</span>)<span
              style="color: #666"
              >: </span
            >Packet {
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channel </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(channelPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)) abortTransactionUnless(channel </span
            >!== <span style="color: #000">null)</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">abortTransactionUnless(channel</span
            >.<span style="color: #7c8e28">state </span>===
            <span style="color: #000"
              >OPEN) abortTransactionUnless(authenticateCapability(</span
            >
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">channelCapabilityPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000"
              >capability)) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">destChannel </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyChannelIdentifier</span
            ><span style="color: #000">) connection </span>=
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >get</span
            ><span style="color: #000">(connectionPath(channel</span>.<span
              style="color: #7c8e28"
              >connectionHops</span
            ><span style="color: #000">[</span
            ><span style="color: #3fa070">0</span
            ><span style="color: #000">])) abortTransactionUnless(packet</span
            >.<span style="color: #7c8e28">destPort </span>===
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >counterpartyPortIdentifier</span
            ><span style="color: #000">) abortTransactionUnless(</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">(packet</span>.<span
              style="color: #7c8e28"
              >timeoutHeight </span
            >&gt; <span style="color: #3fa070">0 </span>&amp;&amp;
            <span style="color: #000">proofHeight </span>&gt;=
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutHeight</span
            ><span style="color: #000">) </span>||
            <span style="color: #000">(packet</span>.<span
              style="color: #7c8e28"
              >timeoutTimestamp </span
            >&gt; <span style="color: #3fa070">0 </span>&amp;&amp;
          </p>
          <p
            class="s6"
            style="
              padding-top: 5pt;
              padding-left: 27pt;
              text-indent: 31pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">connection</span>.<span
              style="color: #05287c"
              >getTimestampAtHeight</span
            ><span style="color: #000">(proofHeight) </span>&gt;
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000"
              >)) abortTransactionUnless(provableStore</span
            >.<span style="color: #05287c">get</span
            ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >,
          </p>
          <p
            class="s6"
            style="
              padding-left: 48pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">))</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 36pt;
              line-height: 106%;
              text-align: left;
            "
          >
            === <span style="color: #000">hash(packet</span>.<span
              style="color: #7c8e28"
              >data</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutHeight</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >timeoutTimestamp</span
            ><span style="color: #000">)) if channel</span>.<span
              style="color: #7c8e28"
              >order </span
            >=== <span style="color: #000">ORDERED {</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            abortTransactionUnless(nextSequenceRecv
            <span style="color: #666">&lt;= </span>packet<span
              style="color: #666"
              >.</span
            ><span style="color: #7c8e28">sequence</span>)
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #05287c">verifyNextSequenceRecv</span>(
          </p>
          <p
            class="s6"
            style="
              padding-left: 48pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proofHeight</span>,
            <span style="color: #000">proof</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            >, <span style="color: #000">nextSequenceRecv</span>
          </p>
          <p
            class="s5"
            style="
              padding-left: 25pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: center;
            "
          >
            ))
          </p>
          <p
            class="s5"
            style="padding-left: 25pt; text-indent: 0pt; text-align: center"
          >
            } else
          </p>
          <p
            class="s5"
            style="
              padding-left: 48pt;
              text-indent: -10pt;
              line-height: 106%;
              text-align: left;
            "
          >
            abortTransactionUnless(connection<span style="color: #666">.</span
            ><span style="color: #05287c"
              >verifyPacketAcknowledgementAbsence</span
            >( proofHeight<span style="color: #666">,</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 48pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">proof</span>,
            <span style="color: #000">packet</span>.<span style="color: #7c8e28"
              >destPort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >destChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            >
          </p>
          <p
            class="s5"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            ))
          </p>
          <p
            class="s6"
            style="
              padding-left: 27pt;
              text-indent: 0pt;
              line-height: 106%;
              text-align: left;
            "
          >
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >delete</span
            ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sequence</span
            ><span style="color: #000">)) if channel</span>.<span
              style="color: #7c8e28"
              >order </span
            >=== <span style="color: #000">ORDERED {</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 11pt;
              text-align: left;
            "
          >
            <span style="color: #000">channel</span>.<span
              style="color: #7c8e28"
              >state </span
            >= <span style="color: #000">CLOSED</span>
          </p>
          <p
            class="s6"
            style="
              padding-left: 38pt;
              text-indent: 0pt;
              line-height: 10pt;
              text-align: left;
            "
          >
            <span style="color: #000">provableStore</span>.<span
              style="color: #05287c"
              >set</span
            ><span style="color: #000">(channelPath(packet</span>.<span
              style="color: #7c8e28"
              >sourcePort</span
            >, <span style="color: #000">packet</span>.<span
              style="color: #7c8e28"
              >sourceChannel</span
            ><span style="color: #000">)</span>,
            <span style="color: #000">channel)</span>
          </p>
          <p
            class="s5"
            style="
              padding-top: 1pt;
              padding-left: 27pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            }
          </p>
          <p
            class="s5"
            style="padding-left: 27pt; text-indent: 0pt; text-align: left"
          >
            <a name="bookmark76">return packet</a
            ><a name="bookmark77">&zwnj;</a>
          </p>
          <p
            class="s5"
            style="padding-left: 6pt; text-indent: 0pt; text-align: left"
          >
            }
          </p>
        </li>
        <li>
          <p
            class="s4"
            style="
              padding-top: 3pt;
              padding-left: 21pt;
              text-indent: -14pt;
              text-align: left;
            "
          >
            Cleaning up packet data
          </p>
        </li>
      </ol>
      <p
        class="s5"
        style="
          padding-top: 10pt;
          padding-left: 17pt;
          text-indent: -10pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span class="h1">function </span
        ><span style="color: #05287c">cleanupPacket</span>( packet<span
          style="color: #666"
          >: </span
        >OpaquePacket<span style="color: #666">, </span>proof<span
          style="color: #666"
          >: </span
        >CommitmentProof<span style="color: #666">, </span>proofHeight<span
          style="color: #666"
          >: </span
        >uint64<span style="color: #666">,</span>
      </p>
      <p
        class="s5"
        style="
          padding-left: 17pt;
          text-indent: 0pt;
          line-height: 11pt;
          text-align: left;
        "
      >
        nextSequenceRecvOrAcknowledgement<span style="color: #666">: </span
        >Either<span style="color: #666">&lt;</span>uint64<span
          style="color: #666"
          >, </span
        >bytes<span style="color: #666">&gt;</span>)<span style="color: #666"
          >: </span
        >Packet {
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">channel </span>=
        <span style="color: #000">provableStore</span>.<span
          style="color: #05287c"
          >get</span
        ><span style="color: #000">(channelPath(packet</span>.<span
          style="color: #7c8e28"
          >sourcePort</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sourceChannel</span
        ><span style="color: #000">)) abortTransactionUnless(channel </span>!==
        <span style="color: #000">null)</span>
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">abortTransactionUnless(channel</span>.<span
          style="color: #7c8e28"
          >state </span
        >===
        <span style="color: #000"
          >OPEN) abortTransactionUnless(authenticateCapability(</span
        >
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 10pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">channelCapabilityPath(packet</span>.<span
          style="color: #7c8e28"
          >sourcePort</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sourceChannel</span
        ><span style="color: #000">)</span>,
        <span style="color: #000"
          >capability)) abortTransactionUnless(packet</span
        >.<span style="color: #7c8e28">destChannel </span>===
        <span style="color: #000">channel</span>.<span style="color: #7c8e28"
          >counterpartyChannelIdentifier</span
        ><span style="color: #000">) connection </span>=
        <span style="color: #000">provableStore</span>.<span
          style="color: #05287c"
          >get</span
        ><span style="color: #000">(connectionPath(channel</span>.<span
          style="color: #7c8e28"
          >connectionHops</span
        ><span style="color: #000">[</span><span style="color: #3fa070">0</span
        ><span style="color: #000">])) abortTransactionUnless(connection </span
        >!== <span style="color: #000">null)</span>
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">abortTransactionUnless(packet</span>.<span
          style="color: #7c8e28"
          >destPort </span
        >=== <span style="color: #000">channel</span>.<span
          style="color: #7c8e28"
          >counterpartyPortIdentifier</span
        ><span style="color: #000"
          >) abortTransactionUnless(nextSequenceRecv </span
        >&gt; <span style="color: #000">packet</span>.<span
          style="color: #7c8e28"
          >sequence</span
        ><span style="color: #000">) abortTransactionUnless(provableStore</span
        >.<span style="color: #05287c">get</span
        ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
          style="color: #7c8e28"
          >sourcePort</span
        >,
      </p>
      <p
        class="s6"
        style="
          padding-left: 48pt;
          text-indent: 0pt;
          line-height: 11pt;
          text-align: left;
        "
      >
        <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sourceChannel</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sequence</span
        ><span style="color: #000">))</span>
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 57pt;
          line-height: 106%;
          text-align: left;
        "
      >
        === <span style="color: #000">hash(packet</span>.<span
          style="color: #7c8e28"
          >data</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >timeoutHeight</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >timeoutTimestamp</span
        ><span style="color: #000">)) if channel</span>.<span
          style="color: #7c8e28"
          >order </span
        >=== <span style="color: #000">ORDERED</span>
      </p>
      <p
        class="s5"
        style="
          padding-left: 48pt;
          text-indent: -10pt;
          line-height: 106%;
          text-align: left;
        "
      >
        abortTransactionUnless(connection<span style="color: #666">.</span
        ><span style="color: #05287c">verifyNextSequenceRecv</span>(
        proofHeight<span style="color: #666">,</span>
      </p>
      <p
        class="s6"
        style="
          padding-left: 48pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">proof</span>,
        <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >destPort</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >destChannel</span
        >,
      </p>
      <p
        class="s5"
        style="
          padding-left: 48pt;
          text-indent: 0pt;
          line-height: 10pt;
          text-align: left;
        "
      >
        nextSequenceRecvOrAcknowledgement
      </p>
      <p
        class="s5"
        style="
          padding-top: 1pt;
          padding-left: 38pt;
          text-indent: 0pt;
          text-align: left;
        "
      >
        ))
      </p>
      <p
        class="s5"
        style="
          padding-top: 5pt;
          padding-left: 27pt;
          text-indent: 0pt;
          text-align: left;
        "
      >
        else
      </p>
      <p
        class="s5"
        style="
          padding-left: 48pt;
          text-indent: -10pt;
          line-height: 106%;
          text-align: left;
        "
      >
        abortTransactionUnless(connection<span style="color: #666">.</span
        ><span style="color: #05287c">verifyPacketAcknowledgement</span>(
        proofHeight<span style="color: #666">,</span>
      </p>
      <p
        class="s6"
        style="
          padding-left: 48pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">proof</span>,
        <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >destPort</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >destChannel</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sequence</span
        >,
      </p>
      <p
        class="s5"
        style="
          padding-left: 48pt;
          text-indent: 0pt;
          line-height: 10pt;
          text-align: left;
        "
      >
        nextSequenceRecvOrAcknowledgement
      </p>
      <p
        class="s5"
        style="
          padding-top: 1pt;
          padding-left: 38pt;
          text-indent: 0pt;
          text-align: left;
        "
      >
        ))
      </p>
      <p
        class="s6"
        style="
          padding-left: 27pt;
          text-indent: 0pt;
          line-height: 106%;
          text-align: left;
        "
      >
        <span style="color: #000">provableStore</span>.<span
          style="color: #05287c"
          >delete</span
        ><span style="color: #000">(packetCommitmentPath(packet</span>.<span
          style="color: #7c8e28"
          >sourcePort</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sourceChannel</span
        >, <span style="color: #000">packet</span>.<span style="color: #7c8e28"
          >sequence</span
        ><span style="color: #000">)) return packet</span>
      </p>
      <p
        class="s5"
        style="
          padding-left: 6pt;
          text-indent: 0pt;
          line-height: 11pt;
          text-align: left;
        "
      >
        }
      </p>
      <p
        style="
          padding-top: 5pt;
          padding-left: 103pt;
          text-indent: 0pt;
          text-align: left;
        "
      >
        References
      </p>
      <ol id="l35">
        <li>
          <p
            style="
              padding-top: 3pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a
              href="https://research.web3.foundation/en/latest/polkadot/XCMP.html"
              class="a"
              target="_blank"
              >Alistair Stewart and Fatemeh Shirazi and Leon Groot Bruinderink,
              “Web3 foundation research: XCMP.”
              https://research.web3.foundation/en/latest/polkadot/ </a
            >XCMP.html, May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a
              href="https://notes.ethereum.org/%40serenity/H1PGqDhpm?type=view&amp;Cross-shard-communication"
              class="a"
              target="_blank"
              >E. 2.0 Contributors, “Ethereum sharding research compendium:
              Cross-shard communication.”
              https://notes.ethereum.org/@serenity/H1PGqDhpm? </a
            >type=view#Cross-shard-communication, 2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://medium.com/nearprotocol/unsolved-problems-in-blockchain-sharding-2327d6517f43"
              class="a"
              target="_blank"
              >Near Protocol, “The authoritative guide to blockchain sharding:
              Part 2.” https://medium.com/nearprotocol/ </a
            >unsolved-problems-in-blockchain-sharding-2327d6517f43, Dec-2018.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            “Transmission Control Protocol.” RFC 793; RFC Editor, Sep-1981.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 25pt;
              text-indent: -19pt;
              text-align: left;
            "
          >
            <a
              href="http://habitatchronicles.com/2017/05/what-are-capabilities/"
              class="a"
              target="_blank"
              >C. Morningstar, “What are capabilities?” </a
            ><a
              href="http://habitatchronicles.com/2017/05/what-are-capabilities/"
              target="_blank"
              >http:</a
            >
          </p>
          <p style="padding-left: 6pt; text-indent: 0pt; text-align: left">
            //habitatchronicles.com/2017/05/what-are-capabilities/, 2017.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://cdn.codaprotocol.com/v2/static/coda-whitepaper-05-10-2018-0.pdf"
              class="a"
              target="_blank"
              >I. Meckler and E. Shapiro, “Coda: Decentralized cryp- tocurrency
              at scale.” https://cdn.codaprotocol.com/v2/ </a
            >static/coda-whitepaper-05-10-2018-0.pdf, 2018.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            S. Nakamoto, “Bitcoin: A peer-to-peer electronic cash system.” 2009.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://tendermint.com/static/docs/tendermint.pdf"
              class="a"
              target="_blank"
              >Jae Kwon, “Tendermint: Consensus without mining.” </a
            >https://tendermint.com/static/docs/tendermint.pdf, Sep- 2014.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a
              href="https://github.com/w3f/consensus/blob/master/pdf/grandpa.pdf"
              class="a"
              target="_blank"
              >Alistair Stewart, “GRANDPA finality gadget.”
              https://github.com/w3f/consensus/blob/master/pdf/ </a
            >grandpa.pdf, May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 26pt;
              text-indent: -19pt;
              text-align: left;
            "
          >
            M. Yin, D. Malkhi, M. K. Reiter, G. G. Gueta, and
          </p>
          <p style="padding-left: 6pt; text-indent: 0pt; text-align: justify">
            <a href="https://arxiv.org/pdf/1803.05069" class="a" target="_blank"
              >I. Abraham, “HotStuff: BFT consensus in the lens of blockchain.”
              https://arxiv.org/pdf/1803.05069,</a
            >
            2018.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 1pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/tendermint/iavl"
              class="a"
              target="_blank"
              >Tendermint, “IAVL+ tree: A versioned, snapshottable (immutable)
              avl+ tree for persistent data.” https://github. </a
            >com/tendermint/iavl, 2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/ethereum/wiki/wiki/Patricia-Tree"
              class="a"
              target="_blank"
              >Ethereum, “Ethereum modified merkle patricia trie specification.”
              https://github.com/ethereum/wiki/wiki/ Patricia-Tree,</a
            >
            2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: left;
            "
          >
            <a
              href="https://github.com/cosmos/cosmos-sdk/tree/master/x/ibc"
              class="a"
              target="_blank"
              >Cosmos SDK Contributors, “The cosmos sdk: X/ibc.”
              https://github.com/cosmos/cosmos-sdk/tree/master/x/ ibc,</a
            >
            May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/informalsystems/ibc-rs"
              class="a"
              target="_blank"
              >Informal Systems, “Rust implementation of ibc mod- ules and
              relayer.” https://github.com/informalsystems/ ibc-rs,</a
            >
            May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/iqlusioninc/relayer"
              class="a"
              target="_blank"
              >Iqlusion, “Server-side ibc relayer.” https://github.com/
              iqlusioninc/relayer,</a
            >
            May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a href="https://goz.cosmosnetwork.dev/" class="a" target="_blank"
              >GoZ Contributors, “Game of zones.” https://goz.
              cosmosnetwork.dev/,</a
            >
            May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a href="https://mapofzones.com/" class="a" target="_blank"
              >Bitquasar &amp; Ztake, “Map of zones.” https://
              mapofzones.com/,</a
            >
            May-2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/paritytech/substrate"
              class="a"
              target="_blank"
              >P. Technologies, “Substrate: The platform for blockchain
              innovators.” https://github.com/paritytech/ substrate,</a
            >
            2020.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 5pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://cosmos.network/cosmos-whitepaper.pdf"
              class="a"
              target="_blank"
              >Jae Kwon, Ethan Buchman, “Cosmos: A net- work of distributed
              ledgers.” https://cosmos.network/ </a
            >cosmos-whitepaper.pdf, Sep-2016.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 5pt;
              padding-left: 6pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a href="https://arxiv.org/pdf/1807.04938" class="a" target="_blank"
              >Ethan Buchman, Jae Kwon, Zarko Milosevic, “The latest gossip on
              bft consensus.” https://arxiv.org/pdf/1807. 04938,</a
            >
            Nov-2019.
          </p>
        </li>
        <li>
          <p
            style="
              padding-top: 6pt;
              padding-left: 5pt;
              text-indent: 0pt;
              text-align: justify;
            "
          >
            <a
              href="https://github.com/cosmos/ics/blob/master/archive/v0_3_1_IBC.pdf"
              class="a"
              target="_blank"
              >Ethan Frey, “IBC protocol specification v0.3.1.”
              https://github.com/cosmos/ics/blob/master/archive/v0_ </a
            >3_1_IBC.pdf, Nov-2017.
          </p>
        </li>
      </ol>
    </body>
  </div>
</template>

<script>
// import NewsletterForm from '~/components/ContentSections/NewsletterForm'

export default {
  //   components: { NewsletterForm },

  props: {
    content: {
      type: Object,
      required: true,
    },
  },

  data() {
    return {
      showForm: false,
    }
  },

  computed: {
    isNarrow() {
      return window.innerWidth < 768
    },
  },
}
</script>

<!--
<style scoped type="text/css">
* {
  margin: 0;
  padding: 0;
  text-indent: 0;
  color: white;
}
.s1 {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 25pt;
}
.s2 {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.p,
p {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
  margin: 0pt;
}
.a,
a {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s3 {
  color: white;
  font-family: Georgia-BoldItalic, serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 10pt;
}
.h2 {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 10pt;
}
.s4 {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s5 {
  color: white;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s6 {
  color: #666;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s8 {
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s9 {
  color: white;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
.s10 {
  color: white;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
  vertical-align: 3pt;
}
.s11 {
  color: white;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 10pt;
}
.h1 {
  color: #007021;
  font-family: 'Courier New', serif;
  font-style: normal;
  font-weight: bold;
  text-decoration: none;
  font-size: 15pt;
}
li {
  display: block;
}
#l1 {
  padding-left: 0pt;
  counter-reset: c1 1;
}
#l1 > li > *:first-child:before {
  counter-increment: c1;
  content: counter(c1, upper-roman) '. ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l1 > li:first-child > *:first-child:before {
  counter-increment: c1 0;
}
#l2 {
  padding-left: 0pt;
  counter-reset: d1 1;
}
#l2 > li > *:first-child:before {
  counter-increment: d1;
  content: counter(d1, upper-latin) '. ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l2 > li:first-child > *:first-child:before {
  counter-increment: d1 0;
}
#l3 {
  padding-left: 0pt;
  counter-reset: e1 1;
}
#l3 > li > *:first-child:before {
  counter-increment: e1;
  content: counter(e1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l3 > li:first-child > *:first-child:before {
  counter-increment: e1 0;
}
#l4 {
  padding-left: 0pt;
  counter-reset: f1 1;
}
#l4 > li > *:first-child:before {
  counter-increment: f1;
  content: counter(f1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l4 > li:first-child > *:first-child:before {
  counter-increment: f1 0;
}
#l5 {
  padding-left: 0pt;
}
#l5 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l6 {
  padding-left: 0pt;
  counter-reset: g1 1;
}
#l6 > li > *:first-child:before {
  counter-increment: g1;
  content: counter(g1, upper-latin) '. ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l6 > li:first-child > *:first-child:before {
  counter-increment: g1 0;
}
#l7 {
  padding-left: 0pt;
  counter-reset: h1 1;
}
#l7 > li > *:first-child:before {
  counter-increment: h1;
  content: counter(h1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l7 > li:first-child > *:first-child:before {
  counter-increment: h1 0;
}
#l8 {
  padding-left: 0pt;
  counter-reset: h2 1;
}
#l8 > li > *:first-child:before {
  counter-increment: h2;
  content: counter(h2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l8 > li:first-child > *:first-child:before {
  counter-increment: h2 0;
}
#l9 {
  padding-left: 0pt;
  counter-reset: h2 1;
}
#l9 > li > *:first-child:before {
  counter-increment: h2;
  content: counter(h2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l9 > li:first-child > *:first-child:before {
  counter-increment: h2 0;
}
#l10 {
  padding-left: 0pt;
  counter-reset: i1 1;
}
#l10 > li > *:first-child:before {
  counter-increment: i1;
  content: counter(i1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l10 > li:first-child > *:first-child:before {
  counter-increment: i1 0;
}
#l11 {
  padding-left: 0pt;
}
#l11 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l12 {
  padding-left: 0pt;
}
#l12 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l13 {
  padding-left: 0pt;
  counter-reset: k1 1;
}
#l13 > li > *:first-child:before {
  counter-increment: k1;
  content: counter(k1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l13 > li:first-child > *:first-child:before {
  counter-increment: k1 0;
}
#l14 {
  padding-left: 0pt;
}
#l14 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l15 {
  padding-left: 0pt;
  counter-reset: k2 1;
}
#l15 > li > *:first-child:before {
  counter-increment: k2;
  content: counter(k2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l15 > li:first-child > *:first-child:before {
  counter-increment: k2 0;
}
#l16 {
  padding-left: 0pt;
  counter-reset: k2 1;
}
#l16 > li > *:first-child:before {
  counter-increment: k2;
  content: counter(k2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l16 > li:first-child > *:first-child:before {
  counter-increment: k2 0;
}
#l17 {
  padding-left: 0pt;
}
#l17 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l18 {
  padding-left: 0pt;
}
#l18 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l19 {
  padding-left: 0pt;
  counter-reset: k2 1;
}
#l19 > li > *:first-child:before {
  counter-increment: k2;
  content: counter(k2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l19 > li:first-child > *:first-child:before {
  counter-increment: k2 0;
}
#l20 {
  padding-left: 0pt;
}
#l20 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l21 {
  padding-left: 0pt;
  counter-reset: k2 1;
}
#l21 > li > *:first-child:before {
  counter-increment: k2;
  content: counter(k2, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l21 > li:first-child > *:first-child:before {
  counter-increment: k2 0;
}
#l22 {
  padding-left: 0pt;
}
#l22 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l23 {
  padding-left: 0pt;
  counter-reset: o1 1;
}
#l23 > li > *:first-child:before {
  counter-increment: o1;
  content: counter(o1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l23 > li:first-child > *:first-child:before {
  counter-increment: o1 0;
}
#l24 {
  padding-left: 0pt;
}
#l24 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l25 {
  padding-left: 0pt;
  counter-reset: p1 1;
}
#l25 > li > *:first-child:before {
  counter-increment: p1;
  content: counter(p1, lower-latin) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l25 > li:first-child > *:first-child:before {
  counter-increment: p1 0;
}
#l26 {
  padding-left: 0pt;
  counter-reset: q1 1;
}
#l26 > li > *:first-child:before {
  counter-increment: q1;
  content: counter(q1, upper-latin) '. ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l26 > li:first-child > *:first-child:before {
  counter-increment: q1 0;
}
#l27 {
  padding-left: 0pt;
}
#l27 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l28 {
  padding-left: 0pt;
  counter-reset: s1 1;
}
#l28 > li > *:first-child:before {
  counter-increment: s1;
  content: counter(s1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l28 > li:first-child > *:first-child:before {
  counter-increment: s1 0;
}
#l29 {
  padding-left: 0pt;
}
#l29 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
#l30 {
  padding-left: 0pt;
}
#l30 > li > *:first-child:before {
  content: '• ';
  color: white;
  font-family: Arial, sans-serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 7pt;
}
li {
  display: block;
}
#l31 {
  padding-left: 0pt;
  counter-reset: t1 1;
}
#l31 > li > *:first-child:before {
  counter-increment: t1;
  content: counter(t1, upper-latin) '. ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l31 > li:first-child > *:first-child:before {
  counter-increment: t1 0;
}
#l32 {
  padding-left: 0pt;
  counter-reset: u1 1;
}
#l32 > li > *:first-child:before {
  counter-increment: u1;
  content: counter(u1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l32 > li:first-child > *:first-child:before {
  counter-increment: u1 0;
}
#l33 {
  padding-left: 0pt;
  counter-reset: v1 1;
}
#l33 > li > *:first-child:before {
  counter-increment: v1;
  content: counter(v1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l33 > li:first-child > *:first-child:before {
  counter-increment: v1 0;
}
li {
  display: block;
}
#l34 {
  padding-left: 0pt;
  counter-reset: w1 1;
}
#l34 > li > *:first-child:before {
  counter-increment: w1;
  content: counter(w1, decimal) ') ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: italic;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l34 > li:first-child > *:first-child:before {
  counter-increment: w1 0;
}
li {
  display: block;
}
#l35 {
  padding-left: 0pt;
  counter-reset: x1 1;
}
#l35 > li > *:first-child:before {
  counter-increment: x1;
  content: '[' counter(x1, decimal) '] ';
  color: white;
  font-family: 'Times New Roman', serif;
  font-style: normal;
  font-weight: normal;
  text-decoration: none;
  font-size: 15pt;
}
#l35 > li:first-child > *:first-child:before {
  counter-increment: x1 0;
}
table,
tbody {
  vertical-align: top;
  overflow: visible;
}
</style>
-->
