Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520FDC7618A
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 15:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjCQPg0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 11:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjCQPgJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 11:36:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5093303DB
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:35 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id o12so21920487edb.9
        for <git@vger.kernel.org>; Fri, 17 Mar 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679067332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA/7MwpnQ5LSiCCgg6tdl50ZZm6ALiCjuVeHtLNlodE=;
        b=ANBYlSPcLTL6qpQE89p+JcQ0tt2PjfvTdmDTB9x24Pmnj5zjVaueNTOunNeQjOjXnW
         VDkNKOnFLpAtx5lywD4xkGoB92Q/r224/Y+BYBXFBTLDCx7MarHiIxnCYA3pcWOrjije
         hnvVXVW6pZRd2ThuTKETa1hsR02DoUZiVCgoYn1fJ4VaCnmLg7nouZV63SlolT+nIGc8
         GBdUwnswGvqcJ0Ih5ypUqtwKMN1hdmuQDaxn8u8e6BndESlBSpw05NT0iPjFqPs2s2Hq
         6ocmrBDvMqfgFpMnV722w6pa08XHItNQ2FaUktnycP6CiC7bG/31yLyDoiFqiC0xt2Oe
         WPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679067332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA/7MwpnQ5LSiCCgg6tdl50ZZm6ALiCjuVeHtLNlodE=;
        b=y6Ww9bjq1qMyPsAz3gKyRBUjqHQt4BPtPAy+AX6ZQUkaEwRA+WBuwUY2qW2uQt0UC1
         TAou/RDHUzpoRHYPgAgmxLl02LD81ZHF9gywVGjvsRK4/aSiivVukYGm72dhFpEYM1TV
         kTknp+F5JbttGq530mxBUNNGBW1qKa/Or/f9/HJEZYJLSLkdWlVnmKYCqetr4tbIMFoJ
         wwwbiL4OeJeWduTAQsix6zvFunyF9rk5/Brc7bQky5lFppAQXYbrQlDVl/qkJV7REr0G
         /COe/tsk1mLDI3vP499t131A65O0NFU7rhndQstHF8qO6cAOBmo9/X1/bp8sZiMju/1k
         rJXw==
X-Gm-Message-State: AO0yUKVETwcVt2WIf/Vu/uoYoG7UkGFiCuyXPSKQGWvrUwt4D0wLjr8J
        FomGxiTNOP4YquBWfIjakDcg6UqPtFzv3g==
X-Google-Smtp-Source: AK7set9rTUvS0MQOV8P5IsXmK4jZFjhdSalnedmp1EvqZiDFN/l+ErOpnAsUkj4p4Muc01HzIvzETg==
X-Received: by 2002:a50:fe88:0:b0:4fd:1f7b:9fbd with SMTP id d8-20020a50fe88000000b004fd1f7b9fbdmr3446652edt.6.1679067331470;
        Fri, 17 Mar 2023 08:35:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a50d086000000b004fb00831851sm1199232edd.66.2023.03.17.08.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 08:35:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/17] cocci: apply the "commit.h" part of "the_repository.pending"
Date:   Fri, 17 Mar 2023 16:35:11 +0100
Message-Id: <patch-07.17-2e9cf3ca378-20230317T152724Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Apply the part of "the_repository.pending.cocci" pertaining to
"commit.h".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 blame.c                                       |  4 +-
 builtin/am.c                                  |  7 +-
 builtin/blame.c                               |  6 +-
 builtin/checkout.c                            | 13 +--
 builtin/commit.c                              |  8 +-
 builtin/describe.c                            |  4 +-
 builtin/diff.c                                |  3 +-
 builtin/fast-export.c                         |  4 +-
 builtin/gc.c                                  |  4 +-
 builtin/log.c                                 |  5 +-
 builtin/merge-tree.c                          |  6 +-
 builtin/merge.c                               |  3 +-
 builtin/name-rev.c                            |  4 +-
 builtin/notes.c                               |  2 +-
 builtin/rebase.c                              |  2 +-
 builtin/replace.c                             |  4 +-
 builtin/shortlog.c                            |  5 +-
 builtin/show-branch.c                         |  4 +-
 commit-graph.c                                |  2 +-
 commit-reach.c                                | 16 ++--
 commit.c                                      | 25 +++---
 commit.h                                      | 18 ----
 contrib/coccinelle/the_repository.cocci       | 19 +++++
 .../coccinelle/the_repository.pending.cocci   | 19 -----
 delta-islands.c                               |  5 +-
 fmt-merge-msg.c                               |  5 +-
 fsck.c                                        |  4 +-
 http-push.c                                   |  3 +-
 list-objects.c                                | 18 ++--
 merge-recursive.c                             |  2 +-
 negotiator/default.c                          |  6 +-
 negotiator/skipping.c                         |  2 +-
 notes-merge.c                                 |  5 +-
 notes-utils.c                                 |  2 +-
 object-name.c                                 |  8 +-
 pack-bitmap-write.c                           |  3 +-
 pretty.c                                      |  5 +-
 reflog.c                                      |  2 +-
 revision.c                                    | 12 +--
 sequencer.c                                   | 82 +++++++++++--------
 shallow.c                                     |  4 +-
 t/helper/test-fast-rebase.c                   |  9 +-
 tree.c                                        |  2 +-
 walker.c                                      |  4 +-
 44 files changed, 196 insertions(+), 174 deletions(-)

