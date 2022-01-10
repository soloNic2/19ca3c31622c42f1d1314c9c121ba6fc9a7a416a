Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF60C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 21:19:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343852AbiAJVTN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 16:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240793AbiAJVTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 16:19:09 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E9C06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 13:19:08 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id h23so19409080iol.11
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 13:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FTrKkNrsW7oFf2weWFjBUCeY4AzPYNFulnRyLyCVrk8=;
        b=z+XM3REbAP5x9W9gK6pBjzm9BHigJ0mkHwdcjCN9VQSWk7aIMxsxwVauiC4+Y15Py4
         e4kEWLSahtCS62N2410rXTW5F4IiCjrtU+iZztr+gz2IfLpV70e3CO2WaIRGNPRJm2g0
         Gl1+Y32Gk2jkmZ7w/ue8yng54F8FHEvg5joJFj19bMoWF0kd16ny2U+SjCfurbJu7Qpm
         7qMJtWStXIt8SBVaYdqvMjIylr3zDEvOolaSUBxXZYmD51XjQJXFL4DaYTvT6RIRsBZF
         gcdEfTKQ3MdH7Dr8AbiaERh3vNXQ9oKb1cHL7aodKSAS6/NpSSvKMxmW+7n4yICL7hsM
         b8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FTrKkNrsW7oFf2weWFjBUCeY4AzPYNFulnRyLyCVrk8=;
        b=YyvJy1w+MELo/HMukbimTZO7p+9odhEtnD9F2+GB68WqNtHOSqLj+FNJKrl2cWUWPM
         Oec5Mop17BPiDQ5du2gbK9mEJMae9wPoqUhJijzgbcfyH8nAHG8XgBD8PYhzcdaKiwZW
         1/rhWRpyqsAmRKRnXBk+qXOydG6sbeJqYIDiHxHV/MWXzXK8L1tw0TN6x+ovUHJ8tOuu
         ZStLc+f7IV9gr3soTs3R4sloQluxitDfe4RReEpc0HDcPxG0V91aiT4MxULStqcCqUbz
         I1S0PJMehkw5RIZvrW8GpPjBGFao6X30hvxBN1Skq/nq1rUbbIwat343WUGUC/LogIAV
         Wd5A==
X-Gm-Message-State: AOAM533g0jVnFyUCJsyN7y07jhNAhfATafqgniWHcVni8kH1UQ43T/Cd
        76bWXlo05ji/88mEupUArvoHr60/63d4qA==
X-Google-Smtp-Source: ABdhPJwh3a+flp+ajvTa6YBvQY7iqlxqOUdkFKcfZ3ahJTw9JXb3F4kXsRKSfwjHXJ9SQm7cyHyn1Q==
X-Received: by 2002:a05:6638:3009:: with SMTP id r9mr861119jak.262.1641849548063;
        Mon, 10 Jan 2022 13:19:08 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t6sm5035566iov.39.2022.01.10.13.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 13:19:07 -0800 (PST)
Date:   Mon, 10 Jan 2022 16:19:06 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Fabian Stelzer <fs@gigacodes.de>
Subject: [PATCH] fmt-merge-msg: prevent use-after-free with signed tags
Message-ID: <6e08b73d602853b3de71257117e85e32b96b5c19.1641849502.git.me@ttaylorr.com>
References: <YdxqshqXB/+ApOn2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YdxqshqXB/+ApOn2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When merging a signed tag, fmt_merge_msg_sigs() is responsible for
populating the body of the merge message with the names of the signed
tags, their signatures, and the validity of those signatures.

In 02769437e1 (ssh signing: use sigc struct to pass payload,
2021-12-09), check_signature() was taught to pass the object payload via
the sigc struct instead of passing the payload buffer separately.

