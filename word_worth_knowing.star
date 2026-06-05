"""
Applet: Word Worth Knowing
"""

load("encoding/json.star", "json")
load("http.star", "http")
load("render.star", "render")
load("time.star", "time")

URL = "https://raw.githubusercontent.com/jaschwa/word-worth-knowing/main/words.json"

def main(config):

    res = http.get(
        url = URL,
        ttl_seconds = 3600,
    )

    words = json.decode(res.body())

    now = time.now()

    index = now.day - 1

    if index >= len(words):
        index = index % len(words)

    entry = words[index]

    text = entry["word"] + " (" + entry["pos"] + ")"

    return render.Root(
        child = render.Text(
            content = text,
        ),
    )
