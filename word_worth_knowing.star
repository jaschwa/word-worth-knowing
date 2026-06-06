"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word each day with definition and example.
Author: Jonathan Schwartz
"""

load("encoding/json.star", "json")
load("hash.star", "hash")
load("http.star", "http")
load("math.star", "math")
load("render.star", "render")
load("time.star", "time")

URL = "https://raw.githubusercontent.com/jaschwa/word-worth-knowing/main/words.json"

def main(config):
    res = http.get(
        url = URL,
        ttl_seconds = 3600,
    )

    words = json.decode(res.body())

    date = str(time.now())[0:10]
    word_index = abs(int(math.remainder(int(hash.md5(date), 16), len(words))))
    entry = words[word_index]

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
                                color = "#f00",
                                font = "5x8",
                            ),
                        ],
                    ),
                    height = 25,
                    offset_start = 32,
                    offset_end = 32,
                    scroll_direction = "vertical",
                ),
                render.Box(
                    height = 1,
                    color = "#00eeff",
                ),
                render.Marquee(
                    child = render.Text(
                        content = "Word of the Day",
                        height = 6,
                        font = "CG-pixel-3x5-mono",
                    ),
                    width = 64,
                    scroll_direction = "horizontal",
                ),
            ],
        ),
        delay = 140,
    )
