Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E45C433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 10:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348177AbiETKfT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 06:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345232AbiETKfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 06:35:11 -0400
Received: from hrbata.com (hrbata.com [109.123.216.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DA5F8FFB2
        for <git@vger.kernel.org>; Fri, 20 May 2022 03:35:08 -0700 (PDT)
Received: from fedora.redhat.com (ip-89-102-24-184.net.upcbroadband.cz [89.102.24.184])
        by hrbata.com (Postfix) with ESMTPSA id 4C8F544CD1;
        Fri, 20 May 2022 12:35:08 +0200 (CEST)
From:   Frantisek Hrbata <frantisek@hrbata.com>
To:     git@vger.kernel.org
Cc:     Frantisek Hrbata <frantisek@hrbata.com>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/2] transport: free local and remote refs in transport_push()
Date:   Fri, 20 May 2022 12:35:07 +0200
Message-Id: <20220520103507.1717236-3-frantisek@hrbata.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220520103507.1717236-1-frantisek@hrbata.com>
References: <20220520081723.1031830-1-frantisek@hrbata.com>
 <20220520103507.1717236-1-frantisek@hrbata.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix memory leaks in transport_push(), where remote_refs and local_refs
are never freed.

116 bytes in 1 blocks are definitely lost in loss record 56 of 103
   at 0x484486F: malloc (vg_replace_malloc.c:381)
   by 0x4938D7E: strdup (strdup.c:42)
   by 0x628418: xstrdup (wrapper.c:39)
   by 0x4FD454: process_capabilities (connect.c:232)
   by 0x4FD454: get_remote_heads (connect.c:354)
   by 0x610A38: handshake (transport.c:333)
   by 0x612B02: transport_push (transport.c:1302)
   by 0x4803D6: push_with_options (push.c:357)
   by 0x4811D6: do_push (push.c:414)
   by 0x4811D6: cmd_push (push.c:650)
   by 0x405210: run_builtin (git.c:465)
   by 0x405210: handle_builtin (git.c:719)
   by 0x406363: run_argv (git.c:786)
   by 0x406363: cmd_main (git.c:917)
   by 0x404F17: main (common-main.c:56)

5,912 (388 direct, 5,524 indirect) bytes in 2 blocks are definitely lost in loss record 98 of 103
   at 0x4849464: calloc (vg_replace_malloc.c:1328)
   by 0x628705: xcalloc (wrapper.c:150)
   by 0x5C216D: alloc_ref_with_prefix (remote.c:975)
   by 0x5C232A: alloc_ref (remote.c:983)
   by 0x5C232A: one_local_ref (remote.c:2299)
   by 0x5C232A: one_local_ref (remote.c:2289)
   by 0x5BDB03: do_for_each_repo_ref_iterator (iterator.c:418)
   by 0x5B4C4F: do_for_each_ref (refs.c:1486)
   by 0x5B4C4F: refs_for_each_ref (refs.c:1492)
   by 0x5B4C4F: for_each_ref (refs.c:1497)
   by 0x5C6ADF: get_local_heads (remote.c:2310)
   by 0x612A85: transport_push (transport.c:1286)
   by 0x4803D6: push_with_options (push.c:357)
   by 0x4811D6: do_push (push.c:414)
   by 0x4811D6: cmd_push (push.c:650)
   by 0x405210: run_builtin (git.c:465)
   by 0x405210: handle_builtin (git.c:719)
   by 0x406363: run_argv (git.c:786)
   by 0x406363: cmd_main (git.c:917)

Signed-off-by: Frantisek Hrbata <frantisek@hrbata.com>
---
For remote_refs it might be worth to leave the freeing to
transport_disconnect() and introduce helper similar to
transport_get_remote_refs().

 transport.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/transport.c b/transport.c
index 0b9c5a427d..4c5d9db7f2 100644
--- a/transport.c
+++ b/transport.c
@@ -1276,8 +1276,8 @@ int transport_push(struct repository *r,
 		   struct refspec *rs, int flags,
 		   unsigned int *reject_reasons)
 {
-	struct ref *remote_refs;
-	struct ref *local_refs;
+	struct ref *remote_refs = NULL;
+	struct ref *local_refs = NULL;
 	int match_flags = MATCH_REFS_NONE;
 	int verbose = (transport->verbose > 0);
 	int quiet = (transport->verbose < 0);
@@ -1295,10 +1295,11 @@ int transport_push(struct repository *r,
 	if (!transport->vtable->push_refs)
 		return 1;
 
+	ret = -1;
 	local_refs = get_local_heads();
 
 	if (check_push_refs(local_refs, rs) < 0)
-		return -1;
+		goto done;
 
 	refspec_ref_prefixes(rs, &transport_options.ref_prefixes);
 
@@ -1319,7 +1320,7 @@ int transport_push(struct repository *r,
 		match_flags |= MATCH_REFS_FOLLOW_TAGS;
 
 	if (match_push_refs(local_refs, &remote_refs, rs, match_flags))
-		return -1;
+		goto done;
 
 	if (transport->smart_options &&
 	    transport->smart_options->cas &&
@@ -1333,7 +1334,7 @@ int transport_push(struct repository *r,
 
 	if (!(flags & TRANSPORT_PUSH_NO_HOOK))
 		if (run_pre_push_hook(transport, remote_refs))
-			return -1;
+			goto done;
 
 	if ((flags & (TRANSPORT_RECURSE_SUBMODULES_ON_DEMAND |
 		      TRANSPORT_RECURSE_SUBMODULES_ONLY)) &&
@@ -1417,6 +1418,9 @@ int transport_push(struct repository *r,
 	else if (!quiet && !ret && !transport_refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
 
+done:
+	free_refs(local_refs);
+	free_refs(remote_refs);
 	return ret;
 }
 
-- 
2.35.1

