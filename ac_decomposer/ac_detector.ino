// depends on arduinoFFT
// https://www.arduino.cc/reference/en/libraries/arduinofft/
// install from the Library Manager
#include "arduinoFFT.h"

// around middle C
#define targetFreq 300

// 20dB around the target frequency
int freqMin = (targetFreq / 10);
int freqMax = 1500;

#define SAMPLES 64
int SAMPLING_FREQUENCY = 5000;

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
  pinMode(7, OUTPUT);
  pinMode(6, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(3, OUTPUT);
  pinMode(4, OUTPUT);
}

void loop() {
  // put your main code here, to run repeatedly:
  for (int i = 0; i < SAMPLES; i++) {
    val = micros();

    vReal[i] = analogRead(A5);
    vImag[i] = 0;

    while (micros() < (val + samplingPeriod)) {}
  }

  FFT.Windowing(vReal, SAMPLES, FFT_WIN_TYP_HAMMING, FFT_FORWARD);
  FFT.Compute(vReal, vImag, SAMPLES, FFT_FORWARD);
  FFT.ComplexToMagnitude(vReal, vImag, SAMPLES);
  FFT.DCRemoval(vReal, SAMPLES);
  // PrintVector(vReal, SAMPLES >> 1);
  // freq_word is a single byte, the smallest allowable datatype in Arduino
  byte freq_word = 0;
  int peak = SAMPLES >> 1;
  for (int i = 80 * SAMPLES / SAMPLING_FREQUENCY; i < peak; i++) 
  {
    // if it's a significant magnitude
    if (abs(vReal[i]) > 150) {
      double frequency = i * 1.0 * SAMPLING_FREQUENCY / SAMPLES;
      // pack the word with individual bits
      if (frequency > 750) {
        freq_word = freq_word | B00010;
      } else if (frequency > 500) {
        freq_word = freq_word | B00100;
      } else if (frequency > 200) {
        freq_word = freq_word | B01000;
      } else {
        freq_word = freq_word | B10000;
      }
    }
  }

  // TODO: communicate freq_word to the FPGA
  Serial.println(freq_word, BIN);
  Serial.println();
//  PrintVector(vReal, SAMPLES);
  pinWrite(freq_word);
}

void pinWrite(byte toWrite) {
  digitalWrite(4, boolToHighLow((toWrite & B10000) > 0));
  digitalWrite(3, boolToHighLow((toWrite & B01000) > 0));
  digitalWrite(2, boolToHighLow((toWrite & B00100) > 0));
  digitalWrite(7, boolToHighLow((toWrite & B00010) > 0));
  digitalWrite(6, LOW);
}

int boolToHighLow(bool in) {
  if (in) {
    return HIGH;
  }
  return LOW;
}

void PrintVector(double *vData, uint16_t bufferSize)
{
  for (uint16_t i = 0; i < bufferSize; i++)
  {
    double abscissa = ((i * 1.0 * SAMPLING_FREQUENCY) / SAMPLES);
//    Serial.print(abscissa, 6);
//    if(scaleType==SCL_FREQUENCY)
//      Serial.print("Hz");
//    Serial.print(" ");
    Serial.println(vData[i], 4);
  }
  Serial.println();
}
