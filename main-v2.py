import cv2
import numpy as np 
from PIL import ImageGrab

import urllib.request, urllib.parse
import pytesseract
import time

def select_area(event, x, y, flags, params):
    global ix, iy, selecting, mode, clone

    if event == cv2.EVENT_LBUTTONDOWN:
        selecting = True
        ix, iy = x, y

    elif event == cv2.EVENT_MOUSEMOVE:
        if selecting == True:
            clone = image.copy()
            cv2.rectangle(clone, (ix, iy), (x, y), (0, 255, 0), 1)

    elif event == cv2.EVENT_LBUTTONUP:
        selecting = False
        cv2.rectangle(clone, (ix, iy), (x, y), (0, 255, 0), 1)
        cropRect[0], cropRect[1], cropRect[2], cropRect[3] = ix*2, iy*2, x*2, y*2

user = None
project = None
print("1> New User\n2> Existing User")
c = int(input("Enter a choice: "))
if c == 1:
    user = input("Enter Username: ")
    project = input("Enter Project Name: ")
    uri = 'http://127.0.0.1:5000/add?uid={}&pid={}'.format(user, project)
    response = urllib.request.urlopen(uri)
    # print(response.read())
elif c == 2:
    user = input("Enter Username: ") #'QAq8pyJz4TyTCuIxcfGm'
    print("1> New Project\n2> Existing Project")
    o = int(input("Enter an option: "))
    if o == 1:
        project = input("Enter Project Name: ")
        uri = 'http://127.0.0.1:5000/add?uid={}&pid={}'.format(user, project)
        response = urllib.request.urlopen(uri)
        # print(response.read())
    elif o == 2:
        project = input("Enter Project Name: ") #'Jb7NPU8GjsmdmOIAe65r'

selecting = False
ix, iy = -1, -1
cropRect = [0, 0, 0, 0]

screen = np.array(ImageGrab.grab())

# convert the screen to BGR and resize
image = cv2.cvtColor(screen, cv2.COLOR_RGB2BGR)
image = cv2.resize(image, (0, 0), fx=0.5, fy=0.5)

# create a window and set the mouse callback function
cv2.namedWindow('Screen')
cv2.setMouseCallback('Screen', select_area)

# display the image and wait for a key press
clone = image.copy()
while True:
    cv2.imshow('Screen', clone)
    key = cv2.waitKey(1) & 0xFF

    # press 'r' to reset the cropRect
    if key == ord('r'):
        cropRect = [0, 0, 0, 0]
        print('Reset Selection.')
        clone = image.copy()

    # press 'c' to confirm the cropRect and exit the loop
    elif key == ord('c'):
        if cropRect[2] - cropRect[0] > 0 and cropRect[3] - cropRect[1] > 0:
            print('Confirmed Selection. Started Live Feed.')
            # release the screen capture and close the window
            cv2.destroyAllWindows()
            break
    
    elif key == ord('q'):
        print('Quitted!')
        # release the screen capture and close the window
        cv2.destroyAllWindows()
        break

pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

while(True):
    values = pytesseract.image_to_string(ImageGrab.grab().crop(cropRect))
    val = urllib.parse.quote(values).strip()
    uri = 'http://127.0.0.1:5000/post?uid={}&pid={}&val={}'.format(user, project, val)
    response = urllib.request.urlopen(uri)
    # print(values, val)
    # print(response.read())
    time.sleep(2)