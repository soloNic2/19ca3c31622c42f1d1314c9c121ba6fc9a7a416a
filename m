Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70F7FC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 18:58:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiHPS6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 14:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiHPS6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 14:58:13 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F1D20F5A
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 11:58:12 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B640C1A5AD5;
        Tue, 16 Aug 2022 14:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hntcjST+IRAQopeTMov4bpP+zg2BdzilIyfk7v
        0/xiY=; b=chj1k4CX4MU6cQ/78nNkttaqBX8uTIzDijIhvemDNUT7CZyDP1bey+
        0+43iM4ht89X4qUrPmxtUsaflYhlhx9yZnF0lVLHwnVHENaJN5P4NMWF7Rx3OjZY
        LEdMluJN46bpBRgic3YvxP+A8VwS5/eh0sotZ064jbtg8CsTuzInM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADF691A5AD4;
        Tue, 16 Aug 2022 14:58:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 789681A5AD3;
        Tue, 16 Aug 2022 14:58:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, newren@gmail.com, Johannes.Schindelin@gmx.de,
        avarab@gmail.com
Subject: Re: [PATCH v8] submodule merge: update conflict error message
References: <20220728211221.2913928-1-calvinwan@google.com>
        <20220804195105.1303455-1-calvinwan@google.com>
        <xmqqczd0xjrp.fsf@gitster.g>
Date:   Tue, 16 Aug 2022 11:58:05 -0700
In-Reply-To: <xmqqczd0xjrp.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
        16 Aug 2022 08:58:34 -0700")
Message-ID: <xmqqk078t3r6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5CF26F90-1D95-11ED-AE36-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> +			 * languages, the following swap is suggested:
>> +			 *      "   %s\n" -> "%s   \n"
>> +			 */
>> +			strbuf_addf(&tmp, _("   %s\n"), msg_list.items[i].string);
>> +	}
>> +	strbuf_reset(msg);
>> +	strbuf_add(msg, tmp.buf, tmp.len);
>> +}
>
> Here, tmp is not released, and mst_list holds the words split out of msg.

FWIW, with this fixed, the tip of 'seen' passes the linux-leaks CI
job.

>  merge-ort.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git i/merge-ort.c w/merge-ort.c
> index 4cb92bdff8..cdb53770be 100644
> --- i/merge-ort.c
> +++ w/merge-ort.c
> @@ -4507,6 +4507,8 @@ static void format_submodule_conflict_suggestion(struct strbuf *msg) {
>  	}
>  	strbuf_reset(msg);
>  	strbuf_add(msg, tmp.buf, tmp.len);
> +	string_list_clear(&msg_list, 0);
> +	strbuf_release(&tmp);
>  }
>  
>  static void print_submodule_conflict_suggestion(struct string_list *csub) {
