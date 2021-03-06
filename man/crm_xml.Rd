% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/crm_xml.R
\name{crm_xml}
\alias{crm_xml}
\title{Get full text XML}
\usage{
crm_xml(url, overwrite_unspecified = FALSE, ...)
}
\arguments{
\item{url}{A URL (character) or an object of class \code{tdmurl} from a call
to \code{\link[=crm_links]{crm_links()}}. If you'll be getting text from the publishers are use
Crossref TDM (which requires authentication), we strongly recommend
using \code{\link[=crm_links]{crm_links()}} first and passing output of that here, as \code{\link[=crm_links]{crm_links()}}
grabs the publisher Crossref member ID, which we use to do authentication
and other publisher specific fixes to URLs}

\item{overwrite_unspecified}{(logical) Sometimes the crossref API returns
mime type 'unspecified' for the full text links (for some Wiley dois
for example). This parameter overrides the mime type to be \code{type}.}

\item{...}{Named curl options passed on to \link[crul:verb-GET]{crul::verb-GET}, see
\code{curl::curl_options()} for available curl options. See especially the
User-agent section below}
}
\description{
Get full text XML
}
\details{
Note that this function is not vectorized. To do many requests
use a for/while loop or lapply family calls, or similar.

Note that some links returned will not in fact lead you to full text
content as you would understandbly think and expect. That is, if you
use the \code{filter} parameter with e.g., \code{\link[rcrossref:cr_works]{rcrossref::cr_works()}}
and filter to only full text content, some links may actually give back
only metadata for an article. Elsevier is perhaps the worst offender,
for one because they have a lot of entries in Crossref TDM, but most
of the links that are apparently full text are not in facct full text,
but only metadata.

Check out \link{auth} for details on authentication.
}
\section{User-agent}{

You can optionally set a user agent string with the curl option \code{useragent},
like \code{crm_text("some doi", "pdf", useragent = "foo bar")}.
user agent strings are sometimes used by servers to decide whether to
provide a response (in this case, the full text article). sometimes, a
browser like user agent string will make the server happy. by default all
requests in this package have a user agent string like
\verb{libcurl/7.64.1 r-curl/4.3 crul/0.9.0}, which is a string with the names
and versions of the http clients used under the hood. If you supply
a user agent string using the \code{useragent} curl option, we'll use it instead.
For more information on user agent's, and exmaples of user agent strings you
can use here, see
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/User-Agent
}

\examples{
\dontrun{
## peerj
x <- crm_xml("https://peerj.com/articles/2356.xml")

## pensoft
data(dois_pensoft)
(links <- crm_links(dois_pensoft[1], "all"))
### xml
crm_xml(url=links)
}
}
