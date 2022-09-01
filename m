Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75760ECAAD8
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 15:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbiIAPm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 11:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiIAPmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 11:42:25 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8456E70E4B
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 08:42:23 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id m17-20020a7bce11000000b003a5bedec07bso1637037wmc.0
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 08:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=BGpkgY3i71LXAVEOMqmO9B9BhgoBeOdro9Ab5Z63/bA=;
        b=iGTZE7m06+6q5iKpTK+DNM4sIYluaS/dG2F9RfrXOBrEToso1c6bfudIYxETdFt74g
         JoY9w/IUrSMpEwPZuPOeAj3x0+JOZc3luMPVxSdVJgVuk0UHWW28oMBEfyR0EY6RTlDz
         44Zz7EsQEEzqqyhOQzLIzyv5+AyT2FCYK74blhRwaE5XvwuV9bHtsatDWB0q5tzoxhaP
         y/w2pk1DVHGdwBATWQ9pelV+4PaOWH52zZYefL2ilvH4ONWRHMczxNq5MGMcyc8kS5yY
         X3bSBzf/imSEjvsnYpdIpU2BydwAD8Gk27zt6dSblKOjKMP2iX4bU3f4HwFSg2Qvl4xM
         3VPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BGpkgY3i71LXAVEOMqmO9B9BhgoBeOdro9Ab5Z63/bA=;
        b=e3+XvlYhr+k+ocDc/UmmJoUgXIP//h7X/B3ppHxjL0AWPocs2CKIxPESmDCUYhgy7F
         QqNmn90Ki6Y8DV2GScuwrdBggDGKDoBZzElmhHp7QVKqhc+aQmrcQZeZlPG/GFb/1w0F
         P53BNZTPnWKGTFUUEncchHCvvB8eNXk/cSKQXvY360IMA689L1mgdxt03gbaA7qYLbt4
         rAZElg9U8mSTsnsTgpsGf34BUyb7/1bI5JBBjI/13pgokwqLScQ/l9KU72KFxbEBg0Ra
         0cwA5g+TOIKAWZlqEH07B5dMwuvg8F0P+cDWFI05PX9AJ+PQ2atX1suzNQjiXfGkCGiM
         s0qg==
X-Gm-Message-State: ACgBeo0U8HNgsyvTlsma9upxMqlIf7P6GQ2xTaMkt4D6Ot4JDhsR2Bzz
        3ECqkw/tRZF4d3G7Gl5lx2x+jjaHXSY=
X-Google-Smtp-Source: AA6agR4jdllDTm+8x+n/ssi++u0QqObPzFvlTUdlBvbOGVTUC6qEq844cjG/hrkBfKEqax6NR4rYPw==
X-Received: by 2002:a05:600c:1552:b0:3a8:4523:d16 with SMTP id f18-20020a05600c155200b003a845230d16mr5600487wmg.200.1662046941608;
        Thu, 01 Sep 2022 08:42:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k25-20020adfd239000000b0021e43b4edf0sm14507389wrh.20.2022.09.01.08.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 08:42:20 -0700 (PDT)
