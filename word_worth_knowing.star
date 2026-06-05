"""
Applet: Word Worth Knowing
Summary: Displays a daily word worth knowing
Description: Shows one curated word each day, along with its definition and an example sentence.
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
data = get_cachable_data(WORDS_URL, 3600)
words = json.decode(data)

now = time.now()

# Day of year (001-366)
day_of_year = int(now.format("002")) - 1

word_count = len(words)

if word_count == 0:
    fail("No words found in words.json")

index = day_of_year % word_count

entry = words[index]

word = entry["word"].upper()
pos = entry.get("pos", "noun")
definition = entry["definition"]
example = entry["example"]

return render.Root(
    show_full_animation = True,
    delay = 10000,
    child = render.Animation(
        children = [
            # Screen 1 - Word
            render.Box(
                width = 64,
                height = 32,
                child = render.Text(
                    content = word,
                    font = "CG-pixel-4x5-mono",
                ),
            ),

            # Screen 2 - Definition
            render.Column(
                children = [
                    render.Text(
                        content = word + " (" + pos + ")",
                        font = "CG-pixel-3x5-mono",
                    ),
                    render.WrappedText(
                        content = definition,
                        font = "CG-pixel-3x5-mono",
                        linespacing = 1,
                    ),
                ],
            ),

            # Screen 3 - Example
            render.Column(
                children = [
                    render.Text(
                        content = word,
                        font = "CG-pixel-3x5-mono",
                    ),
                    render.WrappedText(
                        content = example,
                        font = "CG-pixel-3x5-mono",
                        linespacing = 1,
                    ),
                ],
            ),
        ],
    ),
)
```

def get_cachable_data(url, timeout):
res = http.get(
url = url,
ttl_seconds = timeout,
)

```
if res.status_code != 200:
    fail(
        "request to %s failed with status code: %d - %s" % (
            url,
            res.status_code,
            res.body(),
        )
    )

return res.body()
```
