from fastapi import FastAPI, WebSocket, Header, WebSocketDisconnect
from fastapi.responses import StreamingResponse
import uvicorn
import io, asyncio
from typing import List, Dict
import time, json, random
import neurokit2 as nk

app = FastAPI(title="Ambulance",
              version="1.0")


class Broadcaster:
    def __init__(self, a_id):
        self.ambulance_id = a_id
        self.connections = {"clients": [], "cameras": []}

    async def connect(self, websocket: WebSocket, client):
        await websocket.accept()
        if client:
            self.connections["clients"].append(websocket)
        else:
            self.connections["cameras"].append(websocket)

    def remove(self, websocket: WebSocket, client):
        if client:
            self.connections["clients"].remove(websocket)
        else:
            self.connections["cameras"].remove(websocket)

    async def scan(self, data):
        living_connections = []
        while len(self.connections["clients"]) > 0:
            websocket = self.connections["clients"].pop()
            await websocket.send_bytes(data)
            living_connections.append(websocket)
        self.connections["clients"] = living_connections


broadcasters = {}


@app.websocket("/camera/{ambulance_id}")
async def camera_endpoint(websocket: WebSocket, ambulance_id):
    if ambulance_id not in broadcasters.keys():
        broadcasters[ambulance_id] = Broadcaster(ambulance_id)
    await broadcasters[ambulance_id].connect(websocket, client=False)
    try:
        while True:
            data = await websocket.receive_bytes()
            await broadcasters[ambulance_id].scan(data)
    except WebSocketDisconnect:
        broadcasters[ambulance_id].remove(websocket, client=False)


@app.websocket("/client/{ambulance_id}")
async def client_endpoint(websocket: WebSocket, ambulance_id):
    await broadcasters[ambulance_id].connect(websocket, client=True)
    try:
        while True:
            await asyncio.sleep(.01)
    except WebSocketDisconnect:
        broadcasters[ambulance_id].remove(websocket, client=False)


@app.get("/ambulances")
def return_ambulances():
    global broadcasters
    ambulances = []
    for ambulance_id in broadcasters.keys():
        data = {}
        data["_id"] = ambulance_id
        data["stream_urls"] = []
        for camera in broadcasters[ambulance_id].connections["cameras"]:
            data["stream_urls"].append(f"http://47.38.139.217:8000/client/{ambulance_id}")

        data["arriving_in"] = "12 minutes"
        data["longitude"] = 34.434334
        data["latitude"] = -23.34353
        data["going_to"] = "trauma center"
        data["name"] = "DFR 1010"
        ambulances.append(data)
    return ambulances


@app.post("/recorded")
def recording(ambulance_id: str):
    pass


@app.websocket("/ambulance_data/{ambulance_id}")
async def ambulance_data(websocket: WebSocket, ambulance_id):
    await websocket.accept()
    try:
        while True:
            simulated_ecg = list(nk.ecg_simulate(duration=6, sampling_rate=10, method="daubechies"))
            for i in simulated_ecg:
                data = {
                    "time_ms": int(time.time()),
                    "ekg_value": i,
                    "heart_rate": 85,
                    "blood_oxygen_percent": 97,
                    "sysstolic_blood_pressure": random.randint(118,122),
                    "diatolic_blood_pressure": random.randint(78,82),
                }
                result = "VITALS_UPDATE||||" + json.dumps(data)
                await websocket.send_text(result)
                await asyncio.sleep(.1)

    except WebSocketDisconnect:
        pass

if __name__ == '__main__':
    uvicorn.run(app, host="0.0.0.0", port=8000)
