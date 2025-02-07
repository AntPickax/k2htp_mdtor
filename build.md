---
layout: contents
language: en-us
title: Build
short_desc: K2Hash Transaction Plugin for Multiple Distributed Transaction Of Repeater
lang_opp_file: buildja.html
lang_opp_word: To Japanese
prev_url: usage.html
prev_string: Usage
top_url: index.html
top_string: TOP
next_url: 
next_string: 
---

# Build

This chapter consists of three parts:

* how to set up **k2htp_mdtor**(aka **K2HTPMDTOR**) for local development
* how to build **K2HTPMDTOR** from the source code
* how to install **K2HTPMDTOR**.

## 1. Install prerequisites

**K2HTPMDTOR** primarily depends on FULLOCK](https://fullock.antpick.ax/index.html), [K2HASH](https://k2hash.antpick.ax/index.html), and [CHMPX](https://chmpx.antpick.ax/index.html). Each dependent library and the header files are required to build **K2HTPMDTOR**. We provide two ways to install them. You can select your favorite one.

* Use [GitHub](https://github.com/yahoojapan)  
  Install the source code of dependent libraries and the header files. You will **build** them and install them.
* Use [packagecloud.io](https://packagecloud.io/antpickax/stable/)  
  Install packages of dependent libraries and the header files. You just install them. Libraries are already built.

### 1.1. Install each dependent library and the header files from GitHub

Read the following documents for details:

* [FULLOCK](https://fullock.antpick.ax/build.html)
* [K2HASH](https://k2hash.antpick.ax/build.html)
* [CHMPX](https://chmpx.antpick.ax/build.html)

### 1.2. Install each dependent library and the header files from packagecloud.io

This section instructs how to install each dependent library and the header files from Use [packagecloud.io](https://packagecloud.io/antpickax/stable/).

Note: Skip reading this section if you have installed each dependent library and the header files from [GitHub](https://github.com/yahoojapan) in the previous section.

For recent Debian-based Linux distributions users, follow the steps below:
```bash
$ sudo apt-get update -y
$ sudo apt-get install curl -y
$ curl -s https://packagecloud.io/install/repositories/antpickax/stable/script.deb.sh \
    | sudo bash
$ sudo apt-get install autoconf autotools-dev gcc g++ make gdb libtool pkg-config \
    libyaml-dev libfullock-dev k2hash-dev chmpx-dev -y
$ sudo apt-get install git -y
```

For users who use supported Fedora other than latest version, follow the steps below:
```bash
$ sudo dnf makecache
$ sudo dnf install curl -y
$ curl -s https://packagecloud.io/install/repositories/antpickax/stable/script.rpm.sh \
    | sudo bash
$ sudo dnf install autoconf automake gcc gcc-c++ gdb make libtool pkgconfig \
    libyaml-devel libfullock-devel k2hash-devel chmpx-devel -y
$ sudo dnf install git -y
```

For other recent RPM-based Linux distributions users, follow the steps below:
```bash
$ sudo yum makecache
$ sudo yum install curl -y
$ curl -s https://packagecloud.io/install/repositories/antpickax/stable/script.rpm.sh \
    | sudo bash
$ sudo yum install autoconf automake gcc gcc-c++ gdb make libtool pkgconfig \
    libyaml-devel libfullock-devel k2hash-devel chmpx-devel -y
$ sudo yum install git -y
```

## 2. Clone the source code from GitHub

Download the **K2HTPMDTOR**'s source code from [GitHub](https://github.com/).
```bash
$ git clone https://github.com/yahoojapan/k2htp_mdtor.git
```

## 3. Build and install

Just follow the steps below to build **K2HTPMDTOR** and install it. We use [GNU Automake](https://www.gnu.org/software/automake/) to build **K2HTPMDTOR**.
```bash
$ cd k2htp_mdtor
$ sh autogen.sh
$ ./configure --prefix=/usr
$ make
$ sudo make install
```

After successfully installing **K2HTPMDTOR**, you will see the manual page for **K2HTPMDTOR**:
```bash
$ man k2htpmdtor
```