Message-Id: <pull.1336.v5.git.1662046939.gitgitgadget@gmail.com>
In-Reply-To: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
References: <pull.1336.v4.git.1661977877.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 15:42:16 +0000
Subject: [PATCH v5 0/3] built-in add -p: support diff-so-fancy better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain reported in
https://lore.kernel.org/git/ecf6f5be-22ca-299f-a8f1-bda38e5ca246@gmail.com
that there is a problem when running the built-in version of git add -p with
diff-so-fancy [https://github.com/so-fancy/diff-so-fancy] as diff colorizer.
The symptom is this:

    error: could not parse colored hunk header '?[36m?[1m?[38;5;13m@ file:1 @?[1m?[0m'


This patch series addresses that and should fix
https://github.com/so-fancy/diff-so-fancy/issues/437

Changes since v4:

 * The second patch was further simplified, avoiding to print extra ANSI
   sequences if the hunk header is shown verbatim.

Changes since v3:

 * Instead of deviating from how the Perl version of git add -p did things,
   we now teach the built-in version to display hunk headers verbatim when
   no line range could be parsed out (instead of showing the line range
   anyways). This was a very good idea of Phillip's, dramatically
   simplifying the patch series.
 * Also, this iteration drops the first patch that claims to redefine what
   we consider bogus, but only hides an off-by-one. In its stead, there is
   now a patch that fixes said off-by-one.

Changes since v2:

 * Added the appropriate "Reported-by" trailer to the commit message.
 * Split out the logic to insert a space between the colored line range and
   the extra information, if needed.
 * That logic was now corrected to see whether that space is really needed.
 * To verify that the logic does what we need it to do, the added regression
   test now specifically tests for that (single) extra space that we want to
   be inserted.
 * Reworded a stale comment that claimed that we might suppress the entire
   colored hunk header (which we no longer do).
 * Rebased to the current tip of the main branch to avoid a merge conflict
   with 716c1f649e3 (pipe_command(): mark stdin descriptor as non-blocking,
   2022-08-17).

Changes since v1:

 * Added a commit to ignore dirty submodules just like the Perl version
   does.

Johannes Schindelin (3):
  add -p: detect more mismatches between plain vs colored diffs
  add -p: gracefully handle unparseable hunk headers in colored diffs
  add -p: ignore dirty submodules

 add-patch.c                | 33 +++++++++++++++++++++++----------
 t/t3701-add-interactive.sh | 27 +++++++++++++++++++++++++--
 2 files changed, 48 insertions(+), 12 deletions(-)


base-commit: 07ee72db0e97b5c233f8ada0abb412248c2f1c6f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1336%2Fdscho%2Fdiff-so-fancy-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1336/dscho/diff-so-fancy-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1336

Range-diff vs v4:

 1:  25187c3a3c2 = 1:  25187c3a3c2 add -p: detect more mismatches between plain vs colored diffs
 2:  cd1c5100506 ! 2:  93d0e3b4d2a add -p: gracefully handle unparseable hunk headers in colored diffs
     @@ Commit message
          we should show the hunk headers verbatim. This is what the Perl version
          of the interactive `add` command did, too.
      
     -    This commit is best viewed with `--color-moved --ignore-space-change`.
     -
          [diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
      
          Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
     @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
      -	if (!p)
      -		return error(_("could not parse colored hunk header '%.*s'"),
      -			     (int)(eol - line), line);
     -+	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3)))
     ++	if (p && (p = memmem(p + 4, eol - p - 4, " @@", 3))) {
      +		header->colored_extra_start = p + 3 - s->colored.buf;
     -+	else {
     ++	} else {
      +		/* could not parse colored hunk header, leave as-is */
      +		header->colored_extra_start = hunk->colored_start;
      +		header->suppress_colored_line_range = 1;
     @@ add-patch.c: static int parse_hunk_header(struct add_p_state *s, struct hunk *hu
       
       	return 0;
      @@ add-patch.c: static void render_hunk(struct add_p_state *s, struct hunk *hunk,
     - 				- header->colored_extra_start;
     - 		}
     - 
     --		if (s->mode->is_reverse)
     --			old_offset -= delta;
     --		else
     --			new_offset += delta;
     --
     --		strbuf_addf(out, "@@ -%lu", old_offset);
     --		if (header->old_count != 1)
     --			strbuf_addf(out, ",%lu", header->old_count);
     --		strbuf_addf(out, " +%lu", new_offset);
     --		if (header->new_count != 1)
     --			strbuf_addf(out, ",%lu", header->new_count);
     --		strbuf_addstr(out, " @@");
     -+		if (!colored || !header->suppress_colored_line_range) {
     -+			if (s->mode->is_reverse)
     -+				old_offset -= delta;
     -+			else
     -+				new_offset += delta;
     + 		if (!colored) {
     + 			p = s->plain.buf + header->extra_start;
     + 			len = header->extra_end - header->extra_start;
     ++		} else if (header->suppress_colored_line_range) {
     ++			strbuf_add(out,
     ++				   s->colored.buf + header->colored_extra_start,
     ++				   header->colored_extra_end -
     ++				   header->colored_extra_start);
      +
     -+			strbuf_addf(out, "@@ -%lu", old_offset);
     -+			if (header->old_count != 1)
     -+				strbuf_addf(out, ",%lu", header->old_count);
     -+			strbuf_addf(out, " +%lu", new_offset);
     -+			if (header->new_count != 1)
     -+				strbuf_addf(out, ",%lu", header->new_count);
     -+			strbuf_addstr(out, " @@");
     -+		}
     - 
     - 		if (len)
     - 			strbuf_add(out, p, len);
     ++			strbuf_add(out, s->colored.buf + hunk->colored_start,
     ++				   hunk->colored_end - hunk->colored_start);
     ++			return;
     + 		} else {
     + 			strbuf_addstr(out, s->s.fraginfo_color);
     + 			p = s->colored.buf + header->colored_extra_start;
      
       ## t/t3701-add-interactive.sh ##
      @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output' '
     @@ t/t3701-add-interactive.sh: test_expect_success 'detect bogus diffFilter output'
      +	printf n >n &&
      +	force_color git -c interactive.diffFilter="sed s/.*@@.*/XX/" \
      +		add -p >output 2>&1 <n &&
     -+	grep "^[^@]*XX[^@]*$" output
     ++	grep "^XX$" output
      +'
      +
       test_expect_success 'handle very large filtered diff' '
 3:  116f0cf5cab = 3:  47943b603b1 add -p: ignore dirty submodules

-- 
gitgitgadget
