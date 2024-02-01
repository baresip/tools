# SIPp - Protocol and jitter testing

## Build

```bash
git clone https://github.com/SIPp/sipp
cd sipp
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
