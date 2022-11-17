Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8B3C43217
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 08:09:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbiKQIJm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 03:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239432AbiKQIJi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 03:09:38 -0500
Received: from shell1.rawbw.com (shell1.rawbw.com [198.144.192.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B52863E5
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 00:09:36 -0800 (PST)
Received: from [192.168.5.3] (c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239])
        (authenticated bits=0)
        by shell1.rawbw.com (8.15.1/8.15.1) with ESMTPSA id 2AH89Zid046597
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 00:09:36 -0800 (PST)
        (envelope-from yuri@rawbw.com)
X-Authentication-Warning: shell1.rawbw.com: Host c-73-93-225-239.hsd1.ca.comcast.net [73.93.225.239] claimed to be [192.168.5.3]
Message-ID: <de2e1474-e044-72d2-1553-5943c7cdcbd4@tsoft.com>
Date:   Thu, 17 Nov 2022 00:09:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; FreeBSD amd64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Content-Language: en-US
To:     Git Mailing List <git@vger.kernel.org>
From:   Yuri <yuri@rawbw.com>
Subject: git-p4 should memorize the relevant P4* variables during 'git p4
 clone' instead of requiring them again for sync/sumbit operations
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently 'git p4 submit' requires the variable P4CLIENT to be exactly 
same as it was during 'git p4 clone'. When people have multiple 
repositiories it is easy to confuse P4CLIENT and this leads to strange 
cryptic errors and repository becoming unusable.


I suggest to improve git-p4: it should memorize the P4CLIENT value 
during 'git p4 clone' and use the same value when in calls the p4 
executable regardless of what P4CLIENT value is actually set.

'git p4 submit' and 'git p4 sync' should probably also require the 
repository to have the same path as it had during 'git p4 clone', 
because this is what the P4 client is tied to.

This would make git-p4 a lot less error prone due to mismatching 
P4CLIENT values.

It is easy for users to confuse P4CLIENT and run 'git p4 xx' from a 
wrong (mismatching) repository, causing errors difficult to recover from.


Thanks,

Yuri


