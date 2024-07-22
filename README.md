<h1 align="center"> <code>usbdrivetools</code> - USB Drive Tools </h1>

Simple bash tools that aim to help transfer files to USB Drive and monitor their syncing progress. 

Solving, so called, [USB-stick stall problem](https://lwn.net/Articles/572911/) (when files aren't fully copied even though they appear so on USB Drive).

------------

Requirements:
- `rsync` (for file transfer progress)

Tools available:
- `usbcp` - USB Drive enhanced copy
- `usbmv` - USB Drive enhanced move
- `usbdd` - USB Drive enhanced ISO image writing tool

-----

## Installation

Clone the repo:

    git clone git@github.com:satk0/usbdrivetools.git

Symlink scripts to `~/.local/bin/` (run from project directory):

    ln -s "$PWD"/scripts/* ~/.local/bin/

-----

## Demonstration

![](https://github.com/satk0/usbdrivetools/blob/main/assets/usbcp.gif)

------

<p align="center"> Made with Love ❤️ </p>
