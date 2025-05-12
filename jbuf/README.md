# SIPp - Protocol and jitter testing

## Build

```bash
git clone https://github.com/SIPp/sipp
cd sipp
git checkout v3.7.2
cmake -B build -DUSE_PCAP=1
cmake --build build -j
```

## Usage

```bash
sudo sipp/build/sipp -sf scenarios/uac_pcap_opus.xml 127.0.0.1 -m 1 -key pcap pcap/opus_audio_500hz_linux_qdisc_delay_50ms.pcap
```

## PCAP's

### Manipulating

#### Reorder

```bash
editcap -r g711a.pcap tmp1 2-3 # dump packets 2-3
editcap -r -t 0.07 g711a.pcap tmp2 1 # dump packet 1 and manipulate timestamp
editcap g711a.pcap tmp3 1-3 # exclude packets 1-3
mergecap -w out.pcap -a tmp1 tmp2 tmp3
```
#### Drop

```bash
editcap g711a.pcap out.pcap 2-3 # drop packets 2-3
```

#### Remove TURN (4 Bytes, Offset 42 Bytes) encapsulation

editcap -L -C42:4 in.pcap tmp.pcap
./pcap_fix_udp_len.py tmp.pcap out.pcap 4


### Text2pcap

text2pcap is useful for debugging encrypted connections like DTLS_SRTP from application context.

See: https://blog.mozilla.org/webrtc/debugging-encrypted-rtp-is-more-fun-than-it-used-to-be/

#### Build options (libre and baresip)

Needs at least baresip v3.10.0 (current main)
```bash
cmake -B build -DUSE_TRACE=ON -DCMAKE_C_FLAGS="-DRE_RTP_PCAP"
cmake --build build
```

#### Text2pcap dump

Start baresip and connections normally. Traces are written to `re_trace.json` after exit you can extract the pcap traces with `jq` and `text2pcap`:

```bash
jq -r ".traceEvents[] | select (.cat == \"pcap\") | .args.pcap" re_trace.json | text2pcap -D -n -l1 -i17 -u 1000,2000 -t '%H:%M:%S.%f' - dump.pcapng

```

Big re_trace.json files can be streamed like this

```bash
jq -r --stream "select(.[0][3] == \"pcap\" and .[1] != null) | .[1]" re_trace.json | text2pcap -D -n -l1 -i17 -u 1000,2000 -t '%H:%M:%S.%f' - dump.pcapng
```

The dump can now be opened with `wireshark`:
```bash
wireshark dump.pcapng
```

