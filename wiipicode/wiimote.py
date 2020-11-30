#import evdev
from evdev import InputDevice, categorize, ecodes
from gpiozero import LED

#creates object gamepad
wiimote = InputDevice('/dev/input/event0')

#Define LED/Output
green = LED(14)
red = LED(15)
yellow = LED(18)
blue = LED(23)
orange = LED(24)
strum = False
strumonly = False

#prints out device info at start
print(wiimote)

#display codes
for event in wiimote.read_loop():
    #Buttons
    print(event)

    #Strum
    if event.code == 01:
        if event.value != 00:
            strum = True
        else:
            strum = False
        print(strum)

    #Strum Only Toggle
    elif event.code == 314:
        strumonly = not strumonly

    #Green
    elif event.code == 304:
	if event.value == 00:
		green.off()
	elif event.value == 01 and strum:
	    print("should be working")	
            green.on()
    #Red
    elif event.code == 305:
        if event.value == 00:
                red.off()
        elif event.value == 01:
                red.on()

    #Yellow
    elif event.code == 307:
        if event.value == 00:
                yellow.off()
        elif event.value == 01:
                yellow.on()

    #Blue
    elif event.code == 308:
        if event.value == 00:
                blue.off()
        elif event.value == 01:
                blue.on()

    #Orange
    elif event.code == 312:
        if event.value == 00:
                orange.off()
        elif event.value == 01:
                orange.on()
