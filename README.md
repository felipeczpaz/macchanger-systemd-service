# macchanger-systemd-service

A systemd service for Arch Linux that automatically randomizes the MAC address of a specified network interface at boot using `macchanger`.

## Features

- Randomizes the MAC address of a specified network interface on system boot.
- Simple and easy to configure.
- Uses `macchanger` to change the MAC address.

## Prerequisites

- Arch Linux
- `macchanger` installed

You can install `macchanger` using the following command:

```bash
sudo pacman -S macchanger
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/felipeczpaz/macchanger-systemd-service.git
cd macchanger-systemd-service
```

2. Create the randomize-mac.sh script: Create a script in ```/usr/local/bin/```:

```bash
sudo nano /usr/local/bin/randomize-mac.sh
```

Copy and paste the following content into the script, replacing eth0 with your actual network interface name:

```bash
#!/bin/bash

# Replace 'eth0' with your network interface name
INTERFACE="eth0"

# Bring the interface down
ip link set $INTERFACE down

# Change the MAC address
macchanger -r $INTERFACE

# Bring the interface back up
ip link set $INTERFACE up
```

Make the script executable: 

```bash
sudo chmod +x /usr/local/bin/randomize-mac.sh
```

3. Create the systemd service: Create a service file in ```/etc/systemd/system/```:

```bash
sudo nano /etc/systemd/system/randomize-mac.service
```

Add the following content: 

```ini
[Unit]
Description=Randomize MAC Address
After=network.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/randomize-mac.sh
RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
```

4. Enable the service:

```bash
sudo systemctl enable randomize-mac.service
```

5. Start the service (optional): You can start the service immediately without rebooting:

```bash
sudo systemctl start randomize-mac.service
```

## Verification

To check the status of the service, run:

```bash
sudo systemctl status randomize-mac.service
```

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Contributing

Feel free to submit issues or pull requests if you have suggestions or improvements!
