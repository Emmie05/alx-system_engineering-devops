import requests

#!/usr/bin/python3
"""
Script that queries subscribers on a given Reddit subreddit.
"""

def number_of_subscribers(subreddit):
    """
    Return the total number of subscribers on a given subreddit.

    Args:
        subreddit (str): The subreddit to query.

    Returns:
        int: Number of subscribers, or 0 if the subreddit is invalid.
    """
    url = f"https://www.reddit.com/r/{subreddit}/about.json"
    headers = {"User-Agent": "Mozilla/5.0"}
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        try:
            data = response.json()
            return data['data']['subscribers']
        except KeyError:
            return 0
    return 0
