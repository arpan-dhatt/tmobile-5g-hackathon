import io
import socket
import struct
import time
import picamera
import logging

width = 640
height = 480
fps = 30
ip = "47.38.139.217"
port = 8000
timeout = 1


while True:
    try:
        client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        client_socket.connect((ip, port))
        connection = client_socket.makefile('wb')

        with picamera.PiCamera() as camera:
            camera.vflip = False
            camera.hflip = False
            camera.resolution = (width, height)
            camera.framerate = fps
            time.sleep(timeout)
            start = time.time()
            stream = io.BytesIO()

            try:
                for foo in camera.capture_continuous(stream, 'jpeg', use_video_port=True):
                        connection.write(struct.pack('<L', stream.tell()))
                        connection.flush()
                        stream.seek(0)
                        connection.write(stream.read())
                        stream.seek(0)
                        stream.truncate()
                connection.write(struct.pack('<L', 0))
            finally:
                pass

    except BrokenPipeError:
        time.sleep(timeout)
        logging.error("Cant send frame to "+str(ip)+" and reconnect for "+str(timeout)+"s.")
    except ConnectionRefusedError:
        time.sleep(timeout)
        logging.error("Cant connect to server, retry for "+str(timeout)+"s.")
    else:
        break