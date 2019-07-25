# XPS13-9360-i5-8250U-macOS

Hackintosh macOS Mojave 10.14 on XPS13-9360  黑苹果10.14安装配置及教程

Github地址：<https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS>

网络上中文资料很少，尤其是8代CPU的XPS。而我又是一个原版镜像控，又追求最新版的系统和软件，资料更是少之又少。搞这个东西前前后后搞了一个多月，系统崩溃重装无数次，现在终于稳定，各项功能基本和白苹果一致，故记录成文给后来者一个参考。

建了一个QQ群，方便交流：980197002

> ⚠警告：安装和使用黑苹果时经常会碰到意外，**千万千万要做好数据备份**
>
> ⚠建议：安装完成后关闭系统更新，更新比较容易出问题。

## 更新记录

- 2019-07-25 重装系统（非升级）更新到了10.14.5，更新了EFI，启动速度变快，稳定性变高，蓝牙稳定性也提升了。**新增FileVault支持（提前把config-filevault.plist改为config.plist，但不建议新手尝试）**
- 2019-04-05 今天手贱更新10.14.4结果启动不起来了，然后又重新搞了一份配置，更新了驱动，顺便解决了很多人碰到的声音问题。目前系统运行正常
- 2019-01-14 修正内存显示与实际情况不一致的问题。建议自行在“SMBIOS->Memory”一栏自行补充内存信息，写法参考config-example.plist文件
- 2018-12-21 系统更新为10.14.2 出现找不到触控板的情况，已经更新触控板驱动，现在运行正常。~~如果出现触控板问题请重新安装触控板驱动：<https://github.com/RehabMan/OS-X-Voodoo-PS2-Controller>~~
- 2018-11-02 系统更新为10.14.1 运行正常

## 硬件配置参考

- 型号：XPS13-9360
- CPU：Intel i5-8250U
- GPU：Intel UHD Graphics 620
- 内存：8GB
- 显示器：1920x1080
- SSD：KXG50ZNV256G NVMe TOSHIBA 256GB
- 无线网卡：Dell DW1560 BCM94352Z （购于淘宝自行更换）

> QQ群里有使用原装网卡的方案，喜欢折腾的同学可以进群了解。

配件及外接设备：

- USB Type-C转接器：Dell DA300（含有线网卡）
- 外接过的显示器：
  - Lenovo ThinkVision LEN LT2223wA 21.5寸 1920x1080
  - Dell U2718Q 27寸 4k
- USB有线网卡：KY-QF9700 （驱动好找，临时使用）
- USB无线网卡：TL-WN823N（驱动好找，临时使用）

系统及BIOS：

- 系统：macOS 10.14.5  Mojave（单系统，没有Windows）
- BIOS：2.9.1

## 使用情况说明

正常使用：

- 能够正常引导开机关机
- USB口都可用
- 外接显示器可用
- 触控板可用并支持多种手势
- 扬声器/耳机/麦克风可用
- 屏幕亮度可调节
- 键盘灯可控
- 蓝牙可用
- WiFi可用
- Airdrop可用
- 睡眠可唤醒
- 耗电情况正常，续航基本能用一天
- 发热情况正常

存在的问题：

- 有时候启动会比较慢，个别时候甚至无法启动（推测可能是蓝牙原因，一般重启可以解决）
- 外接显示器热插拔可能会导致启动故障（一般重启可解决）
- 外接显示器开机可能会比较慢，如果无法启动可以拔了显示器重启再插上
- 睡眠唤醒后偶尔会蓝牙不可用（一般重启可解决）
- SD卡口屏蔽了，没去折腾过
- 触控板虽然支持多种手势，但是面积较小，不如macbook方便



## 制作U盘镜像

从这里开始是教程真正开始的部分，首先要做好系统安装失败崩溃无数次的心理准备。然后准备一个大于8G（推荐16G以上）的U盘，和运行macOS系统的电脑就可以开始了。用苹果电脑制作是为了获得原版镜像，当然也可以用Windows制作，可以查找一下相关教程。

1. 从App Store下载镜像，大约半小时。
2. 在磁盘工具左上角选择显示所有设备，格式化U盘，GUID分区，格式为Mac OS Extended      (Journaled)，名字为USB。
3. 把镜像写入到U盘：

```bash
sudo /Applications/Install\ macOS\ Mojave.app/Contents/Resources/createinstallmedia --volume /Volumes/USB --applicationpath /Applications/Install\ macOS\ Mojave.app --nointeraction
```

![create-usb](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/create-usb.png)

4. 用tools目录下的Clover Configuration挂载**U盘的EFI分区**（注意不要挂错了），然后把本项目中所有文件复制到EFI分区的EFI目录内。

![mount-efi](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/mount.jpg)

> 很多人表示在U盘中找不到EFI分区，我又重新制作了一遍启动U盘。如果严格按照流程来操作，U盘中会有EFI分区。系统尽量使用在App Store下载的原版系统，使用第三方修改的系统可能会有问题。