In effect, 02769437e1 causes buf, and sigc.payload to point at the same
region in memory. This causes a problem for fmt_tag_signature(), which
wants to read from this location, since it is freed beforehand by
signature_check_clear() (which frees it via sigc's `payload` member).

That makes the subsequent use in fmt_tag_signature() a use-after-free.

As a result, merge messages did not contain the body of any signed tags.
Luckily, they tend not to contain garbage, either, since the result of
strstr()-ing the object buffer in fmt_tag_signature() is guarded:

    const char *tag_body = strstr(buf, "\n\n");
    if (tag_body) {
      tag_body += 2;
      strbuf_add(tagbuf, tag_body, buf + len - tag_body);
    }

Unfortunately, the tests in t6200 did not catch this at the time because
they do not search for the body of signed tags in fmt-merge-msg's
output.

Resolve this by waiting to call signature_check_clear() until after its
contents can be safely discarded. Harden ourselves against any future
regressions in this area by making sure we can find signed tag messages
in the output of fmt-merge-msg, too.

Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 fmt-merge-msg.c          | 2 +-
 t/t6200-fmt-merge-msg.sh | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index e5c0aff2bf..baca57d5b6 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -541,7 +541,6 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 			else
 				strbuf_addstr(&sig, sigc.output);
 		}
-		signature_check_clear(&sigc);

 		if (!tag_number++) {
 			fmt_tag_signature(&tagbuf, &sig, buf, len);
@@ -565,6 +564,7 @@ static void fmt_merge_msg_sigs(struct strbuf *out)
 		}
 		strbuf_release(&payload);
 		strbuf_release(&sig);
+		signature_check_clear(&sigc);
 	next:
 		free(origbuf);
 	}
diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 7544245f90..5a221f8ef1 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -126,6 +126,7 @@ test_expect_success GPG 'message for merging local tag signed by good key' '
 	git fetch . signed-good-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	grep "^signed-tag-msg" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep "^# gpg: Good signature from" actual
 '
@@ -135,6 +136,7 @@ test_expect_success GPG 'message for merging local tag signed by unknown key' '
 	git fetch . signed-good-tag &&
 	GNUPGHOME=. git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-tag${apos}" actual &&
+	grep "^signed-tag-msg" actual &&
 	grep "^# gpg: Signature made" actual &&
 	grep -E "^# gpg: Can${apos}t check signature: (public key not found|No public key)" actual
 '
@@ -145,6 +147,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by good ssh key
 	git fetch . signed-good-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-good-ssh-tag${apos}" actual &&
+	grep "^signed-ssh-tag-msg" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -155,6 +158,7 @@ test_expect_success GPGSSH 'message for merging local tag signed by unknown ssh
 	git fetch . signed-untrusted-ssh-tag &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}signed-untrusted-ssh-tag${apos}" actual &&
+	grep "^signed-ssh-tag-msg-untrusted" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_UNTRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual &&
 	grep "${GPGSSH_KEY_NOT_TRUSTED}" actual
@@ -166,6 +170,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git fetch . expired-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}expired-signed${apos}" actual &&
+	grep "^expired-signed" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '

@@ -175,6 +180,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git fetch . notyetvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}notyetvalid-signed${apos}" actual &&
+	grep "^notyetvalid-signed" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '

@@ -184,6 +190,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git fetch . timeboxedvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}timeboxedvalid-signed${apos}" actual &&
+	grep "^timeboxedvalid-signed" actual &&
 	grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual &&
 	! grep "${GPGSSH_BAD_SIGNATURE}" actual
 '
@@ -194,6 +201,7 @@ test_expect_success GPGSSH,GPGSSH_VERIFYTIME 'message for merging local tag sign
 	git fetch . timeboxedinvalid-signed &&
 	git fmt-merge-msg <.git/FETCH_HEAD >actual &&
 	grep "^Merge tag ${apos}timeboxedinvalid-signed${apos}" actual &&
+	grep "^timeboxedinvalid-signed" actual &&
 	! grep "${GPGSSH_GOOD_SIGNATURE_TRUSTED}" actual
 '

--
2.34.1.455.gd6eb6fd089
