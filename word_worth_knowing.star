"""
Applet: Word Worth Knowing
"""

load("render.star", "render")

def main(config):
    return render.Root(
        child = render.Text(
            content = "JONATHAN TEST",
        ),
    )