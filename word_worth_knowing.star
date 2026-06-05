"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word each day, along with its definition.
Author: Jonathan Schwartz

v1.0
Initial release
"""

load("encoding/json.star", "json")
load("http.star", "http")
load("render.star", "render")
load("time.star", "time")

WORDS_URL = "https://raw.githubusercontent.com/jaschwa/word-worth-knowing/main/words.json"

def main(config):

```
res = http.get(
    url = WORDS_URL,
    ttl_seconds = 3600,
)

if res.status_code != 200:
    fail("Unable to fetch words.json")

words = json.decode(res.body())

now = time.now()

# Simple daily selection
index = (now.day - 1) % len(words)

entry = words[index]

title = entry["word"].upper()
pos = entry["pos"]
definition = entry["definition"]

return render.Root(
    child = render.Column(
        children = [
            render.Box(height = 2),

            render.Text(
                content = title,
                font = "CG-pixel-4x5-mono",
            ),

            render.Text(
                content = "(" + pos + ")",
                font = "CG-pixel-3x5-mono",
            ),

            render.Box(height = 1),

            render.WrappedText(
                content = definition,
                font = "CG-pixel-3x5-mono",
                linespacing = 1,
            ),
        ],
    ),
)
```
