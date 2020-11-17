// depends on arduinoFFT
// https://www.arduino.cc/reference/en/libraries/arduinofft/
// install from the Library Manager
#include "arduinoFFT.h"

// around middle C
#define targetFreq 300

// the max amount of buttons that can be pressed at a time
#define MAX_ONE_TIME 2

// 20dB around the target frequency
int freqMin = (targetFreq / 10);
int freqMax = (targetFreq * 10);

#define SAMPLES 128
int SAMPLING_FREQUENCY = (freqMax * 5);

double vReal[SAMPLES];
double vImag[SAMPLES];

unsigned long samplingPeriod;
unsigned long val;

arduinoFFT FFT = arduinoFFT();
unsigned long serialDetections = 0;
bool detectionStreak = false;
unsigned long startDetection;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  samplingPeriod = round(1000000 * (1.0 / SAMPLING_FREQUENCY));
}

void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i < SAMPLES; i++) {
    val = micros();

    vReal[i] = analogRead(A0);
    vImag[i] = 0;

    while (micros() < (val + samplingPeriod)) {}
  }

  FFT.Windowing(vReal, SAMPLES, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  FFT.Compute(vReal, vImag, SAMPLES, FFT_FORWARD);
  FFT.ComplexToMagnitude(vReal, vImag, SAMPLES);
  FFT.DCRemoval(vReal, SAMPLES);

  // freq_word is a single byte, the smallest allowable datatype in Arduino
  byte freq_word = 0;
  uint16_t high_count = 0;
  for (uint16_t i = 1; i < SAMPLES; i++) 
  {
    // if it's a significant magnitude
    if (vReal[i] > 1000) {
      high_count++;
      double frequency = i * 1.0 * SAMPLING_FREQUENCY / SAMPLES;
      // pack the word with individual bits
      if (frequency > 2000) {
        freq_word = freq_word | B00010;
      } else if (frequency > 500) {
        freq_word = freq_word | B00100;
      } else if (frequency > 250) {
        freq_word = freq_word | B01000;
      } else {
        freq_word = freq_word | B10000;
      }
    }

    // 
    if (high_count >= MAX_ONE_TIME) {
      break;
    }
  }

  // TODO: communicate freq_word to the FPGA
  Serial.println(freq_word);
}
