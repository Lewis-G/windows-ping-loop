# windows-ping-loop
Ping all IP addresses within a given range
This is useful when nmap and other scripting languages are not available

### Arguements:
1. First octet (The start and ending IP address must have the same first octet)
2. Remainder of starting IP Address
3. Remainder of ending IP Address
4. Number of packets sent to each address (optional)

### Execution example:

`ping-loop.bat 192 168.1.1 168.1.10 2`

Pings all addresses between the start and end addresses (inclusive) with 2 packets

Execute this command from the same directory as the .bat file