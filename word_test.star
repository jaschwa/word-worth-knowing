"""
Applet: Word Test
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
        child = render.Text(
            content = entry["word"],
        ),
    )
