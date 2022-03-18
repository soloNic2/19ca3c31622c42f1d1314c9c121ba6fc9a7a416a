Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AA6C433EF
	for <git@archiver.kernel.org>; Fri, 18 Mar 2022 18:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiCRSZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Mar 2022 14:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238303AbiCRSZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Mar 2022 14:25:34 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8328A6E02
        for <git@vger.kernel.org>; Fri, 18 Mar 2022 11:24:14 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7830B105BC0;
        Fri, 18 Mar 2022 14:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8x7zilFJTVqPabC/alYe3E7O1naB9Fy+mvSgXY
        2MpTQ=; b=F5Lc+N1HbvPJWGcmVfFOBmogbzDNXfkH0i5hQb6Z9YUXZN2mo22jkW
        KIAfTCyiphxHT1Y8dCCFK8jv/lPcxFJAc5Op/6URCCOxWQ4vO4CtTxllwz1ssJ3l
        9+V/Jdar3NFX0Kj121ilUWKoZpzf2ROm4WqFX53A7F2aA8w3O5aus=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 708B2105BBF;
        Fri, 18 Mar 2022 14:24:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BECEE105BBE;
        Fri, 18 Mar 2022 14:24:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Erik Cervin Edin <erik@cervined.in>
Cc:     wuzhouhui <wuzhouhui14@mails.ucas.ac.cn>, git@vger.kernel.org
Subject: Re: how to automatically open conflicted files when "git rebase"
 encounter conflict
References: <bc7b04de-17be-df86-1c93-792903eeec9b@mails.ucas.ac.cn>
        <CA+JQ7M8_QiidajaWJpz3gFeUXiLMLiDA38W1mnWyxnMLJN3fpQ@mail.gmail.com>
Date:   Fri, 18 Mar 2022 11:24:10 -0700
In-Reply-To: <CA+JQ7M8_QiidajaWJpz3gFeUXiLMLiDA38W1mnWyxnMLJN3fpQ@mail.gmail.com>
        (Erik Cervin Edin's message of "Fri, 18 Mar 2022 17:00:37 +0100")
Message-ID: <xmqqpmmj9l11.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9BC9EDF2-A6E8-11EC-87AB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Erik Cervin Edin <erik@cervined.in> writes:

> In the situations of more complicated conflicts (as well as the
> functionality you request) can be invoked using
>   git mergetool
>   git mergetool -- 'pathspec'
>   git mergetool --tool=vimdiff -- 'pathspec'

Yeah, I forgot all about "git mergetool".  I think that is the
official answer to the original question.
