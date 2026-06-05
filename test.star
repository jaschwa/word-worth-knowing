"""
Applet: HTTP Test
"""

load("http.star", "http")
load("render.star", "render")

URL = "https://raw.githubusercontent.com/jaschwa/word-worth-knowing/main/words.json"

def main(config):

    res = http.get(
        url = URL,
        ttl_seconds = 3600,
    )

    return render.Root(
        child = render.Text(
            content = str(res.status_code),
        ),
    )
