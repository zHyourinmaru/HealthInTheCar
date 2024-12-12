import asyncio
import queue

import cv2
import numpy as np
import websockets
import threading
import time
from queue import Queue
from multiprocessing import Process, Queue

from gaze_estimator import Calibrazione_m, detect_funzionante

port = 8787


async def receive_video(websocket):
    print("Connected to server")
    count = 0
    width = 320
    height = 240
    z = 2
    calibration = False
    detect = False

    old_zone = "ZORIGINAL"
    old_heart_prediction = "0"

    shared_queue = Queue()
    image_change_queue = Queue()
    zone_queue = Queue()
    heart_prediction_queue = Queue()

    # Avvia il contatore di frame in un thread separato
    # frame_counter_thread = threading.Thread(target=frame_counter, args=(shared_queue,))
    # frame_counter_thread.start()

    try:
        while True:
            data = await websocket.recv()

            if data == "Connection Established":
                print("Connection established with server")

            elif data == "ping":
                await websocket.send("pong")
                print("pong")
            elif data == "calibration":
                print("Calibration start from the client.")
                calibration_process = Process(target=Calibrazione_m.calibration, args=(shared_queue, image_change_queue))
                calibration = True
                calibration_process.start()
            elif data == "detect":
                print("Calibration start from the client.")
                detect_process = Process(target=detect_funzionante.detect, args=(shared_queue, zone_queue, heart_prediction_queue))
                detect = True
                detect_process.start()
            elif data == "stop":
                print("Stop ricevuto dal client. Terminazione dei processi.")
                if calibration == True:
                    calibration_process.terminate()
                    calibration = False
                elif detect == True:
                    detect_process.terminate()
                    detect = False

                while shared_queue.qsize() > 0:
                    _ = shared_queue.get()

            elif calibration:
                try:
                    if len(data) > 0:
                        yuv = np.frombuffer(data, dtype='uint8')
                        uv_start = width * height
                        y = yuv[:uv_start].reshape(height, width)
                        uv = yuv[uv_start:].reshape(height // 2, width)
                        u = uv[:, ::2]
                        v = uv[:, 1::2]

                        u = u.repeat(2, axis=0).repeat(2, axis=1)
                        v = v.repeat(2, axis=0).repeat(2, axis=1)

                        y = y.reshape((y.shape[0], y.shape[1], 1))
                        u = u.reshape((u.shape[0], u.shape[1], 1))
                        v = v.reshape((v.shape[0], v.shape[1], 1))

                        yuv_array = np.concatenate((y, u, v), axis=2)
                        yuv_array = yuv_array.astype(np.float32)
                        yuv_array[:, :, 0] = yuv_array[:, :, 0].clip(16, 235) - 16
                        yuv_array[:, :, 1:] = yuv_array[:, :, 1:].clip(16, 240) - 128

                        convert = np.array([
                            [1.164, 0.000, 2.018], [1.164, -0.813, -0.391], [1.164, 1.596, 0.000]
                        ])

                        yuv_array = yuv_array.astype(np.int32)
                        yuv_array = np.clip(yuv_array, 0, 255).astype(np.uint8)
                        rgb = np.matmul(yuv_array, convert.T).clip(0, 255).astype('uint8')

                        rgb = cv2.rotate(rgb, cv2.ROTATE_90_COUNTERCLOCKWISE)
                        shared_queue.put(rgb)

                        if image_change_queue.qsize() > 0:

                            if image_change_queue.get() == 'Error':

                                await websocket.send('Error 01')
                                print('Errore nella calibrazione')

                            else:

                                z_as_string = str(z)
                                await websocket.send(z_as_string)
                                print(str(z))
                                if z == 6:
                                    calibration = False
                                else:
                                    z = z + 1

                            while shared_queue.qsize() > 0:
                                _ = shared_queue.get()

                        # cv2.imshow('RGB Image', rgb)
                        # cv2.waitKey(1)

                except Exception as e:
                    print(f"Errore nella decodifica dell'immagine: {e}")

            elif detect:
                try:
                    if len(data) > 0:
                        yuv = np.frombuffer(data, dtype='uint8')
                        uv_start = width * height
                        y = yuv[:uv_start].reshape(height, width)
                        uv = yuv[uv_start:].reshape(height // 2, width)
                        u = uv[:, ::2]
                        v = uv[:, 1::2]

                        u = u.repeat(2, axis=0).repeat(2, axis=1)
                        v = v.repeat(2, axis=0).repeat(2, axis=1)

                        y = y.reshape((y.shape[0], y.shape[1], 1))
                        u = u.reshape((u.shape[0], u.shape[1], 1))
                        v = v.reshape((v.shape[0], v.shape[1], 1))

                        yuv_array = np.concatenate((y, u, v), axis=2)
                        yuv_array = yuv_array.astype(np.float32)
                        yuv_array[:, :, 0] = yuv_array[:, :, 0].clip(16, 235) - 16
                        yuv_array[:, :, 1:] = yuv_array[:, :, 1:].clip(16, 240) - 128

                        convert = np.array([
                            [1.164, 0.000, 2.018], [1.164, -0.813, -0.391], [1.164, 1.596, 0.000]
                        ])

                        yuv_array = yuv_array.astype(np.int32)
                        yuv_array = np.clip(yuv_array, 0, 255).astype(np.uint8)
                        rgb = np.matmul(yuv_array, convert.T).clip(0, 255).astype('uint8')

                        rgb = cv2.rotate(rgb, cv2.ROTATE_90_COUNTERCLOCKWISE)
                        shared_queue.put(rgb)

                        if heart_prediction_queue.qsize() > 0:

                            heart_prediction = str(int(heart_prediction_queue.get()[0, 0]))

                            if heart_prediction == 'Error':

                                await websocket.send('Error 03')
                                print('Errore nella detect')

                            elif heart_prediction != old_heart_prediction:

                                await websocket.send(heart_prediction)

                            old_heart_prediction = heart_prediction

                        if zone_queue.qsize() > 0:

                            zone = zone_queue.get()

                            if zone == 'Error':

                                await websocket.send('Error 02')
                                print('Errore nella detect')

                            elif zone != old_zone:

                                await websocket.send(zone)

                            old_zone = zone


                        # cv2.imshow('RGB Image', rgb)
                        # cv2.waitKey(1)

                except Exception as e:
                    print(f"Errore nella decodifica dell'immagine: {e}")

    except websockets.exceptions.ConnectionClosed as e:
        print(f"Connessione chiusa in modo anomalo: {e}")
        if calibration == True:
            calibration_process.terminate()
            calibration = False
        elif detect == True:
            detect_process.terminate()
            detect = False

        while shared_queue.qsize() > 0:
            _ = shared_queue.get()

        while zone_queue.qsize() > 0:
            _ = zone_queue.get()

        while heart_prediction_queue.qsize() > 0:
            _ = heart_prediction_queue.get()

    except Exception as e:
        print(f"Errore generale durante la ricezione dei dati: {e}")


def frame_counter(shared_queue, period=1):
    while True:
        start_time = time.time()
        frame_count = 0

        while time.time() - start_time < period:
            try:
                frame = shared_queue.get()
                frame_count += 1
            except queue.Empty:
                pass

        frames_per_second = frame_count / period
        print(f"Frame al secondo: {frames_per_second}")


async def main():

    start_server = await websockets.serve(
        lambda websocket, path: receive_video(websocket),
        host="192.168.1.32",
        port=port,
        ping_timeout=None
    )

    await start_server.wait_closed()
    cv2.destroyAllWindows()


if __name__ == '__main__':
    asyncio.run(main())

cv2.destroyAllWindows()
