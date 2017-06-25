title: 黑苹果删除多余的clover启动项
date: 2016-5-9 22:19:43
categories: Hackinston
toc: true
tags:
- Hackinston
- Clover
---
自己配了一台台式机，在安装黑苹果后，每次开机在BIOS中就会新增一个启动项，电脑几天用下来都多出来几十个启动项。于是Google好久才找到解决办法。于是记录一下。
<!--more-->
这是我在tonymacx86发帖的内容，就直接复制过来了，都读的懂。
# Problem
Every time i restart my El Capitan osx i get another boot entry on bios.
# Solution
not in windows but you can do it (as I did) under clover shell
* Enter EFI Shell.
* As shell loads, note the label of the HDD/SSD your efi and OS X are installed on. FS0 in my case. or type map to see it
* Then bcfg boot dump.
* VERY CAREFULLY add a new entry after the highest one in the list. I had to type `bcfg boot add 05 FS0:\EFI\CLOVER\CLOVERX64.EFI CloverBoot` w/o the quotes, where 05 was the new entry
* Then you can delete old bcfg entry that pointed to /BOOT/BOOTX64.EFI with `bcfg boot rm XX` where XX is the number identifier seen when u do bcfg boot dump
* Then, booted into OS X, mounted EFI, and renamed /BOOT to BOOT.bak

# Reference
https://sourceforge.net/p/cloverefiboot/tickets/226/#d1a9/0222/8cc1  
https://sourceforge.net/p/cloverefiboot/tickets/226/