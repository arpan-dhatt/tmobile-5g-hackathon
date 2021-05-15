import aiohttp
import asyncio
import picamera, io, time
from aiohttp.client_exceptions import ClientOSError

async def main():
    session = aiohttp.ClientSession()
    ws = await session.ws_connect("ws://192.168.86.26:8000/camera/1111")
    width = 640
    height = 480
    fps = 15
    while True:
        try:
            with picamera.PiCamera() as camera:
                camera.vflip = False
                camera.hflip = False
                camera.resolution = (width, height)
                camera.framerate = fps
                stream = io.BytesIO()
                for foo in camera.capture_continuous(stream, 'jpeg', use_video_port=True):
                    stream.seek(0)
                    await ws.send_bytes(stream.read())
                    stream.seek(0)
                    stream.truncate()
                    await asyncio.sleep(.02)
        except ClientOSError:
            ws = await session.ws_connect("ws://192.168.86.26:8000/camera/1111")


if __name__ == '__main__':
    while True:
        try:
            newfeature = asyncio.run(main())
        except:
            time.sleep(1)
            pass