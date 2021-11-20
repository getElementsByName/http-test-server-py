from typing import Optional
from fastapi import FastAPI, Response, status, Request


app = FastAPI(debug=True)


@app.get("/")
def read_root():
    return {"Hello": "World"}


@app.get("/healthcheck")
def healthcheck():
    return "OK"


@app.get("/httpstatus")
def httpstatus(status: int, response: Response):
    response.status_code = status
    return status


import sys
import time
import asyncio
from fastapi import BackgroundTasks

@app.get("/exit")
async def exit(code: int, background_tasks: BackgroundTasks):
    async def exit_with_code(code: int):
        await asyncio.sleep(1)
        sys.exit(code)
    # https://fastapi.tiangolo.com/tutorial/background-tasks/
    background_tasks.add_task(exit_with_code, code)
    return code

@app.get("/delay")
async def delay(ms: int, response: Response):
    await asyncio.sleep(ms / 1000)
    return ms

import socket
@app.get("/info")
def info(request: Request):
    # https://www.starlette.io/requests/
    info = {
        "client.host": request.client.host,
        "url": request.url,
        "header": request.headers,
        "cookies": request.cookies,
        "hostname": socket.gethostname()
    }
    return info

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)