## 配置BIOS

开机按F2进入BIOS，按照下面一项一项配置，如果你对每一项配置了如指掌也可以自行配置。

\- Sata: AHCI

\- Enable SMART Reporting

\- Disable thunderbolt boot and pre-boot support

\- USB security level: disabled

\- Enable USB powershare

\- Enable Unobtrusive mode

\- Disable SD card reader (saves 0.5W of power)

\- TPM Off

\- Deactivate Computrace

\- Enable CPU XD

\- Disable Secure Boot

\- Disable Intel SGX

\- Enable Multi Core Support

\- Enable Speedstep

\- Enable C-States

\- Enable TurboBoost

\- Enable HyperThread

\- Disable Wake on USB-C Dell Dock

\- Battery charge profile: Standard

\- Numlock Enable

\- FN-lock mode: Disable/Standard

\- Fastboot: minimal

\- BIOS POST Time: 0s

\- Enable VT

\- Disable VT-D

\- Wireless switch OFF for Wifi and BT

\- Enable Wireless Wifi and BT

\- Allow BIOS Downgrade

\- Allow BIOS Recovery from HD, disable Auto-recovery

\- Auto-OS recovery threshold: OFF

\- SupportAssist OS Recovery: OFF

这个时候U盘应该可以正常启动（按F8选择从U盘启动）了，如果开机启动项里面没有找到U盘，可以在BIOS里面手动添加一个启动项，启动项路径为/EFI/EFI/CLOVER/CLOVERX64.efi

启动成功后应该进入了CLOVER界面，选择启动Shell，启动的是位于CLOVER/tools目录下的Shell64U.efi。这个Shell是用于修改BIOS配置，另一个Shell已经重命名为Shell64U.efi.bak，如果修改完BIOS配置后有需要的话，可以将Shell64U.efi.bak改回来~~（一般情况下不需要这么做）~~（修改启动声音大小时需要这么做）。

进入Shell以后主要修改以下三项：

| Variable              | Offset | 默认值  | 修改值   | Comment                                                    |
| --------------------- | ------ | -------------- | --------------- | ---------------------------------------------------------- |
| CFG Lock              | 0x4de  | 0x01 (Enabled) | 0x00 (Disabled) | Disable CFG Lock to prevent                                |
| DVMT Pre-allocation   | 0x785  | 0x01 (32M)     | 0x06 (192M)     | Increase DVMT pre-allocated size to 192M for QHD+ displays |
| DVMT Total Gfx Memory | 0x786  | 0x01 (128M)    | 0x03 (MAX)      | Increase total gfx memory limit to maximum                 |

修改命令分别如下：

```
setup_var 0x4de 0x00
setup_var 0x785 0x06
setup_var 0x786 0x03
```

输入exit退出Shell，然后重启进行安装。

## 安装macOS

重启之后到CLOVER界面选择Install macOS Mojave，如果能正常启动的话，那就恭喜了。如果不能正常启动，建议回到CLOVER界面，选择Options，在启动参数里面（按回车开始输入，按回车结束输入）加上-v看看详细报错然后去网上查查资料。

进入安装界面后，先选择磁盘工具对磁盘进行格式化，注意左上角选择显示所有设备，然后选择目标磁盘，格式选择APFS，**不要区分大小写，不然安装不了Adobe系列产品**。格式化完成后选择目标磁盘后就可以开始安装了。

安装过程中会重启多次，如果没找到正确的启动项，可以手动选择一下。

如果顺利的话，安装完成最后一次启动是macOS，进入系统了。

## 后续设置

到目前为止，启动还是通过U盘里的CLOVER引导的，所以第一件事情是把CLOVER安装到硬盘上。同样用Clover Configurator挂载**电脑硬盘的EFI分区**，和U盘一样，把文件复制进去，大概如下所示。

![image-20181016133944461](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/efi-list.png)

然后运行终端，cd到该目录下，根据需要（非必须）运行以下命令：

```bash
# CD到该目录（先挂载）
cd /Volumes/EFI/EFI
# 编译DSDT
bash XPS9360.sh --compile-dsdt
# 允许安装第三方程序
bash XPS9360.sh --enable-3rdparty
# 禁用TOUCHID
bash XPS9360.sh --disable-touchid
```

然后进入ComboJack目录，运行如下命令解决耳机没有声音的问题：

```bash
bash install.sh
```

然后用Clover Configurator打开`EFI/Clover/config.plist`文件，随机生成以下几个序列号：

![image-20181016134503963](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/smbios.png)

![image-20181016134704814](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/serial.png)

![image-20181016134831948](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/uuid.png)

接着打开`EFI/tools`里面的Kext Wizard程序，把`EFI/kexts/Library-Extensions`里面的`BrcmFirewareRepo.kext`和`BrcmPatchRAM2.kext`文件安装到`/System/Library/Extensions/`目录，安装完成后需要重建缓存：

![image-20181016135223846](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/kexts.png)

![](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/repair.png)

