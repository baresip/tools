#!/usr/bin/env python

import argparse
from scapy.all import *

def update_bytes_from_packet(packet, rbytes):
    if UDP in packet:
        # Check if the packet contains a UDP layer
        packet[UDP].len = packet[UDP].len - int(rbytes)
        packet[IP].len = packet[IP].len - int(rbytes)
        packet[UDP].chksum = None  # Recalculate UDP checksum
        packet[IP].chksum = None  # Recalculate IP checksum

def main():
    parser = argparse.ArgumentParser(description="Update IP/UDP length.")
    parser.add_argument("input_file", help="Input PCAP file")
    parser.add_argument("output_file", help="Output PCAP file")
    parser.add_argument("rbytes", help="bytes to remove")

    args = parser.parse_args()

    # Load the PCAP file
    packets = rdpcap(args.input_file)

    for packet in packets:
            update_bytes_from_packet(packet, args.rbytes)

    # Save the modified PCAP file
    wrpcap(args.output_file, packets)

    print("PCAP file successfully modified and saved as", args.output_file)

if __name__ == "__main__":
    main()
