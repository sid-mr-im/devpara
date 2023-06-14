from flask import Flask, jsonify, request
import json

import firebase_admin
from firebase_admin import credentials, firestore

import os
import subprocess
import signal

app = Flask(__name__)

@app.route("/")
def home():
  return "Hey! DevPara API is ON!"

@app.route("/add")
def add():
  uid = request.args.get('uid')
  pid = request.args.get('pid')
  usersCollection.document(uid).collection('projects').document(pid).set({'progress': ""})
  return {"happen": True, "user": uid, "project": pid, "responseCode": 200}

@app.route("/post")
def post():
  uid = request.args.get('uid')
  pid = request.args.get('pid')
  pro = request.args.get('pro')
  sta = request.args.get('sta')
  try:
    user = usersCollection.document(uid)
    project = user.collection('projects').document(pid)
    # project_details = project.get().to_dict()
    # return jsonify(project_details.get('progress'))
    project.update({'progress': pro})
    project.update({'status': sta})
    return {"happen": True, "responseCode": 200}
  except Exception as e:
    return {"happen": False, "error": e}

@app.route("/swift")
def swift():
  uid = request.args.get('uid')
  pid = request.args.get('pid')
  swift = request.args.get('swift')
  print(swift)
  try:
    user = usersCollection.document(uid)
    project = user.collection('projects').document(pid)
    # project_details = project.get().to_dict()
    # json_swift = json.dumps(swift)
    project.update({'swifts': firestore.ArrayUnion([swift])})
    return {"happen": True, "value": swift, "responseCode": 200}
  except Exception as e:
    return {"happen": False, "error": e}
  
@app.route("/run")
def run():
  uid = request.args.get('uid')
  pid = request.args.get('pid')
  cmd = request.args.get('cmd')
  try:
    user = usersCollection.document(uid)
    project = user.collection('projects').document(pid)
    project.update({'command': cmd})
    os.system(cmd)
    subprocess.Popen(cmd, shell=True, )
    return {"happen": True, "command": cmd, "responseCode": 200}
  except Exception as e:
    return {"happen": False, "error": e}
  
if __name__ == "__main__":
  cred = credentials.Certificate("devpara-fbServiceAccountKey.json")
  firebase_admin.initialize_app(cred)
  db = firestore.client()

  usersCollection = db.collection('users')

  app.run(debug=True)