> 如果Kext Wizard无法正常使用的话，也可以用Kext Utility，把那两个kext拖到窗口内即可

## 解决耳机没有声音的办法

进入`EFI/ComboJack`目录，运行命令`bash install.sh`

参考

- <https://github.com/the-darkvoid/XPS9360-macOS/issues/115#issuecomment-463154229>
- <https://github.com/hackintosh-stuff/ComboJack>

## 调整开机DUANG的声音的办法

如果完全不想要开机声音，最方便的方法是直接删除`EFI/CLOVER/drivers64UEFI/AudioDxe.efi`和`EFI/CLOVER/drivers64UEFI/BootChimeDxe.efi`。

如果想要调小声音，那么：

1. 备份`EFI/CLOVER/tools/Shell64U.efi`

2. 把`EFI/CLOVER/tools/Shell64U.efi.bak`改为`EFI/CLOVER/tools/Shell64U.efi`

3. 重启进入CLOVER，选择启动shell

4. 依次输入以下命令

   ```bash
   # 进入fs0分区
   fs0:
   # 进入tools目录
   cd EFI\CLOVER\tools
   # 管理声音
   BootChimeCfg.efi
   ```

![bootchime](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/bootchime.jpg)

这个时候你会看到一些选项，`V`是用来调整声音大小，如`V 20`就表示声音设置到20%， `T`可以用来测试声音播放。

## 解决无法连接app store的办法

> iMessage/iCloud/AirDrop 等出现问题也可以试试本方法

连接不上app store的核心原因在于网卡名字不是`en0`，这个可以通过`ifconfig -a`或「关于本机-系统报告-Wi-Fi」处查看。

首先，删除网络偏好设置中所有网卡。

然后在`/Library/Preferences/SystemConfiguration/com.apple.Boot.plist`中添加
```
<key>EthernetBuiltIn</key>
<string>Yes</string>
```
这里应该需要root权限，可以先用`sudo -i`切换到root。我修改完的文件参考如下：
```
$ cat com.apple.Boot.plist

<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>EthernetBuiltIn</key>
	<string>Yes</string>
	<key>Kernel Flags</key>
	<string></string>
</dict>
</plist>
```

最后删除`/Library/Preferences/SystemConfiguration/NetworkInterfaces.plist`重启即可。

注意：如果不放心的话，以上步骤建议可以先备份原文件

## 找不到硬盘
如果使用的是海力士的SSD，欢迎使用@April-5 提供的`config-hynix.plist`配置文件，只需要改名成`config.plist`即可（原`config.plist`建议备份）。

如果使用的是其他硬盘而找不到的，建议寻找一下其他配置，或更换硬盘（可以试试SM961）

## 关于双系统
我安装的是黑苹果单系统，有双系统安装需求的同学建议先安装macOS，再用mac中的Boot Camp Assistant安装Windows，可以减少很多麻烦。

## The End
整个安装过程到此就全部结束了，可以重启试试是不是所有功能都运行正常。如果不正常的话，需要自己检查一下问题出在哪里。

建议认真看一看[READ FIRST! Laptop Frequent Questions](https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/)

如果碰到问题，欢迎在issues中提出，如果有解决办法也欢迎补充。

## 相关产品链接

- 【楼主同款】XPS13 9360 京东自营：<https://u.jd.com/EYxXhT>
- XPS15 京东自营：<https://u.jd.com/0uP8lg>
- 【楼主同款】闪迪64G U盘 京东自营：<https://u.jd.com/7nAoYU>
- 【楼主同款】戴尔U2718Q 4K显示器 京东自营：<https://u.jd.com/z5pDlr>
- 【楼主同款】DA300转换适配器 京东自营：<https://u.jd.com/FWjSys>
- DA200转换适配器 京东自营：<https://u.jd.com/pcJU0J>
- 绿联Type-c扩展坞 京东自营：<https://u.jd.com/BjK2A5>
- 网卡购于淘宝，目前已下架，可以参考<https://github.com/RehabMan/OS-X-BrcmPatchRAM>中的Tested PatchRAM devices购买（欢迎推荐可以完美使用的网卡）

## 用爱发电
![wepay](https://github.com/0xHJK/XPS13-9360-i5-8250U-macOS/raw/master/docs/wepay.jpg)

## Credits

- [Dell XPS 13 9360 Guide by bozma88](https://www.tonymacx86.com/threads/guide-dell-xps-13-9360-on-macos-sierra-10-12-x-lts-long-term-support-guide.213141/)
- [macOS on Dell XPS 9360](https://github.com/the-darkvoid/XPS9360-macOS)
- [OS-X-BrcmPatchRAM](https://github.com/RehabMan/OS-X-BrcmPatchRAM)
- [READ FIRST! Laptop Frequent Questions](https://www.tonymacx86.com/threads/faq-read-first-laptop-frequent-questions.164990/)
- https://github.com/hackintosh-stuff/ComboJack
- 以及其他工具、kext、文章贡献者
