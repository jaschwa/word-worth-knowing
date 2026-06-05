"""
Applet: Time Test
"""

load("render.star", "render")
load("time.star", "time")

def main(config):

    now = time.now()

    return render.Root(
        child = render.Text(
            content = str(now.day),
        ),
    )
