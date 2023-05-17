Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AABBCC77B75
	for <git@archiver.kernel.org>; Wed, 17 May 2023 19:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjEQTWL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 15:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjEQTWK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 15:22:10 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FD72119
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:22:03 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ae4d1d35e6so10115815ad.0
        for <git@vger.kernel.org>; Wed, 17 May 2023 12:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684351322; x=1686943322;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=43lZo/Po0ytGBnVl84lz3Zxt7f9rDBsOfHyOfLJCA1A=;
        b=VquGsT075dpYDyyywIR6fIUhO+nknMghNUyydCynXVeNZkXfU8gcZbNtGruETeA+QM
         NgeiYTNis6pH9gce8UuQYjkNMRsxm5aJ7JXqzS6UuAk7zwUbSHyYsSNPBvZjBwQO/udW
         S1bEc0UNCIkG+Gjwibthw5zwtGAL4LCTJUcxbpVAQ0/g+SSQqwgdyTlGs7b1opVccxtv
         KvMvvKhNEuiQQzI7YFJNRE5AUXHEcKA+w+lKUJ0ospGOgJToX/hOXyyz5g0lAsBtY843
         BkqmiILfijI4o8uGEFTlyb/QWr9ycPmgyzFDDzNvj7Sv/VXFd1Mlioo2JywzdeXRYiSl
         oNcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684351322; x=1686943322;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=43lZo/Po0ytGBnVl84lz3Zxt7f9rDBsOfHyOfLJCA1A=;
        b=UPisJmsdHz0ZR8VIY/wsPa4pvWBmpW8JIKFaH/e6c4S88mFAWg66GEj+32X4DWzTSM
         C5vMCZ5Jgc4KgWHDtdolkG9cH3VxX3eirDALgTFmmaqOGqL6bXoFBUq1sG64syWn8SEx
         /fmAQ9XGpPcTyrF3cQl8VH/qwZ6A1yBL5S8niWbUccvC2bC3kwQGTqIKQinvP3KD7G7Z
         JG2qI9GJ8eay6zkIaeOss/nLamUoz/5Rncey1tkzpAJmvm+mFfrvfP9L7rCGPJCT5Z3Q
         zQbs8VCA08lbWb5mR42p6APGjKHYVaBdbuFi1DkRLvtb210WLIzn54bXah1Ffk7kInm6
         8mag==
X-Gm-Message-State: AC+VfDwO/9nsykmetCt7NRbNphNTpZ7AEDtY6wWvvYNMptvyOBlRb5Rz
        3Gc+aG85y1okzTi0ZsbA2GM=
X-Google-Smtp-Source: ACHHUZ4yk7tIdq/YGzQ0wW953Z65Uf/NzFym+yAorcgL2Op1GgQT/DmtHFRu3V6qnimHg2oFfetEKg==
X-Received: by 2002:a17:902:ecc5:b0:1ac:6882:1a6f with SMTP id a5-20020a170902ecc500b001ac68821a6fmr44439260plh.30.1684351322408;
        Wed, 17 May 2023 12:22:02 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id i8-20020a170902c94800b001a96562642dsm17826994pla.277.2023.05.17.12.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:22:01 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <nasamuffin@google.com>
Cc:     Git List <git@vger.kernel.org>, michael.strawbridge@amd.com,
        dianders@chromium.org
Subject: Re: bug report: cover letter is inheriting last patch's message ID
 with send-email
References: <CAJoAoZ=GGgjGOeaeo6RFBO7=6msdRf-Ze6XcnL04K5ugupLUJA@mail.gmail.com>
        <xmqqo7mipyt0.fsf@gitster.g>
Date:   Wed, 17 May 2023 12:22:01 -0700
In-Reply-To: <xmqqo7mipyt0.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        17 May 2023 12:01:31 -0700")
Message-ID: <xmqqjzx6pxuu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> # With the attached patches, where all of the patches have a
>> # Message-Id but the cover letter doesn't.
>> git send-email *.patch

I suspect this is a recent regression with the addition of the
pre_process_file step.  56adddaa (send-email: refactor header
generation functions, 2023-04-19) makes all messages parsed
before the first message is sent out, by calling a sub
"pre_process_file" before invoking the validate hook.  The same sub
is called again for each message when it is sent out, as the
processing in that step is shared between the time the message gets
vetted and the time the message gets sent.

Unfortunately, $message_id variable is assigned to in that sub.  So
it is very much understandable why this happens.

I wonder if it is just doing something silly like this?

--- >8 ---
Subject: [PATCH] send-email: clear the $message_id after validation

Recently git-send-email started parsing the same message twice, once
to validate _all_ the message before sending even the first one, and
then after the validation hook is happy and each message gets sent,
to read the contents to find out where to send to etc.

Unfortunately, the effect of reading the messages for validation
lingered even after the validation is done.  Namely $message_id gets
assigned if exists in the input files but the variable is global,
and it is not cleared before pre_process_file runs.  This causes
reading a message without a message-id followed by reading a message
with a message-id to misbehave---the sub reports as if the message
had the same id as the previously written one.

Clear the variable before starting to read the headers in
pre_process_file

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I am not surprised at all if there are similar problems in this
   function around variables other than $message_id; this patch is
   merely reacting to the bug report and not systematically hunting
   and fixing the bugs coming from the same root cause.  If the
   original author of the pre_process_file change is still around,
   the second sets of eyes from them is very much appreciated.

 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git c/git-send-email.perl w/git-send-email.perl
index 89d8237e89..889ef388c8 100755
--- c/git-send-email.perl
+++ w/git-send-email.perl
@@ -1771,6 +1771,7 @@ sub send_message {
 sub pre_process_file {
 	my ($t, $quiet) = @_;
 
+	undef $message_id;
 	open my $fh, "<", $t or die sprintf(__("can't open file %s"), $t);
 
 	my $author = undef;
