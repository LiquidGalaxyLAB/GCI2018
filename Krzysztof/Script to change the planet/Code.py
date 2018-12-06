from appJar import gui

def press(button):
    createOpenableFile(button)

def createOpenableFile(planet):
    with open("query.txt", "w") as tf:
        tf.write("planet={0}".format(planet))

app = gui("Google Earth Planet Chooser", "200x100", showIcon=False)
app.setBg("#F19D38", override=True, tint=True)
app.setFg("black", override=True)
app.addLabel("title", "Choose Planet")
app.setLabelFg("title", "#212121")
app.addButtons(["earth", "mars", "moon"], press)
app.setButtonBg("earth" ,"#4F4CAA")
app.setButtonFg("earth", "#A6C070")
app.setButtonBg("mars" ,"#B34D24")
app.setButtonFg("mars" ,"white")
app.setButtonBg("moon" ,"#C9C9C9")
app.setButtonFg("moon" ,"Black")
app.go()
