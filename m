Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C96C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 15:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230484AbjCIPgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 10:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjCIPf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 10:35:59 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56411EBCC
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 07:35:50 -0800 (PST)
Received: (qmail 10004 invoked by uid 109); 9 Mar 2023 15:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 15:35:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32328 invoked by uid 111); 9 Mar 2023 15:35:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 10:35:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 10:35:46 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: Fetching everything in another bare repo
Message-ID: <ZAn80gnIFLOF4Gco@coredump.intra.peff.net>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
 <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
 <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <64282d0f99df59085a18585846d2086a652677e2.camel@mad-scientist.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 09, 2023 at 08:55:27AM -0500, Paul Smith wrote:

> > OK. It's not clear to me if this archive repo retains the old
> > references, or if it simply has a bunch of unreachable objects.
> > That distinction will matter below.
> 
> Sorry; I've been using Git for a long time but am still not totally
> immersed in the terminology :).
> 
> Basically, these bare clones have "gc.pruneExpire=never" set, and have
> never had any GC operations run so all commits are still present (when
> you say "unreachable" I assume you mean, not reachable through any
> reference).

Right, that's what I mean by unreachable. And no, you didn't use any
terminology wrong. I was just not sure if you realized that running
"fetch" would not get the unreachable objects. :)

> There is a separate database of information containing SHAs for these
> commits, that is used to find them, but there is nothing in Git itself
> that references them so they are indeed unreachable as far as Git is
> concerned.

OK, that makes sense (and I've done something like that before, as
well).

> Oh interesting.  I did a quick verification and all of the objects /
> packfiles in the old clone either don't exist in the new one, or are
> identical.  I'm sure you expected that but I needed to reassure myself
> I wouldn't be overwriting anything :).

The files are named after the sha1 of their contents (and that goes for
both loose objects and packfiles). But certainly it's a good idea to
double check that nothing funny is going on.

> One question: is the objects/info/packs file anything to be concerned
> about or will git repack (or something) take care of handling it?

You can ignore it.  It will be regenerated by git-repack. But also, it's
pretty useless these days. It's only used for "dumb" fetches (e.g., when
you export a repo via static http, but without using the git-aware CGI).

> > And then you can do any ref updates in the new repository (since it
> > now has all objects from both).
> 
> It's actually possible that I don't care about refs at all.  I might
> only care about objects.  I'm not sure, I can check what exists in the
> old clone.

Yeah, if you have a separate database of branch tips, etc, then the refs
aren't necessary. As long as you are careful not to run "gc" or repack
without "-k".

You may want to try the "preciousObjects" repository extension, which
was designed to prevent accidents for a case like this. Something like:

  [this will cause old versions of Git that don't understand
   extensions.* to bail on all commands for safety]
  $ git config core.repositoryformatversion 1

  [this will tell old versions of Git that don't understand this
   particular extension to bail on all commands for safety. But more
   importantly, it will tell recent versions (> 2.6.3) to allow most
   commands, but not ones that would delete unreachable objects]
  $ git config extensions.preciousObjects true

  [this is it in action]
  $ git repack -ad
  fatal: cannot delete packs in a precious-objects repo
  $ git prune
  fatal: cannot prune in a precious-objects repo

Sadly it's not quite smart enough to realize that "git repack -adk" is
safe. If you want to occasionally repack with that, you'd have to
manually disable the flag for a moment.

I will also say that while I implemented this extension a while back, it
never actually saw production use for my intended case. So I think it's
pretty good (and certainly safer than nothing), but it's not thoroughly
tested in the wild.

-Peff
