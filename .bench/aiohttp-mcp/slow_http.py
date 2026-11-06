"""A pytest plugin that adds 30 ms before every aiohttp client request, as on a loaded CI runner."""

import asyncio

import aiohttp

_request = aiohttp.ClientSession._request


async def _slow_request(self, *args, **kwargs):
    await asyncio.sleep(0.03)
    return await _request(self, *args, **kwargs)


aiohttp.ClientSession._request = _slow_request
