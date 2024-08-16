#!/usr/bin/python3
""" Contains recurse function """


import requests


def recurse(subreddit, hot_list=[], after=None):
    """
    Returns a list of titles of all hot posts on a given subreddit.
    """
    
    
    url = "https://www.reddit.com/r/{}/hot/.json".format(subreddit)
    headers = {
        "User-Agent": "0x16-api_advanced:project:v1.0.0 (by /u/firdaus_cartoon_jr)"
    }
    params = {
        "after": after,
        "limit": 100
    }
    response = requests.get(url, headers=headers, params=params, allow_redirects=False)
    
    if response.status_code == 404:
        return None

    try:
        results = response.json().get("data")
        after = results.get("after")
        for post in results.get("children", []):
            hot_list.append(post.get("data", {}).get("title", ""))
        
        if after:
            return recurse(subreddit, hot_list, after)
        return hot_list

    except ValueError:
        return None
