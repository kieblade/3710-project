#import evdev
from evdev import InputDevice, categorize, ecodes
from gpiozero import LED, PWMLED

#creates object gamepad
wiimote = InputDevice('/dev/input/event0')

#Define LED/Output
green = PWMLED(14)
greentoggle = False
red = PWMLED(15)
redtoggle = False
yellow = PWMLED(18)
yellowtoggle = False
blue = PWMLED(23)
bluetoggle = False
orange = PWMLED(24)
orangetoggle = False
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

    #Strum Only Toggle
    elif event.code == 314:
        if event.value != 00:
            strumonly = not strumonly

    #Green
    elif event.code == 304:
	if event.value == 00:
	    greentoggle = False
	elif event.value == 01:
            greentoggle = True
    #Red
    elif event.code == 305:
        if event.value == 00:
                redtoggle = False
        elif event.value == 01:
                redtoggle = True

    #Yellow
    elif event.code == 307:
        if event.value == 00:
                yellowtoggle = False
        elif event.value == 01:
                yellowtoggle = True

    #Blue
    elif event.code == 308:
        if event.value == 00:
                bluetoggle = False
        elif event.value == 01:
                bluetoggle = True

    #Orange
    elif event.code == 312:
        if event.value == 00:
                orangetoggle = False
        elif event.value == 01:
                orangetoggle = True


    elif strumonly:        
        if greentoggle and strum:
            green.pulse(fade_in_time=0,fade_out_time=0.5,n=1)
        if not greentoggle or not strum:
            green.off()
        if redtoggle and strum:
            red.pulse(fade_in_time=0,fade_out_time=0.5,n=1)
        if not redtoggle or not strum:
            red.off()
        if yellowtoggle and strum:
            yellow.pulse(fade_in_time=0,fade_out_time=0.5,n=1)
        if not yellowtoggle or not strum:
            yellow.off()
        if bluetoggle and strum:
            blue.pulse(fade_in_time=0,fade_out_time=0.5,n=1)
        if not bluetoggle or not strum:
            blue.off()
        if orangetoggle and strum:
            orange.pulse(fade_in_time=0,fade_out_time=0.5,n=1)
        if not orangetoggle or not strum:
            orange.off()

    elif not strumonly:
        if greentoggle:
            green.on()
        if not greentoggle:
            green.off()
        if redtoggle:
            red.on()
        if not redtoggle:
            red.off()
        if yellowtoggle:
            yellow.on()
        if not yellowtoggle:
            yellow.off()
        if bluetoggle:
            blue.on()
        if not bluetoggle:
            blue.off()
        if orangetoggle:
            orange.on()
        if not orangetoggle:
            orange.off()
