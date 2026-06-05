"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word each day.
Author: Jonathan Schwartz
"""

load("encoding/json.star", "json")
load("http.star", "http")
load("render.star", "render")

URL = "https://raw.githubusercontent.com/jaschwa/word-worth-knowing/main/words.json"

def main(config):

    res = http.get(
        url = URL,
        ttl_seconds = 3600,
    )

    words = json.decode(res.body())

    entry = words[0]

    return render.Root(
        child = render.Column(
            children = [
                render.Text(
                    content = entry["word"].upper(),
                    font = "CG-pixel-4x5-mono",
                ),
                render.Text(
                    content = "(" + entry["pos"] + ")",
                    font = "CG-pixel-3x5-mono",
                ),
                render.WrappedText(
                    content = entry["definition"],
                    font = "CG-pixel-3x5-mono",
                ),
            ],
        ),
    )
