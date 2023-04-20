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
