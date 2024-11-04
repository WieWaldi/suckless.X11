<img src="https://raw.githubusercontent.com/WieWaldi/suckless.X11/master/img/RZ-Amper_Logo_135x135.png" align="left" width="135px" height="135px" />

### suckless.X11 by WieWaldi
> *My personal build of dwm and other tools to form a suckless X11 environment.*

[![MIT Licence](https://badges.frapsoft.com/os/mit/mit.svg?v=103)](https://opensource.org/licenses/mit-license.php)

<br />

# X.org related web sites
[X.org man page](https://www.x.org/releases/current/doc/man/man5/xorg.conf.5.xhtml) - xorg.conf, xorg.conf.d − configuration files for Xorg X server  
[ubuntu manuals](https://manpages.ubuntu.com/manpages/trusty/man5/xorg.conf.5.html#:~:text=conf%20configuration%20file%20is%20searched,%2Fetc%2FX11%2Fxorg.) - xorg.conf, xorg.conf.d − configuration files for Xorg X server  
[O'REILLY Chapter 4. Advanced X.org Configuration](https://www.oreilly.com/library/view/x-power-tools/9780596101954/ch04.html) - X Power Tools by Chris Tyler  
[linuxreviews.org](https://linuxreviews.org/HOWTO_fix_screen_tearing) - HOWTO fix screen tearing  
[wiki.gentoo.org](https://wiki.gentoo.org/wiki/Xorg/Multiple_monitors) - X.org Multiple monitors  
[wiki.archlinux.org](https://wiki.archlinux.org/title/Xorg#Configuration) - X.org  
[wiki.archlinux.org](https://wiki.archlinux.org/title/multihead) - X.org Multihead  

# xinput related web sites
[RAGHUKAMATH](https://raghukamath.com/huion-h610x-graphic-tablet-review-and-setup-on-linux) - Huion H610X Graphic Tablet – review and setup on Linux  
[ask Ubuntu](https://askubuntu.com/questions/1000869/how-to-run-the-new-huion-tablets-on-linux) - How to run the new huion tablets on linux?  

# xinput
## 1.1 List devices
To list what xinput devices are available, use:
````shell
$ xinput list

⎡ Virtual core pointer                          id=2    [master pointer  (3)]
⎜   ↳ Virtual core XTEST pointer                id=4    [slave  pointer  (2)]
⎜   ↳ E-Signal USB Gaming Mouse                 id=9    [slave  pointer  (2)]
⎜   ↳ E-Signal USB Gaming Mouse Keyboard        id=10   [slave  pointer  (2)]
⎜   ↳ XIUDI XD60v2 Mouse                        id=13   [slave  pointer  (2)]
⎜   ↳ XIUDI XD60v2 Consumer Control             id=15   [slave  pointer  (2)]
⎜   ↳ HUION PenTablet Pad                       id=17   [slave  pointer  (2)]
⎜   ↳ HUION PenTablet Pen Pen (0)               id=21   [slave  pointer  (2)]
⎣ Virtual core keyboard                         id=3    [master keyboard (2)]
    ↳ Virtual core XTEST keyboard               id=5    [slave  keyboard (3)]
    ↳ Power Button                              id=6    [slave  keyboard (3)]
    ↳ Power Button                              id=7    [slave  keyboard (3)]
    ↳ Sleep Button                              id=8    [slave  keyboard (3)]
    ↳ XIUDI XD60v2                              id=11   [slave  keyboard (3)]
    ↳ XIUDI XD60v2 Keyboard                     id=12   [slave  keyboard (3)]
    ↳ XIUDI XD60v2 System Control               id=14   [slave  keyboard (3)]
    ↳ HUION PenTablet Pen                       id=16   [slave  keyboard (3)]
    ↳ Eee PC WMI hotkeys                        id=18   [slave  keyboard (3)]
    ↳ E-Signal USB Gaming Mouse Keyboard        id=19   [slave  keyboard (3)]
    ↳ XIUDI XD60v2 Consumer Control             id=20   [slave  keyboard (3)]
````
A device may be identified by its name (XIUDI XD60v2 Keyboard) or ID:(12).
When being executed in a startup script, it is recommended that you use the name,
as the ID may change following a reboot and lead to inconsistencies.

## 1.2 List properties
To list all the properties of a device that can be set, use the following command:
````shell
$ xinput list-props "XIUDI XD60v2 Keyboard"

Device 'XIUDI XD60v2 Keyboard':
        Device Enabled (150):   1
        Coordinate Transformation Matrix (152): 1.000000, 0.000000, 0.000000, 0.000000, 1.000000, 0.000000, 0.000000, 0.000000, 1.000000
        libinput Rotation Angle (261):  0.000000
        libinput Rotation Angle Default (262):  0.000000
        libinput Send Events Modes Available (263):     1, 0
        libinput Send Events Mode Enabled (264):        0, 0
        libinput Send Events Mode Enabled Default (265):        0, 0
        Device Node (266):      "/dev/input/event10"
        Device Product ID (267):        30788, 24672
````
Each property can be identified using its name ("libinput Tapping Enabled") or 
number (336). As with devices, it is recommended to use the name in startup 
scripts, as the ID may change, albeit less often.

## 1.3 Set device properties
Properties of devices can be set one or more (up to three) values.
The syntax for setting a property to a value is:
````shell
$ xinput set-prop device property values
````
Where values is replaced with the value(s) of the property.
For an instance, to enable tapping with the above output. Either of the following
commands could be used:
````shell
$ xinput set-prop "DELL0ABC:DE F123:4567 Touchpad" "libinput Tapping Enabled" 1
````
or
````shell
$ xinput set-prop 10 338 1
````
On success, no output should be produced.

## Usage example: Remove the middle and right mouse buttons
````shell
$ xinput set-button-map mouse-device 1 1 1
````
The above command will make middle and right mouse button to function like the
left button. Putting zeros will disable them.
````shell
$ xinput set-button-map mouse-device 1 0 0
````

# Tablet related
Map  the  tablet's  input  area to a given output (e.g. "VGA1"). Output names may
either be the name of a head available through the XRandR extension, or an X11
geometry string of the form WIDTHxHEIGHT+X+Y. To switch to the next available
output, the "next" keyword is also supported. This will cycle between the individual
monitors connected to the system, and then the entire desktop. The mapping may
be reset to the entire desktop at any time with the output name "desktop". Users
of the NVIDIA binary driver should use the output names "HEAD-0" and "HEAD-1"
until the driver supports XRandR 1.2 or later.

The output mapping configuration is a onetime setting and does not track output
reconfigurations; the command needs to be re-run whenever the output configuration
changes. When used with tablet rotation, the tablet must be rotated before it is
mapped to the new screen. This parameter is write-only and cannot be queried.

````shell
$ xsetwacom set 16 MapToOutput 3840x2160+0+720
````

