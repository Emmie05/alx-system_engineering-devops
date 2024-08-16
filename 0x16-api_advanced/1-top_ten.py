#!/usr/bin/python3
""" This module contains the function top_ten. """


import requests


def top_ten(subreddit):
    """
        Prints the titles of the first 10 hot posts listed for a given subreddit.

        Args:
            subreddit (str): The subreddit to query.
    """
    headers = {'User-Agent': 'Mozilla/5.0'}
    url = 'https://www.reddit.com/r/{}/hot/.json?limit=10'.format(subreddit)
    response = requests.get(url, headers=headers, allow_redirects=False)
    
    if response.status_code == 200:
        try:
            data = response.json()
            posts = data.get('data', {}).get('children', [])
            if posts:
                for post in posts:
                    print(post.get('data', {}).get('title', ''))
            else:
                print(None)
        except ValueError:
            print(None)
    else:
        print(None)
