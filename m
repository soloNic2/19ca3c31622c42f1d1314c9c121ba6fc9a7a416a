Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E3C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 16:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ2Qgy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 12:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ2Qgx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 12:36:53 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D285244A
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 09:36:52 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ooopC-0005Pc-A7;
        Sat, 29 Oct 2022 17:36:46 +0100
Message-ID: <c49fce45-bbd6-a456-234c-7f9709ae4d51@iee.email>
Date:   Sat, 29 Oct 2022 17:36:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v2 3/3] glossary: add reachability bitmap description
Content-Language: en-GB
To:     Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Cc:     GitList <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <20221022222539.2333-1-philipoakley@iee.email>
 <20221022222539.2333-4-philipoakley@iee.email>
 <CAPOJW5zmYC9q8+aXh9-kZnvT28GQ1ud3LenFi9qxV4DVdCWKxg@mail.gmail.com>
 <xmqq1qqxuqf0.fsf@gitster.g> <746491f4-fb41-92fe-7360-20a845dc21fc@iee.email>
 <c9e90df3-6f70-6422-00db-beb7afda0439@github.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <c9e90df3-6f70-6422-00db-beb7afda0439@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/10/2022 13:34, Derrick Stolee wrote:
> On 10/24/2022 5:23 PM, Philip Oakley wrote:
>> On 24/10/2022 17:39, Junio C Hamano wrote:
>>> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>>>
>>>> Small correction here - A repository may have multiple bitmaps (one
>>>> for each selected commit from the preferred packfile or a
>>>> multi-pack-index) but it can have only one ".bitmap" file (as of now).
>>>> Bitmaps for the selected commits are stored in that ".bitmap" file.
>>>> So I think the below lines (or similar) will work  -
>>>>
>>>>     The bitmaps are stored in a ".bitmap" file. A repository may have
>>>>     at most one ".bitmap" file. The file may belong to either one pack, or the
>>>>     repository's multi-pack-index (if it exists).
>>>>
>>>> Feel free to rephrase it accordingly.
>>> Sounds good to me.  Or Philip's original can be tweaked minimally to
>>> say "... may have at most one bitmap file (which stores multiple
>>> bitmaps)".
>>>
>> Thanks both. I'll tweak the description in a day or so to allow Stolee
>> to comment if required.
> I added my comments about the commit-graph file, and agree with
> Abhradeep's suggestions here.
>
> Adding Taylor as a possible reviewer, too.
>
> The one thing I will say is that there can be multiple .bitmap
> files, but Git will only use one of them. Not sure if that is
> worth being pedantic about here, though.
>
> We'll need to keep this glossary section in mind in case things
> change (such as "at most one bitmap file").
>
> Thanks,
> -Stolee
I've gone with the phrase "at most one bitmap file in use." here.

The updated series should be sent shortly.

Philip.
