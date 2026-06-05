"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word with its definition and example.
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

if res.status_code != 200:
    return render.Root(
        child = render.Text(
            content = "FETCH ERROR",
        ),
    )

words = json.decode(res.body())

entry = words[3]

word = entry["word"].upper()
pos = entry["pos"]
definition = entry["definition"]

return render.Root(
    child = render.Marquee(
        child = render.Column(
            children = [
                render.Text(content = word),
                render.Text(content = "(" + pos + ")"),
                render.Text(content = definition),
            ],
        ),
        height = 25,
        offset_start = 23,
        scroll_direction = "vertical",
    ),
)
