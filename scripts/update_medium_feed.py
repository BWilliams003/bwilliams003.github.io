#!/usr/bin/env python3
import argparse
import email.utils
import json
import re
import urllib.request
import xml.etree.ElementTree as ET
from datetime import datetime, timezone
from html import unescape


MEDIUM_FEEDS = [
    {"username": "B-Williams", "filter": None},
    {"username": "DeepHat", "filter": "Bailey"},
]

IMG_RE = re.compile(r'<img[^>]+src=["\']([^"\']+)["\']', re.IGNORECASE)
SUBTITLE_HEADING_RE = re.compile(r"<h[2-4][^>]*>(.*?)</h[2-4]>", re.IGNORECASE | re.DOTALL)
TAG_RE = re.compile(r"<[^>]+>")


def fetch_xml(url: str) -> str:
    req = urllib.request.Request(
        url,
        headers={
            "User-Agent": "Mozilla/5.0 (compatible; MediumFeedUpdater/1.0)",
            "Accept": "application/rss+xml, application/xml, text/xml;q=0.9, */*;q=0.8",
        },
    )
    with urllib.request.urlopen(req, timeout=30) as resp:
        return resp.read().decode("utf-8", errors="replace")


def parse_pub_date(pub_date: str) -> datetime:
    dt = email.utils.parsedate_to_datetime(pub_date)
    if dt is None:
        return datetime(1970, 1, 1, tzinfo=timezone.utc)
    if dt.tzinfo is None:
        return dt.replace(tzinfo=timezone.utc)
    return dt.astimezone(timezone.utc)


def clean_text(value: str) -> str:
    value = value or ""
    value = TAG_RE.sub("", value)
    return unescape(value).strip()


def extract_subtitle_from_medium(content_html: str, title: str) -> str:
    if not content_html:
        return ""
    # Use only explicit heading-like subtitle content from Medium markup.
    # If absent, return empty instead of deriving from body preview text.
    for match in SUBTITLE_HEADING_RE.finditer(content_html):
        candidate = clean_text(match.group(1))
        if not candidate:
            continue
        if candidate.lower() == (title or "").strip().lower():
            continue
        if len(candidate) > 180:
            candidate = candidate[:180].rsplit(" ", 1)[0].strip()
        return candidate
    return ""


def extract_thumbnail(content_html: str) -> str:
    if not content_html:
        return ""
    match = IMG_RE.search(content_html)
    return match.group(1) if match else ""


def should_keep_post(post: dict, filter_text: str | None) -> bool:
    if not filter_text:
        return True
    haystack = " ".join(
        [
            post.get("title", ""),
            post.get("description", ""),
            post.get("content", ""),
        ]
    ).lower()
    return filter_text.lower() in haystack


def parse_feed(xml_text: str, source: str, filter_text: str | None) -> list[dict]:
    root = ET.fromstring(xml_text)
    channel = root.find("channel")
    if channel is None:
        return []

    posts = []
    content_ns = "{http://purl.org/rss/1.0/modules/content/}"
    for item in channel.findall("item"):
        title = clean_text(item.findtext("title", default=""))
        link = (item.findtext("link", default="") or "").strip()
        pub_date_raw = (item.findtext("pubDate", default="") or "").strip()
        description_html = item.findtext("description", default="") or ""
        content_html = item.findtext(f"{content_ns}encoded", default="") or description_html
        description_text = clean_text(description_html)
        content_text = clean_text(content_html)
        subtitle_text = extract_subtitle_from_medium(content_html, title)

        post = {
            "source": source,
            "title": title,
            "link": link,
            "pubDate": pub_date_raw,
            "pubDateIso": parse_pub_date(pub_date_raw).isoformat(),
            "subtitle": subtitle_text,
            "description": description_text if description_text else subtitle_text,
            "content": content_text,
            "thumbnail": extract_thumbnail(content_html),
        }
        if should_keep_post(post, filter_text):
            posts.append(post)

    return posts


def main() -> None:
    parser = argparse.ArgumentParser(description="Fetch Medium posts into Jekyll data file.")
    parser.add_argument("--output", required=True, help="Output JSON path")
    parser.add_argument("--max-posts", type=int, default=20, help="Max posts to keep")
    args = parser.parse_args()

    all_posts: list[dict] = []
    for feed in MEDIUM_FEEDS:
        username = feed["username"]
        url = f"https://medium.com/feed/@{username}"
        xml_text = fetch_xml(url)
        all_posts.extend(parse_feed(xml_text, username, feed["filter"]))

    all_posts.sort(key=lambda p: p["pubDateIso"], reverse=True)
    trimmed = all_posts[: args.max_posts]

    payload = {
        "generated_at": datetime.now(timezone.utc).isoformat(),
        "posts": trimmed,
    }

    with open(args.output, "w", encoding="utf-8") as f:
        json.dump(payload, f, indent=2)
        f.write("\n")


if __name__ == "__main__":
    main()
