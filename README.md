# Gamepad
*Bachelor thesis*

The aim of this thesis was to explore the possibilities of the Arduino controller to implement a gamepad with use of potentiometer. The reader is offered instructions for building his own gamepad from the hardware to the software part, including a 3D case. 
Another intent of the work was to test the device on various arcade games with target users/respondents and input lag testing.

### List of hardware components:
* [Arduino Leonardo Board](https://techfun.sk/produkt/arduino-leonardo-original/)
* [Potentiometer](https://techfun.sk/produkt/potenciometer-rozne-typy-b1k-az-b500k/)
* [5 - Buttons](https://techfun.sk/produkt/organizer-s-tlacidlami-a-nasadami-12x12x4-3-mm/)
* [Joystick](https://techfun.sk/produkt/joystick-2-osi-analogovy-vystup/)
* [PCB](https://techfun.sk/produkt/nepajive-pole-170-bodov/)
* 5 - Resistors
* Jumper wires (various types)

Connect all components according to the wiring diagram. [diagram](gamepad_wiring_diagram.png)

### Case
Parts of the 3D case: (designed in OpenScad program)
* [upper part](gamepad_upper_part.stl)
* [lower part](gamepad_lower_part.stl)

### Code:
To write and upload code to the Arduino boards is used Arduino IDE program (variant of the C++ programming language).

``` c++
#include "Joystick.h"

Joystick_ Joystick(0x15, JOYSTICK_TYPE_GAMEPAD,
  5, 0,                  // Button Count, Hat Switch Count
  true, true, false,     // X, Y, Z Axis
  false, false, false,   // Rx, Ry, Rz
  false, false,          // rudder, throttle
  false, false, false);  // accelerator, brake, steering

void setup() {
  pinMode(2, INPUT_PULLUP);
  pinMode(3, INPUT_PULLUP);
  pinMode(4, INPUT_PULLUP);
  pinMode(5, INPUT_PULLUP); 
  pinMode(6, INPUT_PULLUP);

  Joystick.begin();
  Joystick.setXAxisRange(-127, 127);
  Joystick.setYAxisRange(-127, 127);
}

int last_state[5] = {0,0,0,0,0};

void loop() {
  for (int i = 0; i < 5; i++){
    int cur_state = !digitalRead(i + 2);
    if (cur_state != last_state[i]){
      switch (i) {
        case 0: 
          Joystick.setButton(0, cur_state);
          break;
        case 1: 
          Joystick.setButton(1, cur_state);
          break;
        case 2: 
          Joystick.setButton(2, cur_state);
          break;
        case 3: 
          Joystick.setButton(3, cur_state);
          break;
        case 4: 
          Joystick.setButton(4, cur_state);
          break;
      }
      last_state[i] = cur_state;
    }
  }
  Joystick.setXAxis(map(analogRead(A3),0,1023,-127,127));
  Joystick.setYAxis(map(analogRead(A1),0,1023,-127,127));
  Joystick.sendState();
  delay(10);
}
```

<p align="center"> <img src="gamepad_image.png" /> </p>


### Gamepad calibration


After successfully uploading the code to the Arduino, let's test the controller first.

*Note: The following steps are for Windows 10 operating system. If you have a different version of Windows or a different operating system, these steps may be slightly different.*

Open the *Control Panel* \ *Hardware and Sound* \ *Devices and Printers* window

The Arduino Leonardo should appear in the list of devices (Figure 1). Right-click and select the *Game controller settings*.
We will see a list of drivers, from which we select Arduino Leonardo and click on the *Properties*.

<p align="center"> <img src="Figure1.PNG" width="400" /> </p>
<p align="center"> <i>Figure1</i> </p>


After the dialog is displayed, press the individual buttons, turn the potentiometer and move the joystick. If the subsequently printed values are as expected, the controller is working correctly. (Figure 2)

If the controller does not work properly, it is necessary to calibrate it. In the Arduino Leonardo Properties window, switch from the *Test* to the *Settings* and then to the *Calibrate* (Figure 2).

<p align="center"> <img src="Figure2.PNG" width="400" /> </p>
<p align="center"> <i>Figure2</i> </p>

See in 3D : [show](Gamepad_with_parts.stl)
