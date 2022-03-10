Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACD8C433F5
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 14:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243912AbiCJOc3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 09:32:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343934AbiCJOba (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 09:31:30 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A0BE98E4
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 06:28:47 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 773A93F4165;
        Thu, 10 Mar 2022 09:28:46 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3C0D43F4148;
        Thu, 10 Mar 2022 09:28:46 -0500 (EST)
Subject: Re: [PATCH v2 25/27] t/lib-unicode-nfc-nfd: helper prereqs for
 testing unicode nfc/nfd
To:     Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
 <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
 <5a0c1b7a2873accc6db4b34493962378819eacd4.1646777728.git.gitgitgadget@gmail.com>
 <af6c456a-d49f-e0f2-50ae-f44fdb6351e3@github.com>
 <6555f3dc-e72c-2b0f-fe66-d81d48dff6f7@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1b35ccf2-fe23-145d-53b9-4a0cbb5bba8b@jeffhostetler.com>
Date:   Thu, 10 Mar 2022 09:28:45 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <6555f3dc-e72c-2b0f-fe66-d81d48dff6f7@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/9/22 1:42 PM, Derrick Stolee wrote:
> On 3/9/2022 1:40 PM, Derrick Stolee wrote:
>> On 3/8/2022 5:15 PM, Jeff Hostetler via GitGitGadget wrote:
>>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>>
>>> Create a set of prereqs to help understand how file names
>>> are handled by the filesystem when they contain NFC and NFD
>>> Unicode characters.
>>
>> Prereqs look good and are well documented.
>>
>>> +if test $unicode_debug = 1
>>
>> Is this $unicode_debug something I should know from a previous
>> patch? or is it a leftover from local debugging?
> 
> I see that you set unicode_debug = 0 in a later patch, but I
> suppose that we might want this output no matter what. Or, do
> we think it will interrupt the output parsing of 'prove' and
> other tools?

I was afraid that it might interrupt tools like prove, but
I just tried it and it didn't.  But yeah it would be safer
to turn it off until someone actually wants to do some debugging
in this area.

Jeff


