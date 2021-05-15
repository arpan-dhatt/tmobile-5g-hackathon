import aiohttp
import asyncio
import io, time
from aiohttp.client_exceptions import ClientOSError
import io
from PIL import Image
import shutil
import os

file_names = sorted(os.listdir("/Users/vivekchari/Downloads/tmob/dstreams/dstream2"))
async def main():
    global images
    session = aiohttp.ClientSession()
    ws = await session.ws_connect("ws://192.168.86.26:8000/camera/1113")
    while True:
        try:
            for file_name in file_names:
                ifile = open("/Users/vivekchari/Downloads/tmob/dstreams/dstream2/" + file_name, 'rb')
                await ws.send_bytes(ifile.read())
                await asyncio.sleep(.1)
        except ClientOSError:
            ws = await session.ws_connect("ws://192.168.86.26:8000/camera/1113")

if __name__ == '__main__':
    while True:
        try:
            newfeature = asyncio.run(main())
        except:
            time.sleep(1)
            pass

