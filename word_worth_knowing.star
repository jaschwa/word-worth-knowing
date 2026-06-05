"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word each day with definition and example.
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
    entry = words[3]

    word = entry["word"].upper()
    pos = entry["pos"]
    definition = entry["definition"]
    example = entry["example"]

    return render.Root(
        show_full_animation = True,
        child = render.Column(
            children = [
                render.Marquee(
                    child = render.Column(
                        children = [
                            render.WrappedText(
                                content = word,
                                color = "#fa0",
                                font = "5x8",
                            ),
                            render.WrappedText(
                                content = "(" + pos + ")",
                                font = "5x8",
                            ),
                            render.WrappedText(
                                content = definition,
                                font = "5x8",
                            ),
                            render.WrappedText(
                                content = example,
                                font = "5x8",
                            ),
                        ],
                    ),
                    height = 25,
                    offset_start = 23,
                    scroll_direction = "vertical",
                ),
                render.Box(
                    height = 1,
                    color = "#00eeff",
                ),
                render.Text(
                    content = "WORD",
                    height = 6,
                    font = "CG-pixel-3x5-mono",
                ),
            ],
        ),
        delay = 140,
    )
