import time
import cv2
import mss
import numpy
import pytesseract
pytesseract.pytesseract.tesseract_cmd = 'D:/tesseract/tesseract.exe'

def print_screen():
    partOfScreen = {'top': 150, 'left': 55, 'width': 150, 'height': 50}

    with mss.mss() as sct:
        while True:
            im = numpy.asarray(sct.grab(partOfScreen))
            im = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)

            text = pytesseract.image_to_string(im)
            print(text)
            return text
            cv2.imshow('Image', im)

            # Press "q" to quit
            if cv2.waitKey(1000) & 0xFF == ord('q'):
                cv2.destroyAllWindows()
                break

            # One screenshot per second
            break



