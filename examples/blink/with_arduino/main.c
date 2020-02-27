/*
this example assumes you have https://github.com/stm32duino/Arduino_Core_STM32/releases/tag/1.8.0
installed.

See the description in the readme.md file
*/

void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void loop() {
  digitalWrite(LED_BUILTIN, HIGH);
  delay(1000);
  digitalWrite(LED_BUILTIN, LOW);
  delay(1000);
}