diff --git a/blame.c b/blame.c
index 8bfeaa1c63a..af2b67c0847 100644
--- a/blame.c
+++ b/blame.c
@@ -2429,7 +2429,7 @@ static void pass_blame(struct blame_scoreboard *sb, struct blame_origin *origin,
 
 			if (sg_origin[i])
 				continue;
-			if (parse_commit(p))
+			if (repo_parse_commit(the_repository, p))
 				continue;
 			porigin = find(sb->repo, p, origin, sb->bloom_data);
 			if (!porigin)
@@ -2592,7 +2592,7 @@ void assign_blame(struct blame_scoreboard *sb, int opt)
 		 * so hold onto it in the meantime.
 		 */
 		blame_origin_incref(suspect);
-		parse_commit(commit);
+		repo_parse_commit(the_repository, commit);
 		if (sb->reverse ||
 		    (!(commit->object.flags & UNINTERESTING) &&
 		     !(revs->max_age != -1 && commit->date < revs->max_age)))
diff --git a/builtin/am.c b/builtin/am.c
index c04038f1f3d..456884852e9 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1329,7 +1329,8 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 	size_t ident_len;
 	struct ident_split id;
 
-	buffer = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+	buffer = repo_logmsg_reencode(the_repository, commit, NULL,
+				      get_commit_output_encoding());
 
 	ident_line = find_commit_header(buffer, "author", &ident_len);
 	if (!ident_line)
@@ -1361,7 +1362,7 @@ static void get_commit_info(struct am_state *state, struct commit *commit)
 		die(_("unable to parse commit %s"), oid_to_hex(&commit->object.oid));
 	state->msg = xstrdup(msg + 2);
 	state->msg_len = strlen(state->msg);
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 /**
@@ -1404,7 +1405,7 @@ static void write_index_patch(const struct am_state *state)
 
 	if (!repo_get_oid(the_repository, "HEAD", &head)) {
 		struct commit *commit = lookup_commit_or_die(&head, "HEAD");
-		tree = get_commit_tree(commit);
+		tree = repo_get_commit_tree(the_repository, commit);
 	} else
 		tree = lookup_tree(the_repository,
 				   the_repository->hash_algo->empty_tree);
diff --git a/builtin/blame.c b/builtin/blame.c
index 0155062de11..91e04f57cc0 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -199,13 +199,13 @@ static void get_commit_info(struct commit *commit,
 	const char *message;
 
 	encoding = get_log_output_encoding();
-	message = logmsg_reencode(commit, NULL, encoding);
+	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 	get_ac_line(message, "\nauthor ",
 		    &ret->author, &ret->author_mail,
 		    &ret->author_time, &ret->author_tz);
 
 	if (!detailed) {
-		unuse_commit_buffer(commit, message);
+		repo_unuse_commit_buffer(the_repository, commit, message);
 		return;
 	}
 
@@ -219,7 +219,7 @@ static void get_commit_info(struct commit *commit,
 	else
 		strbuf_addf(&ret->summary, "(%s)", oid_to_hex(&commit->object.oid));
 
-	unuse_commit_buffer(commit, message);
+	repo_unuse_commit_buffer(the_repository, commit, message);
 }
 
 /*
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 6216bb6bba3..1d1f33e33e7 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -640,7 +640,7 @@ static void describe_detached_head(const char *msg, struct commit *commit)
 {
 	struct strbuf sb = STRBUF_INIT;
 
-	if (!parse_commit(commit))
+	if (!repo_parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, &sb);
 	if (print_sha1_ellipsis()) {
 		fprintf(stderr, "%s %s... %s\n", msg,
@@ -755,7 +755,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			BUG("'switch --orphan' should never accept a commit as starting point");
 		new_tree = parse_tree_indirect(the_hash_algo->empty_tree);
 	} else
-		new_tree = get_commit_tree(new_branch_info->commit);
+		new_tree = repo_get_commit_tree(the_repository,
+						new_branch_info->commit);
 	if (opts->discard_changes) {
 		ret = reset_tree(new_tree, opts, 1, writeout_error, new_branch_info);
 		if (ret)
@@ -817,7 +818,8 @@ static int merge_working_tree(const struct checkout_opts *opts,
 			 */
 			if (!old_branch_info->commit)
 				return 1;
-			old_tree = get_commit_tree(old_branch_info->commit);
+			old_tree = repo_get_commit_tree(the_repository,
+							old_branch_info->commit);
 
 			if (repo_index_has_changes(the_repository, old_tree, &sb))
 				die(_("cannot continue with staged changes in "
@@ -1006,7 +1008,7 @@ static void describe_one_orphan(struct strbuf *sb, struct commit *commit)
 	strbuf_addstr(sb, "  ");
 	strbuf_add_unique_abbrev(sb, &commit->object.oid, DEFAULT_ABBREV);
 	strbuf_addch(sb, ' ');
-	if (!parse_commit(commit))
+	if (!repo_parse_commit(the_repository, commit))
 		pp_commit_easy(CMIT_FMT_ONELINE, commit, sb);
 	strbuf_addch(sb, '\n');
 }
@@ -1206,7 +1208,8 @@ static void setup_new_branch_info_and_source_tree(
 		*source_tree = parse_tree_indirect(rev);
 	} else {
 		parse_commit_or_die(new_branch_info->commit);
-		*source_tree = get_commit_tree(new_branch_info->commit);
+		*source_tree = repo_get_commit_tree(the_repository,
+						    new_branch_info->commit);
 	}
 }
 
diff --git a/builtin/commit.c b/builtin/commit.c
index 80d1e31f25a..bda6afc4bd6 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -712,7 +712,7 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 {
 	const char *buffer, *subject, *fmt;
 
-	buffer = get_commit_buffer(commit, NULL);
+	buffer = repo_get_commit_buffer(the_repository, commit, NULL);
 	find_commit_subject(buffer, &subject);
 	/*
 	 * If we amend the 'amend!' commit then we don't want to
@@ -720,7 +720,7 @@ static void prepare_amend_commit(struct commit *commit, struct strbuf *sb,
 	 */
 	fmt = starts_with(subject, "amend!") ? "%b" : "%B";
 	format_commit_message(commit, fmt, sb, ctx);
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 static int prepare_to_commit(const char *index_file, const char *prefix,
@@ -1183,7 +1183,7 @@ static const char *read_commit_message(const char *name)
 	if (!commit)
 		die(_("could not lookup commit %s"), name);
 	out_enc = get_commit_output_encoding();
-	return logmsg_reencode(commit, NULL, out_enc);
+	return repo_logmsg_reencode(the_repository, commit, NULL, out_enc);
 }
 
 /*
@@ -1718,7 +1718,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		current_head = NULL;
 	else {
 		current_head = lookup_commit_or_die(&oid, "HEAD");
-		if (parse_commit(current_head))
+		if (repo_parse_commit(the_repository, current_head))
 			die(_("could not parse HEAD commit"));
 	}
 	verbose = -1; /* unspecified */
diff --git a/builtin/describe.c b/builtin/describe.c
index c85bf9c418b..e880a86f37b 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -261,7 +261,7 @@ static unsigned long finish_depth_computation(
 			best->depth++;
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, list);
 			p->object.flags |= c->object.flags;
@@ -404,7 +404,7 @@ static void describe_commit(struct object_id *oid, struct strbuf *dst)
 		}
 		while (parents) {
 			struct commit *p = parents->item;
-			parse_commit(p);
+			repo_parse_commit(the_repository, p);
 			if (!(p->object.flags & SEEN))
 				commit_list_insert_by_date(p, &list);
 			p->object.flags |= c->object.flags;
diff --git a/builtin/diff.c b/builtin/diff.c
index 26f1e532c66..1091c377af7 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -548,7 +548,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (!obj)
 			die(_("invalid object '%s' given."), name);
 		if (obj->type == OBJ_COMMIT)
-			obj = &get_commit_tree(((struct commit *)obj))->object;
+			obj = &repo_get_commit_tree(the_repository,
+						    ((struct commit *)obj))->object;
 
 		if (obj->type == OBJ_TREE) {
 			if (sdiff.skip && bitmap_get(sdiff.skip, i))
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 39a890fc005..5fe7c02970e 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -618,7 +618,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 	rev->diffopt.output_format = DIFF_FORMAT_CALLBACK;
 
 	parse_commit_or_die(commit);
-	commit_buffer = get_commit_buffer(commit, NULL);
+	commit_buffer = repo_get_commit_buffer(the_repository, commit, NULL);
 	author = strstr(commit_buffer, "\nauthor ");
 	if (!author)
 		die("could not find author in commit %s",
@@ -699,7 +699,7 @@ static void handle_commit(struct commit *commit, struct rev_info *rev,
 			  ? strlen(message) : 0),
 	       reencoded ? reencoded : message ? message : "");
 	free(reencoded);
-	unuse_commit_buffer(commit, commit_buffer);
+	repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
 
 	for (i = 0, p = commit->parents; p; p = p->next) {
 		struct object *obj = &p->item->object;
diff --git a/builtin/gc.c b/builtin/gc.c
index 02455fdcd73..e60decbc56c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -820,7 +820,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 	commit = lookup_commit(the_repository, oid);
 	if (!commit)
 		return 0;
-	if (parse_commit(commit) ||
+	if (repo_parse_commit(the_repository, commit) ||
 	    commit_graph_position(commit) != COMMIT_NOT_FROM_GRAPH)
 		return 0;
 
@@ -837,7 +837,7 @@ static int dfs_on_ref(const char *refname UNUSED,
 		commit = pop_commit(&stack);
 
 		for (parent = commit->parents; parent; parent = parent->next) {
-			if (parse_commit(parent->item) ||
+			if (repo_parse_commit(the_repository, parent->item) ||
 			    commit_graph_position(parent->item) != COMMIT_NOT_FROM_GRAPH ||
 			    parent->item->object.flags & SEEN)
 				continue;
diff --git a/builtin/log.c b/builtin/log.c
index 5604b4b5f05..f249aca049a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1314,10 +1314,11 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	log_write_email_headers(rev, head, &pp.after_subject, &need_8bit_cte, 0);
 
 	for (i = 0; !need_8bit_cte && i < nr; i++) {
-		const char *buf = get_commit_buffer(list[i], NULL);
+		const char *buf = repo_get_commit_buffer(the_repository,
+							 list[i], NULL);
 		if (has_non_ascii(buf))
 			need_8bit_cte = 1;
-		unuse_commit_buffer(list[i], buf);
+		repo_unuse_commit_buffer(the_repository, list[i], buf);
 	}
 
 	if (!branch_name)
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 4e4a9d6ba17..c0acbc6a546 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -443,9 +443,9 @@ static int real_merge(struct merge_tree_options *o,
 			die(_("could not lookup commit %s"), merge_base);
 
 		opt.ancestor = merge_base;
-		base_tree = get_commit_tree(base_commit);
-		parent1_tree = get_commit_tree(parent1);
-		parent2_tree = get_commit_tree(parent2);
+		base_tree = repo_get_commit_tree(the_repository, base_commit);
+		parent1_tree = repo_get_commit_tree(the_repository, parent1);
+		parent2_tree = repo_get_commit_tree(the_repository, parent2);
 		merge_incore_nonrecursive(&opt, base_tree, parent1_tree, parent2_tree, &result);
 	} else {
 		/*
diff --git a/builtin/merge.c b/builtin/merge.c
index c5a9321806d..197e152aba9 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1611,7 +1611,8 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			 * Must first ensure that index matches HEAD before
 			 * attempting a trivial merge.
 			 */
-			struct tree *head_tree = get_commit_tree(head_commit);
+			struct tree *head_tree = repo_get_commit_tree(the_repository,
+								      head_commit);
 			struct strbuf sb = STRBUF_INIT;
 
 			if (repo_index_has_changes(the_repository, head_tree,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index 35fd89f794d..ad1de023088 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -181,7 +181,7 @@ static void name_rev(struct commit *start_commit,
 	size_t parents_to_queue_nr, parents_to_queue_alloc = 0;
 	struct rev_name *start_name;
 
-	parse_commit(start_commit);
+	repo_parse_commit(the_repository, start_commit);
 	if (commit_is_before_cutoff(start_commit))
 		return;
 
@@ -211,7 +211,7 @@ static void name_rev(struct commit *start_commit,
 			struct rev_name *parent_name;
 			int generation, distance;
 
-			parse_commit(parent);
+			repo_parse_commit(the_repository, parent);
 			if (commit_is_before_cutoff(parent))
 				continue;
 
diff --git a/builtin/notes.c b/builtin/notes.c
index d98460e5d61..b497eae520e 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -720,7 +720,7 @@ static int merge_commit(struct notes_merge_options *o)
 		die(_("failed to read ref NOTES_MERGE_PARTIAL"));
 	else if (!(partial = lookup_commit_reference(the_repository, &oid)))
 		die(_("could not find commit from NOTES_MERGE_PARTIAL."));
-	else if (parse_commit(partial))
+	else if (repo_parse_commit(the_repository, partial))
 		die(_("could not parse commit from NOTES_MERGE_PARTIAL."));
 
 	if (partial->parents)
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 5fd7bfb4860..eba48bffaad 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -853,7 +853,7 @@ static int checkout_up_to_date(struct rebase_options *options)
 static int is_linear_history(struct commit *from, struct commit *to)
 {
 	while (to && to != from) {
-		parse_commit(to);
+		repo_parse_commit(the_repository, to);
 		if (!to->parents)
 			return 1;
 		if (to->parents->next)
diff --git a/builtin/replace.c b/builtin/replace.c
index 33c6cdb79c8..85f0b79c924 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -458,9 +458,9 @@ static int create_graft(int argc, const char **argv, int force, int gentle)
 	if (!commit)
 		return error(_("could not parse %s"), old_ref);
 
-	buffer = get_commit_buffer(commit, &size);
+	buffer = repo_get_commit_buffer(the_repository, commit, &size);
 	strbuf_add(&buf, buffer, size);
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 
 	if (replace_parents(&buf, argc - 1, &argv[1]) < 0) {
 		strbuf_release(&buf);
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 27a87167e19..8afd1ad865e 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -179,7 +179,8 @@ static void insert_records_from_trailers(struct shortlog *log,
 	 * Using format_commit_message("%B") would be simpler here, but
 	 * this saves us copying the message.
 	 */
-	commit_buffer = logmsg_reencode(commit, NULL, ctx->output_encoding);
+	commit_buffer = repo_logmsg_reencode(the_repository, commit, NULL,
+					     ctx->output_encoding);
 	body = strstr(commit_buffer, "\n\n");
 	if (!body)
 		return;
@@ -202,7 +203,7 @@ static void insert_records_from_trailers(struct shortlog *log,
 	trailer_iterator_release(&iter);
 
 	strbuf_release(&ident);
-	unuse_commit_buffer(commit, commit_buffer);
+	repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
 }
 
 static int shortlog_needs_dedup(const struct shortlog *log)
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 9e3b8ed27e1..d60e536a53b 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -240,7 +240,7 @@ static void join_revs(struct commit_list **list_p,
 			parents = parents->next;
 			if ((this_flag & flags) == flags)
 				continue;
-			parse_commit(p);
+			repo_parse_commit(the_repository, p);
 			if (mark_seen(p, seen_p) && !still_interesting)
 				extra--;
 			p->object.flags |= flags;
@@ -842,7 +842,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		if (!commit)
 			die(_("cannot find commit %s (%s)"),
 			    ref_name[num_rev], oid_to_hex(&revkey));
-		parse_commit(commit);
+		repo_parse_commit(the_repository, commit);
 		mark_seen(commit, &seen);
 
 		/* rev#0 uses bit REV_SHIFT, rev#1 uses bit REV_SHIFT+1,
diff --git a/commit-graph.c b/commit-graph.c
index c11b59f28b3..8273085aa60 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2549,7 +2549,7 @@ int verify_commit_graph(struct repository *r, struct commit_graph *g, int flags)
 
 		graph_commit = lookup_commit(r, &cur_oid);
 		odb_commit = (struct commit *)create_object(r, &cur_oid, alloc_commit_node(r));
-		if (parse_commit_internal(odb_commit, 0, 0)) {
+		if (repo_parse_commit_internal(the_repository, odb_commit, 0, 0)) {
 			graph_report(_("failed to parse commit %s from object database for commit-graph"),
 				     oid_to_hex(&cur_oid));
 			continue;
diff --git a/commit-reach.c b/commit-reach.c
index a4b9eda723f..c88faf7e7b2 100644
--- a/commit-reach.c
+++ b/commit-reach.c
@@ -585,7 +585,7 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid)
 		return 0;
 	new_commit = (struct commit *) o;
 
-	if (parse_commit(new_commit) < 0)
+	if (repo_parse_commit(the_repository, new_commit) < 0)
 		return 0;
 
 	commit_list_insert(old_commit, &old_commit_list);
@@ -749,7 +749,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 		}
 
 		list[nr_commits] = (struct commit *)from_one;
-		if (parse_commit(list[nr_commits]) ||
+		if (repo_parse_commit(the_repository, list[nr_commits]) ||
 		    commit_graph_generation(list[nr_commits]) < min_generation) {
 			result = 0;
 			goto cleanup;
@@ -784,7 +784,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
 				if (!(parent->item->object.flags & assign_flag)) {
 					parent->item->object.flags |= assign_flag;
 
-					if (parse_commit(parent->item) ||
+					if (repo_parse_commit(the_repository, parent->item) ||
 					    parent->item->date < min_commit_date ||
 					    commit_graph_generation(parent->item) < min_generation)
 						continue;
@@ -826,7 +826,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	while (from_iter) {
 		add_object_array(&from_iter->item->object, NULL, &from_objs);
 
-		if (!parse_commit(from_iter->item)) {
+		if (!repo_parse_commit(the_repository, from_iter->item)) {
 			timestamp_t generation;
 			if (from_iter->item->date < min_commit_date)
 				min_commit_date = from_iter->item->date;
@@ -840,7 +840,7 @@ int can_all_from_reach(struct commit_list *from, struct commit_list *to,
 	}
 
 	while (to_iter) {
-		if (!parse_commit(to_iter->item)) {
+		if (!repo_parse_commit(the_repository, to_iter->item)) {
 			timestamp_t generation;
 			if (to_iter->item->date < min_commit_date)
 				min_commit_date = to_iter->item->date;
@@ -890,7 +890,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		timestamp_t generation;
 		struct commit *c = *item;
 
-		parse_commit(c);
+		repo_parse_commit(the_repository, c);
 		generation = commit_graph_generation(c);
 		if (generation < min_generation)
 			min_generation = generation;
@@ -905,7 +905,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		struct commit *c = *item;
 		if (!(c->object.flags & PARENT2)) {
 			c->object.flags |= PARENT2;
-			parse_commit(c);
+			repo_parse_commit(the_repository, c);
 
 			prio_queue_put(&queue, *item);
 		}
@@ -924,7 +924,7 @@ struct commit_list *get_reachable_subset(struct commit **from, int nr_from,
 		for (parents = current->parents; parents; parents = parents->next) {
 			struct commit *p = parents->item;
 
-			parse_commit(p);
+			repo_parse_commit(the_repository, p);
 
 			if (commit_graph_generation(p) < min_generation)
 				continue;
diff --git a/commit.c b/commit.c
index 62682f55643..6036376d05a 100644
--- a/commit.c
+++ b/commit.c
@@ -83,7 +83,7 @@ struct commit *lookup_commit_reference_by_name(const char *name)
 	if (repo_get_oid_committish(the_repository, name, &oid))
 		return NULL;
 	commit = lookup_commit_reference(the_repository, &oid);
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		return NULL;
 	return commit;
 }
@@ -382,7 +382,7 @@ struct tree *repo_get_commit_tree(struct repository *r,
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
 {
-	struct tree *tree = get_commit_tree(commit);
+	struct tree *tree = repo_get_commit_tree(the_repository, commit);
 	return tree ? &tree->object.oid : NULL;
 }
 
@@ -555,7 +555,7 @@ int repo_parse_commit_gently(struct repository *r,
 
 void parse_commit_or_die(struct commit *item)
 {
-	if (parse_commit(item))
+	if (repo_parse_commit(the_repository, item))
 		die("unable to parse commit %s",
 		    item ? oid_to_hex(&item->object.oid) : "(null)");
 }
@@ -688,7 +688,7 @@ struct commit *pop_most_recent_commit(struct commit_list **list,
 
 	while (parents) {
 		struct commit *commit = parents->item;
-		if (!parse_commit(commit) && !(commit->object.flags & mark)) {
+		if (!repo_parse_commit(the_repository, commit) && !(commit->object.flags & mark)) {
 			commit->object.flags |= mark;
 			commit_list_insert_by_date(commit, list);
 		}
@@ -762,7 +762,8 @@ define_commit_slab(author_date_slab, timestamp_t);
 void record_author_date(struct author_date_slab *author_date,
 			struct commit *commit)
 {
-	const char *buffer = get_commit_buffer(commit, NULL);
+	const char *buffer = repo_get_commit_buffer(the_repository, commit,
+						    NULL);
 	struct ident_split ident;
 	const char *ident_line;
 	size_t ident_len;
@@ -782,7 +783,7 @@ void record_author_date(struct author_date_slab *author_date,
 	*(author_date_slab_at(author_date, commit)) = date;
 
 fail_exit:
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 int compare_commits_by_author_date(const void *a_, const void *b_,
@@ -963,7 +964,7 @@ static void add_one_commit(struct object_id *oid, struct rev_collect *revs)
 	commit = lookup_commit(the_repository, oid);
 	if (!commit ||
 	    (commit->object.flags & TMP_MARK) ||
-	    parse_commit(commit))
+	    repo_parse_commit(the_repository, commit))
 		return;
 
 	ALLOC_GROW(revs->commit, revs->nr + 1, revs->alloc);
@@ -1096,10 +1097,11 @@ int parse_signed_commit(const struct commit *commit,
 			const struct git_hash_algo *algop)
 {
 	unsigned long size;
-	const char *buffer = get_commit_buffer(commit, &size);
+	const char *buffer = repo_get_commit_buffer(the_repository, commit,
+						    &size);
 	int ret = parse_buffer_signed_by_header(buffer, size, payload, signature, algop);
 
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 	return ret;
 }
 
@@ -1318,9 +1320,10 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
 {
 	struct commit_extra_header *extra = NULL;
 	unsigned long size;
-	const char *buffer = get_commit_buffer(commit, &size);
+	const char *buffer = repo_get_commit_buffer(the_repository, commit,
+						    &size);
 	extra = read_commit_extra_header_lines(buffer, size, exclude);
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 	return extra;
 }
 
diff --git a/commit.h b/commit.h
index cc2c5da7bdb..e98ee6e698e 100644
--- a/commit.h
+++ b/commit.h
@@ -109,11 +109,6 @@ static inline int repo_parse_commit_no_graph(struct repository *r,
 	return repo_parse_commit_internal(r, commit, 0, 0);
 }
 
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define parse_commit_internal(item, quiet, use) repo_parse_commit_internal(the_repository, item, quiet, use)
-#define parse_commit(item) repo_parse_commit(the_repository, item)
-#endif
-
 void parse_commit_or_die(struct commit *item);
 
 struct buffer_slab;
@@ -140,9 +135,6 @@ const void *get_cached_commit_buffer(struct repository *, const struct commit *,
 const void *repo_get_commit_buffer(struct repository *r,
 				   const struct commit *,
 				   unsigned long *size);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define get_commit_buffer(c, s) repo_get_commit_buffer(the_repository, c, s)
-#endif
 
 /*
  * Tell the commit subsystem that we are done with a particular commit buffer.
@@ -153,9 +145,6 @@ const void *repo_get_commit_buffer(struct repository *r,
 void repo_unuse_commit_buffer(struct repository *r,
 			      const struct commit *,
 			      const void *buffer);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define unuse_commit_buffer(c, b) repo_unuse_commit_buffer(the_repository, c, b)
-#endif
 
 /*
  * Free any cached object buffer associated with the commit.
@@ -163,7 +152,6 @@ void repo_unuse_commit_buffer(struct repository *r,
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
 struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
-#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
@@ -206,16 +194,10 @@ void free_commit_list(struct commit_list *list);
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
 
 int has_non_ascii(const char *text);
-const char *logmsg_reencode(const struct commit *commit,
-			    char **commit_encoding,
-			    const char *output_encoding);
 const char *repo_logmsg_reencode(struct repository *r,
 				 const struct commit *commit,
 				 char **commit_encoding,
 				 const char *output_encoding);
-#ifndef NO_THE_REPOSITORY_COMPATIBILITY_MACROS
-#define logmsg_reencode(c, enc, out) repo_logmsg_reencode(the_repository, c, enc, out)
-#endif
 
 const char *skip_blank_lines(const char *msg);
 
diff --git a/contrib/coccinelle/the_repository.cocci b/contrib/coccinelle/the_repository.cocci
index 1ab63f0196b..0cdf3f46304 100644
--- a/contrib/coccinelle/the_repository.cocci
+++ b/contrib/coccinelle/the_repository.cocci
@@ -54,6 +54,25 @@
 |
 - in_merge_bases_many
 + repo_in_merge_bases_many
+// commit.h
+|
+- parse_commit_internal
++ repo_parse_commit_internal
+|
+- parse_commit
++ repo_parse_commit
+|
+- get_commit_buffer
++ repo_get_commit_buffer
+|
+- unuse_commit_buffer
++ repo_unuse_commit_buffer
+|
+- logmsg_reencode
++ repo_logmsg_reencode
+|
+- get_commit_tree
++ repo_get_commit_tree
 )
   (
 + the_repository,
diff --git a/contrib/coccinelle/the_repository.pending.cocci b/contrib/coccinelle/the_repository.pending.cocci
index e9209fc0cc4..bf19e6a2487 100644
--- a/contrib/coccinelle/the_repository.pending.cocci
+++ b/contrib/coccinelle/the_repository.pending.cocci
@@ -5,26 +5,7 @@
 @@
 @@
 (
-// commit.h
-- parse_commit_internal
-+ repo_parse_commit_internal
-|
-- parse_commit
-+ repo_parse_commit
-|
-- get_commit_buffer
-+ repo_get_commit_buffer
-|
-- unuse_commit_buffer
-+ repo_unuse_commit_buffer
-|
-- logmsg_reencode
-+ repo_logmsg_reencode
-|
-- get_commit_tree
-+ repo_get_commit_tree
 // diff.h
-|
 - diff_setup
 + repo_diff_setup
 // object-store.h
diff --git a/delta-islands.c b/delta-islands.c
index afdec0a878d..05448851ad3 100644
--- a/delta-islands.c
+++ b/delta-islands.c
@@ -506,8 +506,9 @@ void propagate_island_marks(struct commit *commit)
 		struct commit_list *p;
 		struct island_bitmap *root_marks = kh_value(island_marks, pos);
 
-		parse_commit(commit);
-		set_island_marks(&get_commit_tree(commit)->object, root_marks);
+		repo_parse_commit(the_repository, commit);
+		set_island_marks(&repo_get_commit_tree(the_repository, commit)->object,
+				 root_marks);
 		for (p = commit->parents; p; p = p->next)
 			set_island_marks(&p->item->object, root_marks);
 	}
diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
index e8e2d4ea0d0..a5de91ba22c 100644
--- a/fmt-merge-msg.c
+++ b/fmt-merge-msg.c
@@ -271,9 +271,10 @@ static void record_person_from_buf(int which, struct string_list *people,
 static void record_person(int which, struct string_list *people,
 			  struct commit *commit)
 {
-	const char *buffer = get_commit_buffer(commit, NULL);
+	const char *buffer = repo_get_commit_buffer(the_repository, commit,
+						    NULL);
 	record_person_from_buf(which, people, buffer);
-	unuse_commit_buffer(commit, buffer);
+	repo_unuse_commit_buffer(the_repository, commit, buffer);
 }
 
 static int cmp_string_list_util_as_integral(const void *a_, const void *b_)
diff --git a/fsck.c b/fsck.c
index 2b18717ee80..807a84971a2 100644
--- a/fsck.c
+++ b/fsck.c
@@ -353,7 +353,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 	int result;
 	const char *name;
 
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		return -1;
 
 	name = fsck_get_object_name(options, &commit->object.oid);
@@ -361,7 +361,7 @@ static int fsck_walk_commit(struct commit *commit, void *data, struct fsck_optio
 		fsck_put_object_name(options, get_commit_tree_oid(commit),
 				     "%s:", name);
 
-	result = options->walk((struct object *)get_commit_tree(commit),
+	result = options->walk((struct object *) repo_get_commit_tree(the_repository, commit),
 			       OBJ_TREE, data, options);
 	if (result < 0)
 		return result;
diff --git a/http-push.c b/http-push.c
index ceab00bd901..45d5cc0972f 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1331,7 +1331,8 @@ static int get_delta(struct rev_info *revs, struct remote_lock *lock)
 	int count = 0;
 
 	while ((commit = get_revision(revs)) != NULL) {
-		p = process_tree(get_commit_tree(commit), p);
+		p = process_tree(repo_get_commit_tree(the_repository, commit),
+				 p);
 		commit->object.flags |= LOCAL;
 		if (!(commit->object.flags & UNINTERESTING))
 			count += add_send_request(&commit->object, lock);
diff --git a/list-objects.c b/list-objects.c
index 7528fe1db2c..5550b3aafeb 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -227,7 +227,8 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		struct commit *parent = parents->item;
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
-		mark_tree_uninteresting(revs->repo, get_commit_tree(parent));
+		mark_tree_uninteresting(revs->repo,
+					repo_get_commit_tree(the_repository, parent));
 		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			show_edge(parent);
@@ -244,7 +245,8 @@ static void add_edge_parents(struct commit *commit,
 
 	for (parents = commit->parents; parents; parents = parents->next) {
 		struct commit *parent = parents->item;
-		struct tree *tree = get_commit_tree(parent);
+		struct tree *tree = repo_get_commit_tree(the_repository,
+							 parent);
 
 		if (!tree)
 			continue;
@@ -275,7 +277,8 @@ void mark_edges_uninteresting(struct rev_info *revs,
 
 		for (list = revs->commits; list; list = list->next) {
 			struct commit *commit = list->item;
-			struct tree *tree = get_commit_tree(commit);
+			struct tree *tree = repo_get_commit_tree(the_repository,
+								 commit);
 
 			if (commit->object.flags & UNINTERESTING)
 				tree->object.flags |= UNINTERESTING;
@@ -291,7 +294,7 @@ void mark_edges_uninteresting(struct rev_info *revs,
 			struct commit *commit = list->item;
 			if (commit->object.flags & UNINTERESTING) {
 				mark_tree_uninteresting(revs->repo,
-							get_commit_tree(commit));
+							repo_get_commit_tree(the_repository, commit));
 				if (revs->edge_hint_aggressive && !(commit->object.flags & SHOWN)) {
 					commit->object.flags |= SHOWN;
 					show_edge(commit);
@@ -309,7 +312,7 @@ void mark_edges_uninteresting(struct rev_info *revs,
 			if (obj->type != OBJ_COMMIT || !(obj->flags & UNINTERESTING))
 				continue;
 			mark_tree_uninteresting(revs->repo,
-						get_commit_tree(commit));
+						repo_get_commit_tree(the_repository, commit));
 			if (!(obj->flags & SHOWN)) {
 				obj->flags |= SHOWN;
 				show_edge(commit);
@@ -376,8 +379,9 @@ static void do_traverse(struct traversal_context *ctx)
 		 */
 		if (!ctx->revs->tree_objects)
 			; /* do not bother loading tree */
-		else if (get_commit_tree(commit)) {
-			struct tree *tree = get_commit_tree(commit);
+		else if (repo_get_commit_tree(the_repository, commit)) {
+			struct tree *tree = repo_get_commit_tree(the_repository,
+								 commit);
 			tree->object.flags |= NOT_USER_GIVEN;
 			add_pending_tree(ctx->revs, tree);
 		} else if (commit->object.parsed) {
diff --git a/merge-recursive.c b/merge-recursive.c
index 9771ef540c4..75fa0ef3183 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3797,7 +3797,7 @@ static struct commit *get_ref(struct repository *repo,
 		return make_virtual_commit(repo, (struct tree*)object, name);
 	if (object->type != OBJ_COMMIT)
 		return NULL;
-	if (parse_commit((struct commit *)object))
+	if (repo_parse_commit(the_repository, (struct commit *)object))
 		return NULL;
 	return (struct commit *)object;
 }
diff --git a/negotiator/default.c b/negotiator/default.c
index b7e79feaf04..658d9dd6b95 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -25,7 +25,7 @@ static void rev_list_push(struct negotiation_state *ns,
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (parse_commit(commit))
+		if (repo_parse_commit(the_repository, commit))
 			return;
 
 		prio_queue_put(&ns->rev_list, commit);
@@ -69,7 +69,7 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
 			if (!ancestors_only && !(o->flags & POPPED))
 				ns->non_common_revs--;
 			if (!o->parsed && !dont_parse)
-				if (parse_commit(commit))
+				if (repo_parse_commit(the_repository, commit))
 					return;
 
 			for (parents = commit->parents;
@@ -96,7 +96,7 @@ static const struct object_id *get_rev(struct negotiation_state *ns)
 			return NULL;
 
 		commit = prio_queue_get(&ns->rev_list);
-		parse_commit(commit);
+		repo_parse_commit(the_repository, commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
diff --git a/negotiator/skipping.c b/negotiator/skipping.c
index 0f5ac48e876..594639b25a0 100644
--- a/negotiator/skipping.c
+++ b/negotiator/skipping.c
@@ -183,7 +183,7 @@ static const struct object_id *get_rev(struct data *data)
 		if (!(commit->object.flags & COMMON) && !entry->ttl)
 			to_send = commit;
 
-		parse_commit(commit);
+		repo_parse_commit(the_repository, commit);
 		for (p = commit->parents; p; p = p->next)
 			parent_pushed |= push_parent(data, entry, p->item);
 
diff --git a/notes-merge.c b/notes-merge.c
index fca9422a294..df1a16ac66c 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -678,7 +678,8 @@ int notes_merge_commit(struct notes_merge_options *o,
 	DIR *dir;
 	struct dirent *e;
 	struct strbuf path = STRBUF_INIT;
-	const char *buffer = get_commit_buffer(partial_commit, NULL);
+	const char *buffer = repo_get_commit_buffer(the_repository,
+						    partial_commit, NULL);
 	const char *msg = strstr(buffer, "\n\n");
 	int baselen;
 
@@ -725,7 +726,7 @@ int notes_merge_commit(struct notes_merge_options *o,
 
 	create_notes_commit(o->repo, partial_tree, partial_commit->parents, msg,
 			    strlen(msg), result_oid);
-	unuse_commit_buffer(partial_commit, buffer);
+	repo_unuse_commit_buffer(the_repository, partial_commit, buffer);
 	if (o->verbosity >= 4)
 		printf("Finalized notes merge commit: %s\n",
 			oid_to_hex(result_oid));
diff --git a/notes-utils.c b/notes-utils.c
index d7d18e30f5a..0550cfded86 100644
--- a/notes-utils.c
+++ b/notes-utils.c
@@ -23,7 +23,7 @@ void create_notes_commit(struct repository *r,
 		struct object_id parent_oid;
 		if (!read_ref(t->ref, &parent_oid)) {
 			struct commit *parent = lookup_commit(r, &parent_oid);
-			if (parse_commit(parent))
+			if (repo_parse_commit(the_repository, parent))
 				die("Failed to find/parse commit %s", t->ref);
 			commit_list_insert(parent, &parents);
 		}
diff --git a/object-name.c b/object-name.c
index 21e8f67489e..2926f26251f 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1036,7 +1036,7 @@ static enum get_oid_result get_parent(struct repository *r,
 	if (ret)
 		return ret;
 	commit = lookup_commit_reference(r, &oid);
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		return MISSING_OBJECT;
 	if (!idx) {
 		oidcpy(result, &commit->object.oid);
@@ -1070,7 +1070,7 @@ static enum get_oid_result get_nth_ancestor(struct repository *r,
 		return MISSING_OBJECT;
 
 	while (generation--) {
-		if (parse_commit(commit) || !commit->parents)
+		if (repo_parse_commit(the_repository, commit) || !commit->parents)
 			return MISSING_OBJECT;
 		commit = commit->parents->item;
 	}
@@ -1361,10 +1361,10 @@ static int get_oid_oneline(struct repository *r,
 		commit = pop_most_recent_commit(&list, ONELINE_SEEN);
 		if (!parse_object(r, &commit->object.oid))
 			continue;
-		buf = get_commit_buffer(commit, NULL);
+		buf = repo_get_commit_buffer(the_repository, commit, NULL);
 		p = strstr(buf, "\n\n");
 		matches = negative ^ (p && !regexec(&regex, p + 2, 0, NULL, 0));
-		unuse_commit_buffer(commit, buf);
+		repo_unuse_commit_buffer(the_repository, commit, buf);
 
 		if (matches) {
 			oidcpy(oid, &commit->object.oid);
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index cfa67a510fd..84b61328931 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -425,7 +425,8 @@ static int fill_bitmap_commit(struct bb_commit *ent,
 		if (!found)
 			return -1;
 		bitmap_set(ent->bitmap, pos);
-		prio_queue_put(tree_queue, get_commit_tree(c));
+		prio_queue_put(tree_queue,
+			       repo_get_commit_tree(the_repository, c));
 
 		for (p = c->parents; p; p = p->next) {
 			pos = find_object_pos(&p->item->object.oid, &found);
diff --git a/pretty.c b/pretty.c
index 1e1e21878c8..7e1614f67fe 100644
--- a/pretty.c
+++ b/pretty.c
@@ -2204,7 +2204,8 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	}
 
 	encoding = get_log_output_encoding();
-	msg = reencoded = logmsg_reencode(commit, NULL, encoding);
+	msg = reencoded = repo_logmsg_reencode(the_repository, commit, NULL,
+					       encoding);
 
 	if (pp->fmt == CMIT_FMT_ONELINE || cmit_fmt_is_mail(pp->fmt))
 		indent = 0;
@@ -2261,7 +2262,7 @@ void pretty_print_commit(struct pretty_print_context *pp,
 	if (cmit_fmt_is_mail(pp->fmt) && sb->len <= beginning_of_body)
 		strbuf_addch(sb, '\n');
 
-	unuse_commit_buffer(commit, reencoded);
+	repo_unuse_commit_buffer(the_repository, commit, reencoded);
 }
 
 void pp_commit_easy(enum cmit_fmt fmt, const struct commit *commit,
diff --git a/reflog.c b/reflog.c
index 04630f56ec6..6e8362e7a2f 100644
--- a/reflog.c
+++ b/reflog.c
@@ -186,7 +186,7 @@ static void mark_reachable(struct expire_reflog_policy_cb *cb)
 		struct commit *commit = pop_commit(&pending);
 		if (commit->object.flags & REACHABLE)
 			continue;
-		if (parse_commit(commit))
+		if (repo_parse_commit(the_repository, commit))
 			continue;
 		commit->object.flags |= REACHABLE;
 		if (commit->date < expire_limit) {
diff --git a/revision.c b/revision.c
index c2b7b2f1073..79e78b6f7e9 100644
--- a/revision.c
+++ b/revision.c
@@ -778,8 +778,8 @@ static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
 static int rev_compare_tree(struct rev_info *revs,
 			    struct commit *parent, struct commit *commit, int nth_parent)
 {
-	struct tree *t1 = get_commit_tree(parent);
-	struct tree *t2 = get_commit_tree(commit);
+	struct tree *t1 = repo_get_commit_tree(the_repository, parent);
+	struct tree *t2 = repo_get_commit_tree(the_repository, commit);
 	int bloom_ret = 1;
 
 	if (!t1)
@@ -825,7 +825,7 @@ static int rev_compare_tree(struct rev_info *revs,
 
 static int rev_same_tree_as_empty(struct rev_info *revs, struct commit *commit)
 {
-	struct tree *t1 = get_commit_tree(commit);
+	struct tree *t1 = repo_get_commit_tree(the_repository, commit);
 
 	if (!t1)
 		return 0;
@@ -963,7 +963,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	if (!revs->prune)
 		return;
 
-	if (!get_commit_tree(commit))
+	if (!repo_get_commit_tree(the_repository, commit))
 		return;
 
 	if (!commit->parents) {
@@ -3878,7 +3878,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 	 * in it.
 	 */
 	encoding = get_log_output_encoding();
-	message = logmsg_reencode(commit, NULL, encoding);
+	message = repo_logmsg_reencode(the_repository, commit, NULL, encoding);
 
 	/* Copy the commit to temporary if we are using "fake" headers */
 	if (buf.len)
@@ -3914,7 +3914,7 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 		retval = grep_buffer(&opt->grep_filter,
 				     (char *)message, strlen(message));
 	strbuf_release(&buf);
-	unuse_commit_buffer(commit, message);
+	repo_unuse_commit_buffer(the_repository, commit, message);
 	return retval;
 }
 
diff --git a/sequencer.c b/sequencer.c
index d97923883ff..592b3d2875a 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -428,7 +428,8 @@ static int get_message(struct commit *commit, struct commit_message *out)
 	const char *abbrev, *subject;
 	int subject_len;
 
-	out->message = logmsg_reencode(commit, NULL, get_commit_output_encoding());
+	out->message = repo_logmsg_reencode(the_repository, commit, NULL,
+					    get_commit_output_encoding());
 	abbrev = short_commit_name(commit);
 
 	subject_len = find_commit_subject(out->message, &subject);
@@ -445,7 +446,7 @@ static void free_message(struct commit *commit, struct commit_message *msg)
 	free(msg->parent_label);
 	free(msg->label);
 	free(msg->subject);
-	unuse_commit_buffer(commit, msg->message);
+	repo_unuse_commit_buffer(the_repository, commit, msg->message);
 }
 
 static void print_advice(struct repository *r, int show_hint,
@@ -693,8 +694,8 @@ static int do_recursive_merge(struct repository *r,
 	o.show_rename_progress = 1;
 
 	head_tree = parse_tree_indirect(head);
-	next_tree = next ? get_commit_tree(next) : empty_tree(r);
-	base_tree = base ? get_commit_tree(base) : empty_tree(r);
+	next_tree = next ? repo_get_commit_tree(the_repository, next) : empty_tree(r);
+	base_tree = base ? repo_get_commit_tree(the_repository, base) : empty_tree(r);
 
 	for (i = 0; i < opts->xopts_nr; i++)
 		parse_merge_opt(&o, opts->xopts[i]);
@@ -772,7 +773,7 @@ static int is_index_unchanged(struct repository *r)
 	 * the commit is invalid, parse_commit() will complain.  So
 	 * there is nothing for us to say here.  Just return failure.
 	 */
-	if (parse_commit(head_commit))
+	if (repo_parse_commit(the_repository, head_commit))
 		return -1;
 
 	if (!(cache_tree_oid = get_cache_tree_oid(istate)))
@@ -1337,7 +1338,7 @@ void print_commit_summary(struct repository *r,
 	commit = lookup_commit(r, oid);
 	if (!commit)
 		die(_("couldn't look up newly created commit"));
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		die(_("could not parse newly created commit"));
 
 	strbuf_addstr(&format, "format:%h] %s");
@@ -1417,7 +1418,7 @@ static int parse_head(struct repository *r, struct commit **head)
 			warning(_("HEAD %s is not a commit!"),
 				oid_to_hex(&oid));
 		}
-		if (parse_commit(current_head))
+		if (repo_parse_commit(the_repository, current_head))
 			return error(_("could not parse HEAD commit"));
 	}
 	*head = current_head;
@@ -1460,8 +1461,9 @@ static int try_to_commit(struct repository *r,
 	if (flags & AMEND_MSG) {
 		const char *exclude_gpgsig[] = { "gpgsig", "gpgsig-sha256", NULL };
 		const char *out_enc = get_commit_output_encoding();
-		const char *message = logmsg_reencode(current_head, NULL,
-						      out_enc);
+		const char *message = repo_logmsg_reencode(the_repository,
+							   current_head, NULL,
+							   out_enc);
 
 		if (!msg) {
 			const char *orig_message = NULL;
@@ -1472,7 +1474,8 @@ static int try_to_commit(struct repository *r,
 			hook_commit = "HEAD";
 		}
 		author = amend_author = get_author(message);
-		unuse_commit_buffer(current_head, message);
+		repo_unuse_commit_buffer(the_repository, current_head,
+					 message);
 		if (!author) {
 			res = error(_("unable to parse commit author"));
 			goto out;
@@ -1669,12 +1672,12 @@ static int is_original_commit_empty(struct commit *commit)
 {
 	const struct object_id *ptree_oid;
 
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		return error(_("could not parse commit %s"),
 			     oid_to_hex(&commit->object.oid));
 	if (commit->parents) {
 		struct commit *parent = commit->parents->item;
-		if (parse_commit(parent))
+		if (repo_parse_commit(the_repository, parent))
 			return error(_("could not parse parent commit %s"),
 				oid_to_hex(&parent->object.oid));
 		ptree_oid = get_commit_tree_oid(parent);
@@ -2002,13 +2005,14 @@ static int update_squash_messages(struct repository *r,
 			return error(_("need a HEAD to fixup"));
 		if (!(head_commit = lookup_commit_reference(r, &head)))
 			return error(_("could not read HEAD"));
-		if (!(head_message = logmsg_reencode(head_commit, NULL, encoding)))
+		if (!(head_message = repo_logmsg_reencode(the_repository, head_commit, NULL, encoding)))
 			return error(_("could not read HEAD's commit message"));
 
 		find_commit_subject(head_message, &body);
 		if (command == TODO_FIXUP && !flag && write_message(body, strlen(body),
 							rebase_path_fixup_msg(), 0) < 0) {
-			unuse_commit_buffer(head_commit, head_message);
+			repo_unuse_commit_buffer(the_repository, head_commit,
+						 head_message);
 			return error(_("cannot write '%s'"), rebase_path_fixup_msg());
 		}
 		strbuf_addf(&buf, "%c ", comment_line_char);
@@ -2023,10 +2027,11 @@ static int update_squash_messages(struct repository *r,
 		else
 			strbuf_addstr(&buf, body);
 
-		unuse_commit_buffer(head_commit, head_message);
+		repo_unuse_commit_buffer(the_repository, head_commit,
+					 head_message);
 	}
 
-	if (!(message = logmsg_reencode(commit, NULL, encoding)))
+	if (!(message = repo_logmsg_reencode(the_repository, commit, NULL, encoding)))
 		return error(_("could not read commit message of %s"),
 			     oid_to_hex(&commit->object.oid));
 	find_commit_subject(message, &body);
@@ -2041,7 +2046,7 @@ static int update_squash_messages(struct repository *r,
 		strbuf_add_commented_lines(&buf, body, strlen(body));
 	} else
 		return error(_("unknown command: %d"), command);
-	unuse_commit_buffer(commit, message);
+	repo_unuse_commit_buffer(the_repository, commit, message);
 
 	if (!res)
 		res = write_message(buf.buf, buf.len, rebase_path_squash_msg(),
@@ -2215,7 +2220,7 @@ static int do_pick_commit(struct repository *r,
 		msg_file = NULL;
 		goto fast_forward_edit;
 	}
-	if (parent && parse_commit(parent) < 0)
+	if (parent && repo_parse_commit(the_repository, parent) < 0)
 		/* TRANSLATORS: The first %s will be a "todo" command like
 		   "revert" or "pick", the second %s a SHA1. */
 		return error(_("%s: cannot parse parent commit %s"),
@@ -3123,7 +3128,9 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 
 	while ((commit = get_revision(opts->revs))) {
 		struct todo_item *item = append_new_todo(todo_list);
-		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
+		const char *commit_buffer = repo_logmsg_reencode(the_repository,
+								 commit, NULL,
+								 encoding);
 		const char *subject;
 		int subject_len;
 
@@ -3135,7 +3142,8 @@ static int walk_revs_populate_todo(struct todo_list *todo_list,
 		subject_len = find_commit_subject(commit_buffer, &subject);
 		strbuf_addf(&todo_list->buf, "%s %s %.*s\n", command_string,
 			short_commit_name(commit), subject_len, subject);
-		unuse_commit_buffer(commit, commit_buffer);
+		repo_unuse_commit_buffer(the_repository, commit,
+					 commit_buffer);
 	}
 
 	if (!todo_list->nr)
@@ -3519,10 +3527,13 @@ static int make_patch(struct repository *r,
 	strbuf_addf(&buf, "%s/message", get_dir(opts));
 	if (!file_exists(buf.buf)) {
 		const char *encoding = get_commit_output_encoding();
-		const char *commit_buffer = logmsg_reencode(commit, NULL, encoding);
+		const char *commit_buffer = repo_logmsg_reencode(the_repository,
+								 commit, NULL,
+								 encoding);
 		find_commit_subject(commit_buffer, &subject);
 		res |= write_message(subject, strlen(subject), buf.buf, 1);
-		unuse_commit_buffer(commit, commit_buffer);
+		repo_unuse_commit_buffer(the_repository, commit,
+					 commit_buffer);
 	}
 	strbuf_release(&buf);
 	release_revisions(&log_tree_opt);
@@ -3989,7 +4000,9 @@ static int do_merge(struct repository *r,
 
 	if (commit) {
 		const char *encoding = get_commit_output_encoding();
-		const char *message = logmsg_reencode(commit, NULL, encoding);
+		const char *message = repo_logmsg_reencode(the_repository,
+							   commit, NULL,
+							   encoding);
 		const char *body;
 		int len;
 
@@ -4002,7 +4015,7 @@ static int do_merge(struct repository *r,
 		find_commit_subject(message, &body);
 		len = strlen(body);
 		ret = write_message(body, len, git_path_merge_msg(r), 0);
-		unuse_commit_buffer(commit, message);
+		repo_unuse_commit_buffer(the_repository, commit, message);
 		if (ret) {
 			error_errno(_("could not write '%s'"),
 				    git_path_merge_msg(r));
@@ -4585,7 +4598,7 @@ static int stopped_at_head(struct repository *r)
 
 	if (repo_get_oid(the_repository, "HEAD", &head) ||
 	    !(commit = lookup_commit(r, &head)) ||
-	    parse_commit(commit) || get_message(commit, &message))
+	    repo_parse_commit(the_repository, commit) || get_message(commit, &message))
 		fprintf(stderr, _("Stopped at HEAD\n"));
 	else {
 		fprintf(stderr, _("Stopped at %s\n"), message.label);
@@ -5042,13 +5055,15 @@ static int commit_staged_changes(struct repository *r,
 				const char *encoding = get_commit_output_encoding();
 
 				if (parse_head(r, &commit) ||
-				    !(p = logmsg_reencode(commit, NULL, encoding)) ||
+				    !(p = repo_logmsg_reencode(the_repository, commit, NULL, encoding)) ||
 				    write_message(p, strlen(p), path, 0)) {
-					unuse_commit_buffer(commit, p);
+					repo_unuse_commit_buffer(the_repository,
+								 commit, p);
 					return error(_("could not write file: "
 						       "'%s'"), path);
 				}
-				unuse_commit_buffer(commit, p);
+				repo_unuse_commit_buffer(the_repository,
+							 commit, p);
 			}
 		}
 
@@ -5925,7 +5940,7 @@ static int skip_unnecessary_picks(struct repository *r,
 			continue;
 		if (item->command != TODO_PICK)
 			break;
-		if (parse_commit(item->commit)) {
+		if (repo_parse_commit(the_repository, item->commit)) {
 			return error(_("could not parse commit '%s'"),
 				oid_to_hex(&item->commit->object.oid));
 		}
@@ -6258,12 +6273,15 @@ int todo_list_rearrange_squash(struct todo_list *todo_list)
 			return error(_("the script was already rearranged."));
 		}
 
-		parse_commit(item->commit);
-		commit_buffer = logmsg_reencode(item->commit, NULL, "UTF-8");
+		repo_parse_commit(the_repository, item->commit);
+		commit_buffer = repo_logmsg_reencode(the_repository,
+						     item->commit, NULL,
+						     "UTF-8");
 		find_commit_subject(commit_buffer, &subject);
 		format_subject(&buf, subject, " ");
 		subject = subjects[i] = strbuf_detach(&buf, &subject_len);
-		unuse_commit_buffer(item->commit, commit_buffer);
+		repo_unuse_commit_buffer(the_repository, item->commit,
+					 commit_buffer);
 		if (skip_fixupish(subject, &p)) {
 			struct commit *commit2;
 
diff --git a/shallow.c b/shallow.c
index 0fcdfd7d35a..1a2b159fd4e 100644
--- a/shallow.c
+++ b/shallow.c
@@ -247,7 +247,7 @@ struct commit_list *get_shallow_commits_by_rev_list(int ac, const char **av,
 		struct commit *c = p->item;
 		struct commit_list *parent;
 
-		if (parse_commit(c))
+		if (repo_parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
@@ -583,7 +583,7 @@ static void paint_down(struct paint_info *info, const struct object_id *oid,
 		if (c->object.flags & BOTTOM)
 			continue;
 
-		if (parse_commit(c))
+		if (repo_parse_commit(the_repository, c))
 			die("unable to parse commit %s",
 			    oid_to_hex(&c->object.oid));
 
diff --git a/t/helper/test-fast-rebase.c b/t/helper/test-fast-rebase.c
index 5d1284328d0..214612846ab 100644
--- a/t/helper/test-fast-rebase.c
+++ b/t/helper/test-fast-rebase.c
@@ -65,7 +65,8 @@ static struct commit *create_commit(struct tree *tree,
 	struct commit_extra_header *extra;
 	struct strbuf msg = STRBUF_INIT;
 	const char *out_enc = get_commit_output_encoding();
-	const char *message = logmsg_reencode(based_on, NULL, out_enc);
+	const char *message = repo_logmsg_reencode(the_repository, based_on,
+						   NULL, out_enc);
 	const char *orig_message = NULL;
 	const char *exclude_gpgsig[] = { "gpgsig", NULL };
 
@@ -156,7 +157,7 @@ int cmd__fast_rebase(int argc, const char **argv)
 	memset(&result, 0, sizeof(result));
 	merge_opt.show_rename_progress = 1;
 	merge_opt.branch1 = "HEAD";
-	head_tree = get_commit_tree(onto);
+	head_tree = repo_get_commit_tree(the_repository, onto);
 	result.tree = head_tree;
 	last_commit = onto;
 	while ((commit = get_revision(&revs))) {
@@ -167,8 +168,8 @@ int cmd__fast_rebase(int argc, const char **argv)
 		assert(commit->parents && !commit->parents->next);
 		base = commit->parents->item;
 
-		next_tree = get_commit_tree(commit);
-		base_tree = get_commit_tree(base);
+		next_tree = repo_get_commit_tree(the_repository, commit);
+		base_tree = repo_get_commit_tree(the_repository, base);
 
 		merge_opt.branch2 = short_commit_name(commit);
 		merge_opt.ancestor = xstrfmt("parent of %s", merge_opt.branch2);
diff --git a/tree.c b/tree.c
index 410e3b477e5..f0742f4167b 100644
--- a/tree.c
+++ b/tree.c
@@ -58,7 +58,7 @@ int read_tree_at(struct repository *r,
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
 
-			if (parse_commit(commit))
+			if (repo_parse_commit(the_repository, commit))
 				die("Invalid commit %s in submodule path %s%s",
 				    oid_to_hex(&entry.oid),
 				    base->buf, entry.path);
diff --git a/walker.c b/walker.c
index 99d0e0eae04..98d65a559b4 100644
--- a/walker.c
+++ b/walker.c
@@ -79,7 +79,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 {
 	struct commit_list *parents;
 
-	if (parse_commit(commit))
+	if (repo_parse_commit(the_repository, commit))
 		return -1;
 
 	while (complete && complete->item->date >= commit->date) {
@@ -93,7 +93,7 @@ static int process_commit(struct walker *walker, struct commit *commit)
 
 	walker_say(walker, "walk %s\n", oid_to_hex(&commit->object.oid));
 
-	if (process(walker, &get_commit_tree(commit)->object))
+	if (process(walker, &repo_get_commit_tree(the_repository, commit)->object))
 		return -1;
 
 	for (parents = commit->parents; parents; parents = parents->next) {
-- 
2.40.0.rc1.1034.g5867a1b10c5

