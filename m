Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3402CC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 16:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbiHRQcT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 12:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344767AbiHRQcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 12:32:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F126BD51
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 09:32:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFA6E14C50E;
        Thu, 18 Aug 2022 12:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OVWQp8z6wmzWJTbXsxat02pR885A7rW/1HHJ8i
        ZuUL4=; b=U5Y0HvtdikETp7OG60ty90aF6QGcIafk/DkgGRTUMQ0kDOmxG7rpdt
        00siRsBXnufVXLMPZoN9trO+DQNqaT5F8HJLreR0mry4FAAJxqFvC2n61ORROeC2
        ipZz6Rm9IsXtdmsSDgKsyF6dh8Pyr1qsUbAJ1eK9SeFSuWq8IKGrA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D787614C50C;
        Thu, 18 Aug 2022 12:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 50C3214C50B;
        Thu, 18 Aug 2022 12:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 0/2] Allow --ancestry-path to take an argument
References: <pull.1303.git.1660704498.gitgitgadget@gmail.com>
        <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com>
Date:   Thu, 18 Aug 2022 09:32:14 -0700
In-Reply-To: <pull.1303.v2.git.1660803467.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Thu, 18 Aug 2022 06:17:45
        +0000")
Message-ID: <xmqqy1vlqzqp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51ACEDC0-1F13-11ED-A738-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changes since v1:
>
>  * Tweaked the commit message, and incorporated Junio's suggestion to update
>    left_flag and ancestry_flag together.

Thanks, will replace and queue.
