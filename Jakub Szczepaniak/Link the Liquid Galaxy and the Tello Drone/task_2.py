import tello
import time


drone = tello.Tello('192.168.10.2', 8888)

drone.takeoff() # start
time.sleep(5)

dron.set_speed(2) # set speed
time.sleep(1)

drone.move_up(3) # go up
time.sleep(5)

drone.rotate_cw(90) # rotate 90 - begin square
time.sleep(5)

drone.move_forward(5) # move 5
time.sleep(5)

drone.rotate_cw(90) # rotate
time.sleep(5)

drone.move_forward(10) # move 10
time.sleep(10)

drone.rotate_cw(90) # rotate
time.sleep(5)

drone.move_forward(10) # move 10
time.sleep(10)

drone.rotate_cw(90) # rotate
time.sleep(5)

drone.move_forward(10) # move 10
time.sleep(10)

drone.rotate_cw(90)
time.sleep(5)

drone.move_forward(5) # move 5 - end square
time.sleep(5)

drone.rotate_ccw(90) # rotate left
time.sleep(5)

drone.move_forward(10) # move 10 - line
time.sleep(10)

drone.rotate_cw(90) # rotate right - begin square
time.sleep(5)

drone.move_forward(5) # move 5
time.sleep(5)

drone.rotate_ccw(90) # rotate left
time.sleep(5)

drone.move_forward(10) # move 10
time.sleep(10)

drone.rotate_ccw(90) # rotate left
time.sleep(5)

drone.move_forward(10) # move 10
drone.sleep(5)

drone.rotate_ccw(90) # rotate left
time.sleep(5)

drone.move_forward(10) # move 10
time.sleep(10)

drone.rotate_ccw(90) # rotate left
time.sleep(5)

drone.move_forward(5) # move 5 - end square
time.sleep(5)

drone.land() # end fly
