# What it the route?
Obviously, the route is not the router, and there are two scopes:

1. Network
2. Internet

Curiously, no matter the network or the internet, the IP route is there always. This gives a fact that `which the protocol used is important` or `what are the important parts to build the network or internet?`

## The route of the HTTP
Here is an example of the HTTP request:

```
curl -I 'http://cn.bing.com'
        --------------------
                 |
                 |
                 v
                URL

Method Path  Version of the protocol
 ^      ^      ^
 |      |      |
 |  -----      |
 |  |     ------
 |  |     |
--- - --------
HTTP/1.1 200 OK
Cache-Control: private
Content-Length: 0
Content-Type: text/html; charset=utf-8
P3P: CP="NON UNI COM NAV STA LOC CURa DEVa PSAa PSDa OUR IND"
Set-Cookie: SUID=M; domain=.bing.com; expires=Tue, 31-May-2022 12:10:22 GMT; path=/; HttpOnly
Set-Cookie: MUID=0FAC107F34D96C7D36E401CB359A6DB6; domain=.bing.com; expires=Sat, 24-Jun-2023 12:10:22 GMT; path=/
Set-Cookie: MUIDB=0FAC107F34D96C7D36E401CB359A6DB6; expires=Sat, 24-Jun-2023 12:10:22 GMT; path=/; HttpOnly
Set-Cookie: _EDGE_S=F=1&SID=03685494803B640C0B524520817865C6; domain=.bing.com; path=/; HttpOnly
Set-Cookie: _EDGE_V=1; domain=.bing.com; expires=Sat, 24-Jun-2023 12:10:22 GMT; path=/; HttpOnly
Set-Cookie: SRCHD=AF=NOFORM; domain=.bing.com; expires=Thu, 30-May-2024 12:10:22 GMT; path=/
Set-Cookie: SRCHUID=V=2&GUID=EB30DB7FCCFE437A98445BCDBBD9DC88&dmnchg=1; domain=.bing.com; expires=Thu, 30-May-2024 12:10:22 GMT; path=/
Set-Cookie: SRCHUSR=DOB=20220530; domain=.bing.com; expires=Thu, 30-May-2024 12:10:22 GMT; path=/
Set-Cookie: SRCHHPGUSR=SRCHLANG=zh-Hans; domain=.bing.com; expires=Thu, 30-May-2024 12:10:22 GMT; path=/
Set-Cookie: _SS=SID=03685494803B640C0B524520817865C6; domain=.bing.com; path=/
Set-Cookie: ULC=; domain=.bing.com; expires=Sun, 29-May-2022 12:10:22 GMT; path=/
Set-Cookie: _HPVN=CS=eyJQbiI6eyJDbiI6MSwiU3QiOjAsIlFzIjowLCJQcm9kIjoiUCJ9LCJTYyI6eyJDbiI6MSwiU3QiOjAsIlFzIjowLCJQcm9kIjoiSCJ9LCJReiI6eyJDbiI6MSwiU3QiOjAsIlFzIjowLCJQcm9kIjoiVCJ9LCJBcCI6dHJ1ZSwiTXV0ZSI6dHJ1ZSwiTGFkIjoiMjAyMi0wNS0zMFQwMDowMDowMFoiLCJJb3RkIjowLCJHd2IiOjAsIkRmdCI6bnVsbCwiTXZzIjowLCJGbHQiOjAsIkltcCI6MX0=; domain=.bing.com; expires=Thu, 30-May-2024 12:10:22 GMT; path=/
X-SNR-Routing: 1
X-Cache: CONFIG_NOCACHE
X-MSEdge-Ref: Ref A: 1C5B20A7C68145699F2DCAD8F58DFFDD Ref B: BJ1EDGE0412 Ref C: 2022-05-30T12:10:22Z
Date: Mon, 30 May 2022 12:10:21 GMT
```

Look at the above! In fact, the URL is the route of the HTTP, right? Totally Yes.

So the route has one entity to describe at the protocol or domain `HTTP`. I love the word - `domain`, that is a change to categorize something and diff it from others.

Summary:

`The route of the HTTP` is a URL which is an application entity of the `route`

# References
* [Network Routing](https://www.wikiwand.com/en/Routing)
* [TCP/IP routing](https://www.ibm.com/docs/en/aix/7.1?topic=protocol-tcpip-routing)
* [HTTP Route](https://docs.digitalocean.com/products/app-platform/concepts/http-route/#:~:text=The%20HTTP%20route%20for%20a,the%20root%20of%20your%20service.)
* [MDN HTTP](https://developer.mozilla.org/en-US/docs/Web/HTTP)
* [What is the URL](https://developer.mozilla.org/en-US/docs/Learn/Common_questions/What_is_a_URL)
* [Difference between Network and Internet](https://www.geeksforgeeks.org/difference-between-network-and-internet/#:~:text=1.,limited%20in%20comparison%20of%20internet.)
* [Front end routing Hash and History mode](https://programmer.group/front-end-routing-hash-and-history-mode.html)
