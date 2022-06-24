Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8A8C43334
	for <git@archiver.kernel.org>; Fri, 24 Jun 2022 01:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbiFXBOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 21:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiFXBOQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 21:14:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAA5675E
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 18:14:15 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26380140BCD;
        Thu, 23 Jun 2022 21:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=68CanB4ssLBV
        KxrHLtCgwFEDlxzEHA3fuDpOXluUmFk=; b=s5Tzc1f6BC/ikGEX9dZF0K9Nf5ZU
        gZUfIP+A1R9NIOu4SODYj7xBqTGliBMbNASq9RxOzPh6WviJGe6bfSOfbXiCyX0v
        vKk1eYm0PjP/JSmTG0msF/rGTDR4RipeSUiSjQYn+m08pXsDh6fJS4jKIMfgPo1p
        WmIkNFlXi6DvCro=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1E06A140BCC;
        Thu, 23 Jun 2022 21:14:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E386140BCB;
        Thu, 23 Jun 2022 21:14:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
        <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
        <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
        <220622.86r13hkp2c.gmgdl@evledraar.gmail.com>
        <xmqq7d587lqx.fsf@gitster.g>
        <220623.865ykrll0j.gmgdl@evledraar.gmail.com>
        <xmqq7d57x8qo.fsf@gitster.g>
        <220624.86bkuikidi.gmgdl@evledraar.gmail.com>
Date:   Thu, 23 Jun 2022 18:14:12 -0700
In-Reply-To: <220624.86bkuikidi.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 24 Jun 2022 01:45:35 +0200")
Message-ID: <xmqq35fuyiaj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F5A28CDA-F35A-11EC-9675-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> would be in practice, i.e. I download downstream package recipies, whic=
h
> are found at (name, relative path & urls). I also manually get the AIX
> package:
> ...
> 	macports-ports  devel/git       https://github.com/macports/macports-p=
orts.git
>
> Looking through all of those none of them do anything with
> gitweb/Makefile. I.e. all "make gitweb" at the top-level, or simply rel=
y
> on "make install" to install it.

Now we are talking.  Giving that as a datapoint upfront in the
proposed log message would have saved needless round-trip, I would
think.

Thanks.
