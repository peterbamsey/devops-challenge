#!/usr/bin/env python

from flask import Flask, jsonify, request
app = Flask(__name__)

 # here's the main entry point
@app.route('/')
def view_headers() :
    d = dict\
            (
        headers=dict(request.headers.items()),origin=request.environ['REMOTE_ADDR']
    )
    return jsonify(d)


if __name__ = '__main__':
      app.run(host='0.0.0.0')


