"""
Applet: Test Layout
"""

load("render.star", "render")

def main(config):
    return render.Root(
        child = render.Column(
            children = [
                render.Text("SAUDADE"),
                render.Text("(concept)"),
                render.Text("Longing"),
            ],
        ),
    )
