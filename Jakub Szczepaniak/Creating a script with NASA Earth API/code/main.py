import pygame
from PIL import Image
import requests


def load_images():
    images_list = []
    for i in range(1, 13):
        content = requests.get(
            "https://api.nasa.gov/planetary/earth/imagery/?lon=16.0900859&lat=51.6635026&date=2016-{0}-10&dim=0.025&api_key=zjGppzmcvBnbbtW16935UM3mE9CVWhZ3B3FdF5Al".format('0' + str(i) if i < 10 else i)).json()
        if 'url' in content:
            image_downloaded = Image.open(requests.get(content['url'], stream=True).raw)
            file_name = 'images/image{0}.png'.format(str(i))
            image_downloaded.save(file_name)
            images_list.append(pygame.image.load(file_name))
            print("2016-{0}-01 - downloaded".format('0' + str(i) if i < 10 else i))

    return images_list


images = load_images()
number = 0

pygame.init()
pygame.font.init()

white = (255, 255, 255)

display = pygame.display.set_mode((512, 512))
pygame.display.set_caption("Time lapse")

font = pygame.font.SysFont('Arial', 30)

run = True
image = images[number]
clock = pygame.time.Clock()
text = font.render("2016-01 Glogow", False, white)
tick = pygame.time.get_ticks()

while run:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            run = False

    seconds = (pygame.time.get_ticks()-tick)/1000
    if seconds > 3:
        tick = pygame.time.get_ticks()
        number += 1

        if number >= 12: number = 0

        image = images[number]
        text = font.render('2016-{0} Glogow'.format('0' + str(number + 1) if number + 1 < 10 else number + 1), False, white)

    display.fill(white)
    display.blit(image, (0, 0))
    display.blit(text, (150, 450))

    pygame.display.update()
    clock.tick(60)

pygame.quit()
quit()




