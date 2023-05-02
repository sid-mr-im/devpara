# app.py
from flask import Flask, request, jsonify
import ImgToText as img
import time
import main2
app = Flask(__name__)

@app.get("/progress")
def get_countries():
    return img.print_screen()

