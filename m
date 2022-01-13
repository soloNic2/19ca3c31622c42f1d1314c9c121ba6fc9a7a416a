Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756CEC433EF
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 22:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiAMWq5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 17:46:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54507 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiAMWq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 17:46:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CCF81016EE;
        Thu, 13 Jan 2022 17:46:55 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=l3UKhDr3z8kr
        DfGkOl+VoXeTctKTyKaeLgeQMgQlCTo=; b=RJnASqgnzG6ZrH88MAZVyQf4nO5c
        MX/eyqHZD/nvTHCHAng7iIN+zQ6/1Cjn0UjWwLs+eir/SdTlbXKIsndfpZ/eAqQT
        T0TZT3vUy6s1hKWbGcRDWq0cH4QeyqP9OMbP0+5TOdhXbwnTahqjBVcHp0wILCN2
        nRqQgWUUWFo90rw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 636DD1016ED;
        Thu, 13 Jan 2022 17:46:55 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CD0531016EB;
        Thu, 13 Jan 2022 17:46:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v7 4/6] object-name: show date for ambiguous tag objects
References: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com>
        <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
Date:   Thu, 13 Jan 2022 14:46:53 -0800
In-Reply-To: <patch-v7-4.6-2e5511c9fa5-20220111T130811Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 12 Jan
 2022 13:39:23
        +0100")
Message-ID: <xmqq1r1bgso2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B4DDB056-74C2-11EC-977A-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  	} else if (type =3D=3D OBJ_TAG) {
>  		struct tag *tag =3D lookup_tag(ds->repo, oid);
>  		const char *tag_tag =3D "";
> +		timestamp_t tag_date =3D 0;

How about leaving these two uninitialized and introduce one extra
bool,
		int tag_info_valid =3D 0;

and then

> =20
> -		if (!parse_tag(tag) && tag->tag)
> +		if (!parse_tag(tag) && tag->tag) {
>  			tag_tag =3D tag->tag;
> +			tag_date =3D tag->date;

			tag_info_valid =3D 1;

> +		}
> =20
>  		/*
>  		 * TRANSLATORS: This is a line of
>  		 * ambiguous tag object output. E.g.:
>  		 *
> -		 *    "deadbeef tag Some Tag Message"
> +		 *    "deadbeef tag 2021-01-01 - Some Tag Message"
>  		 *
>  		 * The second argument is the "tag" string from
>  		 * object.c.
>  		 */
> -		strbuf_addf(&desc, _("%s tag %s"), hash, tag_tag);
> +		strbuf_addf(&desc, _("%s tag %s - %s"), hash,
> +			    show_date(tag_date, 0, DATE_MODE(SHORT)),
> +			    tag_tag);

Then this part can use tag_info_valid to conditionally use tag_date
and tag_tag:

		if (tag_info_valid)
			strbuf_addf(&desc, ... <hash,date,tag>);
		else
			strbuf_addf(&desc, _("%s tag [bad]"), hash);

without throwing a misleading "In 1970 this happened".

>  	} else if (type =3D=3D OBJ_TREE) {
>  		/*
>  		 * TRANSLATORS: This is a line of ambiguous <type>
