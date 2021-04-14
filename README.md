# LevIoT - Air Purifier replacement controller

This is a replacement PCB based on ESP32 for the Levoit "True HEPA Air Purifier" Core 300, (Amazon model number: 817915027059).

It has currently not been tested yet, I just ordered it from a PCB manufacturer.

I spent around 30€ for 5 PCBs with most components pre-soldered by the PCB manufacturer, + around 13€ on AliExpress for the
push buttons, shift registers and PH connectors.

Touchpad springs and LEDs are going to be recovered from the original PCB.

## Taking the original board out

The top cover comes off by inserting a spudger tool between the top white and gray plastic parts.

The PCB is attached to the top plastic lid with some clips, and connected to the motor via a 6-pin JST-PH connector.

## Control board protocol

Pinout:

| Pin #   | Function   |
| ------- | ---------- |
| 1 (red) | VCC        |
| 2       | GND        |
| 3       | Speed 3    |
| 4       | Speed 2    |
| 5       | Speed 1    |
| 6       | Night mode |


The control board simply pulls one of the pins from 3 to 6 high with the other ones low to set the speed, with all low being "off".

The motor side seems to accept pretty much any voltage > 1V as long as the current is at least ~20 mA, though when using the original
board I measure 4V across the pin and ground - current should be around 80 mA.

You can test it by placing a 100 ohm resistor between 5V and one of the speed pins.


### Important safety notice

I'm not an electrical motor expert but I know that fans need to be started at the maximum speed from the off state in order to
prevent motor strain, overheating and fire hazards.

See this video about it by Technology Connections: https://www.youtube.com/watch?v=hQ3GW7lVBWY

A custom board firmware must kickstart the fan at maximum speed for ~1 sec after power on, then set it back to whatever speed
is desired.

The original board does this automatically.

## License

CERN Open Hardware License, strictly reciprocal.

## Disclaimer

I will not take any responsibility for broken air filters caused by modding or installing this custom PCB. You take your own
responsibility.

