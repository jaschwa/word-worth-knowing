"""
Applet: Test
"""

load("render.star", "render")

def main(config):
    return render.Root(
        child = render.Text(
            content = "HELLO",
        ),
    )
