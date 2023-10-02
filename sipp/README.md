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
sudo build/sipp -sf scenarios/uac_pcap.xml 127.0.0.1 -m 1
```

## PCAP's

### Manipulating

Reorder

```bash
editcap -r g711a.pcap tmp1 2-3 # dump packets 2-3
editcap -r -t 0.07 g711a.pcap tmp2 1 # dump packet 1 and manipulate timestamp
editcap g711a.pcap tmp3 1-3 # exclude packets 1-3
mergecap -w out.pcap -a tmp1 tmp2 tmp3
```

Drop

```bash
editcap g711a.pcap out.pcap 2-3 # drop packets 2-3
```
