Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87D6C38A2D
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 23:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJUX3k (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 19:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiJUX3i (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 19:29:38 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1592EF55
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 16:29:35 -0700 (PDT)
Received: (qmail 14855 invoked by uid 109); 21 Oct 2022 23:29:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Oct 2022 23:29:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18101 invoked by uid 111); 21 Oct 2022 23:29:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Oct 2022 19:29:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Oct 2022 19:29:34 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jan =?utf-8?Q?Pokorn=C3=BD?= <poki@fnusa.cz>
Subject: Re: [PATCH 1/4] repack: convert "names" util bitfield to array
Message-ID: <Y1MrXoobkVKngYL1@coredump.intra.peff.net>
References: <Y1MR7V8kGolLd8eh@coredump.intra.peff.net>
 <Y1MSWAx+baTklfLL@coredump.intra.peff.net>
 <Y1Mm9zTX3XwN3IWu@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y1Mm9zTX3XwN3IWu@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 21, 2022 at 07:10:47PM -0400, Taylor Blau wrote:

> > +	struct generated_pack_data *data = xcalloc(1, sizeof(*data));
> 
> I'm nitpicking, but we could replace this with;
> 
>   struct generated_pack_data *data;
> 
>   CALLOC_ARRAY(data, 1);
> 
> so that we don't have to rely on calling sizeof(*data). But
> sizeof(*data) will always give us the right answer anyway, even if the
> name of data's type changed, so what you have is fine, too.

Yeah, I actually considered writing it that way, but it felt a bit silly
to use _ARRAY for something which is clearly meant to be a single item.
Grepping for "CALLOC_ARRAY([^)]*, 1)" does seem to turn up quite a few
hits, though, so maybe it is just me.

We could also introduce:

  #define CALLOC(x) CALLOC_ARRAY((x), 1)

but even if we think that is a good idea, it should not be in this
series.

It looks I may re-roll for the fname_old stuff in the other part of the
thread, so I'll take your suggestion.

-Peff
